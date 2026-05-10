# Deck · GitHub Community Day Perú 2026

> **Worktrees + IA + CI: trabajo paralelo en una laptop**
> Demostración construida sobre **Tickets**, una aplicación de eventos open source.
> Stack del proyecto: **Backend** NestJS 11 + Apollo GraphQL + Supabase + Ticketmaster Discovery API. **Frontend** Flutter 3.11+ con Riverpod, GoRouter, Freezed y Dio.
> Repositorio: `github.com/Thirstypooch/tickets`

---

## 1. Worktrees: la función que Git tiene desde 2015

### El problema que resuelve

Cambiar de rama interrumpe procesos activos. El hot-reload se cae, los servidores locales se reinician, los watchers del editor se desincronizan, y el contexto mental se pierde. La secuencia típica `git stash` → `git checkout` → trabajar → `git checkout -` → `git stash pop` consume entre 1 y 3 minutos por salto. En una jornada con 10 cambios de contexto, son 20 a 30 minutos perdidos solo en operaciones de Git, sin contar el tiempo de recuperar el estado mental anterior.

### Qué es un worktree

Introducido en **Git 2.5 (julio de 2015)**, `git worktree` permite mantener múltiples directorios de trabajo enlazados al mismo repositorio. Una sola copia de la base de datos de objetos (`.git`), varios árboles de trabajo independientes en paralelo.

| Característica                  | Clone                          | Worktree                  |
|---------------------------------|--------------------------------|---------------------------|
| Espacio en disco                | Duplica `.git` (gigabytes)     | Comparte `.git`           |
| Sincronización entre copias     | Manual (`fetch`, `pull`)       | Automática                |
| Ramas distintas en simultáneo   | Sí                             | Sí                        |
| Misma rama en dos copias        | Permitido                      | Bloqueado por diseño      |
| Tiempo de creación              | Operación de red               | Operación local           |

En el worktree secundario, `.git` no es un directorio: es un archivo de texto plano cuyo contenido es `gitdir: /ruta/al/repo/principal/.git/worktrees/<nombre>`. La base de datos de objetos vive en un solo lugar.

### Tres comandos suficientes

```bash
# Crear un worktree nuevo con una rama nueva
git worktree add ../tickets-feat-share feat/share

# Listar todos los worktrees activos
git worktree list
# /Users/dev/tickets             abc1234 [main]
# /Users/dev/tickets-feat-share  def5678 [feat/share]

# Eliminar un worktree cuando ya no se necesita
git worktree remove ../tickets-feat-share
```

`add` crea el directorio físico y hace checkout de la rama indicada en una sola operación, sin tocar el directorio principal. `list` muestra ruta absoluta, hash del commit y rama de cada copia activa. `remove` elimina el directorio del filesystem y registra la baja en el repositorio principal, sin afectar la rama remota.

### Cuándo usar worktrees

| Casos a favor                                                      | Casos en contra                                            |
|--------------------------------------------------------------------|------------------------------------------------------------|
| Refactor extenso mientras se siguen mergeando hotfixes en `main`   | Cambios pequeños en archivos aislados (overhead innecesario)|
| Agentes de IA ejecutándose en paralelo, cada uno aislado           | Primer contacto con un repositorio (aprender ramas primero)|
| Probar una hipótesis sin contaminar el setup de desarrollo activo  | Equipos cuyo flujo no involucra Git                        |
| Mantener `main` listo para producción mientras se experimenta      | Una sola feature a la vez sobre el mismo conjunto de archivos|

---

## 2. IA: el segundo cerebro en otra terminal

### El patrón

La sesión principal mantiene el flujo activo: servidor corriendo, hot-reload conectado, depurador unido al proceso, contexto cargado en el editor. En paralelo, un agente de IA se ejecuta en un worktree separado, sobre una rama propia, en un directorio físicamente distinto. No comparten archivos abiertos, no compiten por el mismo `node_modules`, no rompen los watchers del IDE.

```bash
# Sesión principal: continúa en main, sin interrupciones
cd ~/tickets
# (servidor NestJS corriendo, hot-reload activo en Flutter)

# Sesión paralela: worktree dedicado a una tarea delegada a la IA
git worktree add ../tickets-ai-share feat/share-clipboard
cd ../tickets-ai-share
# (la IA edita aquí, sobre una copia aislada)
```

### Tareas que se delegan bien a una IA en paralelo

- **Refactors mecánicos**: renombrar símbolos en múltiples archivos, mover módulos, actualizar imports masivamente, migrar de una API antigua a una nueva con un patrón fijo.
- **Generación de código a partir de una especificación cerrada**: una pantalla nueva con bullets claros sobre el comportamiento esperado, un endpoint REST con su DTO de entrada y de salida, un formulario con validaciones definidas.
- **Scaffolding de tests**: pruebas unitarias para funciones puras, mocks para servicios con interfaces estables, casos de prueba a partir de un contrato.
- **Borradores de documentación**: README inicial, comentarios JSDoc o DartDoc, descripciones de endpoints OpenAPI, changelogs a partir de commits.
- **Transformaciones repetitivas**: actualizar 30 componentes de una librería antigua a una nueva, propagar un cambio de tipo a través de todos sus consumidores.

### Tareas que no se delegan

- **Decisiones de arquitectura**: qué base de datos elegir, qué patrón de estado adoptar, cómo separar contextos de dominio.
- **Tradeoffs entre alternativas**: cualquier decisión que requiera contexto del producto, del equipo, o del negocio que la IA no tiene.
- **Edición simultánea sobre los mismos archivos**: si la sesión principal está modificando `event_detail_screen.dart`, no es buena idea que la IA también lo esté tocando en paralelo.
- **Código que depende de información sensible**: claves, tokens, configuraciones internas que no deben formar parte del contexto del agente.

### Flujo de revisión

1. La IA termina la tarea y deja un commit en su rama dentro del worktree.
2. El desarrollador inspecciona el diff con `git diff` o desde la interfaz de Pull Request.
3. Si el cambio es aceptable, se hace push y se abre el PR contra `main`.
4. Si no, se descarta el worktree con `git worktree remove --force` y se ajusta el prompt para un siguiente intento.

La IA propone, el desarrollador decide. El worktree garantiza que una propuesta defectuosa no contamine el espacio de trabajo principal ni afecte la rama de producción.

---

## 3. CI: el tercer colega que nunca olvida

### El workflow real de este repositorio

Archivo: `.github/workflows/ci.yml`

```yaml
name: CI

on:
  pull_request:
    branches: [main]
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  backend:
    name: Backend - build (NestJS)
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: backend
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
          cache-dependency-path: backend/package-lock.json

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: npm run build

  flutter:
    name: Flutter - analyze
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: flutter
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: stable
          cache: true

      - name: Get packages
        run: flutter pub get

      - name: Run codegen (Freezed + Riverpod + JSON)
        run: dart run build_runner build --delete-conflicting-outputs

      - name: Analyze
        run: flutter analyze
```

### Qué hace cada parte

**Disparadores (`on`)**: el workflow se ejecuta automáticamente en cada Pull Request hacia `main`, en cada push directo a `main`, y manualmente bajo demanda mediante `workflow_dispatch`.

**Job `backend` (NestJS)**:
- `actions/checkout@v4` clona el código del Pull Request en el runner.
- `actions/setup-node@v4` instala Node.js 20 con caché habilitado sobre `package-lock.json` del backend, lo que reduce el tiempo de instalación en ejecuciones sucesivas.
- `npm ci` realiza una instalación reproducible y estricta a partir del lockfile, sin modificarlo.
- `npm run build` compila el proyecto NestJS con TypeScript. Si hay errores de tipo, importaciones rotas o referencias inválidas, el job falla y el PR queda marcado en rojo.

**Job `flutter`**:
- `subosito/flutter-action@v2` instala Flutter en canal estable con caché de toolchain.
- `flutter pub get` resuelve y descarga las dependencias declaradas en `pubspec.yaml`.
- `dart run build_runner build --delete-conflicting-outputs` regenera el código de Freezed (modelos inmutables), Riverpod (providers) y JSON serialization. Sin este paso, la siguiente etapa fallaría por símbolos faltantes.
- `flutter analyze` ejecuta el analizador estático de Dart sobre todo el proyecto. Falla ante errores, advertencias relevantes o uso de APIs deprecadas.

### Por qué esto es suficiente para empezar

El CI mínimo viable responde a una pregunta por proyecto: ¿el código está íntegro? Para el backend NestJS, esto significa que TypeScript compila sin errores. Para el frontend Flutter, que el analizador estático no encuentra problemas. Esa pregunta atrapa la mayoría de los Pull Requests rotos: importaciones inexistentes, errores de tipo, referencias a símbolos eliminados, dependencias desactualizadas, archivos faltantes.

Tests unitarios, lint estricto, deployments automáticos, escaneos de seguridad y pruebas end-to-end son capas adicionales que se incorporan en etapas posteriores. Un proyecto sin CI no se mejora agregándole 12 jobs el primer día; se mejora poniendo el job más simple posible y observando empíricamente qué clase de defectos aparecen primero.

### Resultado visible en cada PR

GitHub muestra el estado consolidado de los checks junto al botón de merge: **verde** si todos los jobs pasaron, **rojo** si alguno falló, **amarillo** mientras la ejecución está en curso. La revisión humana llega después de que la verificación mecánica haya completado su pasada. Mergear con un check rojo es una decisión deliberada, no un descuido.

---

## Cierre

Tres herramientas que ya están disponibles sin instalar nada nuevo o sin costo significativo:

1. **`git worktree`** — incluido en cualquier instalación de Git desde la versión 2.5 (2015). Cero dependencias adicionales.
2. **Una IA capaz de editar código** — múltiples plataformas con planes gratuitos o de bajo costo, integradas a la línea de comandos o al editor.
3. **GitHub Actions** — gratuito para repositorios públicos, con minutos generosos en el plan free para repositorios privados.

El multiplicador no está en cada herramienta por separado. Está en orquestarlas para que tres procesos avancen en paralelo sobre el mismo repositorio: la sesión principal del desarrollador, una IA en otro worktree, y el CI verificando cada commit en la nube.

**Repositorio del proyecto demostrado**: `github.com/Thirstypooch/tickets`
