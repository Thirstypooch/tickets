# Deck · GitHub Community Day Perú 2026

> **Cómo un dev solo se vuelve un equipo de tres**
> Live demo con `git worktree` + Claude Code + GitHub Actions
>
> ⏱ 25 min charla + 5 min Q&A · 📅 6 jun 2026 · 📍 UTP Lima Centro

---

## Cómo usar este archivo

1. Abrí Keynote · "File → New" · Theme **"Modern Type"** o **"Black"** (fondos negros + texto grande funcionan mejor en proyector)
2. Por cada `## Slide N` de abajo: **nuevo slide** en Keynote, copiá el contenido tal cual
3. Las **Notas del speaker** van en la sección "Presenter Notes" de Keynote (View → Show Presenter Notes)
4. Los SVGs de la carpeta `talk/diagrams/` los arrastrás a los slides 5, 7 y 12

### Branding sugerido
- Color acento: `#4F46E5` (indigo brand del proyecto)
- Tipografía: SF Pro Display Black (built-in macOS)
- Fondo: negro `#0A0A0A` con texto blanco — máximo contraste en proyector
- Code blocks: SF Mono, fondo gris oscuro `#262626`

---

## Slide 1 · Hook (00:00 → 00:45)

**Título grande, centrado:**
> **Soy un dev solo.**

**Subtítulo, debajo en gris claro:**
> Pero hoy somos tres.

**Visual:** tres íconos grandes en fila horizontal (centrados):
- 🧑‍💻 (humano) — vos
- 🤖 (robot) — Claude
- ⚙️ (engranaje) — GitHub Actions

**Notas del speaker:**
> Pausa de 3 segundos antes de hablar. Mirá al público. "¿Cuántos de ustedes tienen un compañero de trabajo? Levanten la mano." [pausa]
> "¿Y cuántos están construyendo algo solos en este momento?" [pausa]
> "Yo también. Pero hoy les voy a mostrar cómo, sin contratar a nadie, mi laptop trabaja como tres personas al mismo tiempo. Vamos."

⏱ Tiempo objetivo: **45 segundos**

---

## Slide 2 · Quién soy (00:45 → 01:30)

**Título:** [TU NOMBRE]

**Bullets (texto mediano, izquierda):**
- Dev [stack — ej: TypeScript / Flutter] · [empresa o "construyo cosas"]
- Construyo **Tickets**, una app de eventos open-source
- En GitHub: **@Thirstypooch**

**Visual:** foto tuya, mediana, esquina derecha. Si tenés una con la pantalla atrás (typesetting algo), mejor.

**Notas del speaker:**
> 30 segundos máximo. No te alargues con tu CV — la gente vino por el contenido, no por tu LinkedIn. Mostrá tu nombre, dónde te pueden encontrar, y movete.

⏱ Tiempo objetivo: **45 segundos**

---

## Slide 3 · Plan de hoy (01:30 → 02:30)

**Título:** Plan de hoy

**Lista numerada, grande:**
1. El dolor sin worktrees · 2 min
2. Worktrees en 90 segundos · 2 min
3. **🔥 Live demo: feature en 8 minutos** _(este texto en indigo)_
4. Cuándo SÍ, cuándo NO · 3 min
5. El Action que valió la pena · 3 min

**Footer pequeño:**
> Si la wifi falla, tengo backup grabado. Sin pánico.

**Notas del speaker:**
> "El 60% del tiempo es demo en vivo. Si algo falla, tengo backup grabado. Si no, mejor."
> Frase clave: "Vamos a usar herramientas de git que ya tienen instaladas y nunca usaron."

⏱ Tiempo objetivo: **60 segundos**

---

## Slide 4 · El dolor (02:30 → 04:00)

**Título:** Esto te ha pasado:

**Visual principal — captura de terminal con error en rojo:**
```
$ git checkout feat/new-thing
error: Your local changes to the following files
would be overwritten by checkout:
  src/api/users.ts
Please commit your changes or stash them
before you switch branches.
Aborting
```

**Texto debajo, grande:**
> _"Stash. Cambiar branch. Stash pop. Conflict. ¿Dónde estaba?"_

**Bullets pequeños, grises:**
- 😩 Hot-reload corriendo en una rama
- 😩 Querés probar algo en otra
- 😩 Stash. Cambia. Stash pop. Conflict.
- 😩 ¿Dónde estaba el contexto mental?

**Notas del speaker:**
> Pregunta retórica al público: "¿Cuántos conocen este error?" — show of hands. 80% va a levantar la mano.
> Ahora subí el dolor: "Ahora imaginate que estás corriendo Flutter, debugging con prints, y querés probar UN cambio en otra rama. Stash interrumpe el dart-runner. Volver toma 2 minutos. Multiplicalo por 10 veces al día. Eso es media hora por día perdida en context switching."
> Pausa. "Hay una solución que tiene git desde 2015 y casi nadie usa."

⏱ Tiempo objetivo: **90 segundos**

---

## Slide 5 · La idea (04:00 → 05:30)

**Título:** Un `.git`. Varios working trees.

**Visual principal:** Insertá `talk/diagrams/worktree-model.svg`

**Texto debajo del diagrama, mediano:**
> Mismo repo. Misma history. **N copias trabajando en paralelo.**

**Notas del speaker:**
> Subrayá "compartido" cuando hables del .git. Eso es lo nuevo conceptual.
> "Lo que ven es UN solo repo desde el punto de vista de git. Pero tres directorios distintos en disco. Cada uno tiene su branch checkeado independientemente. Cuando hago commit en uno, el .git lo recibe igual que si fuera la copia principal."
> "Esto no es un fork. No es un clone. Es worktree."

⏱ Tiempo objetivo: **90 segundos**

---

## Slide 6 · Tres comandos (05:30 → 07:00)

**Título:** Lo que vas a usar

**Code block grande, monoespaciado:**
```bash
# Crear nueva worktree con branch nueva
git worktree add ../tickets-feat-share feat/share

# Listar todas tus worktrees
git worktree list

# Borrar cuando terminaste
git worktree remove ../tickets-feat-share
```

**Bullets debajo, pequeños:**
- 🟢 `add` — crea directorio nuevo + branch nueva
- 🔵 `list` — te dice dónde está cada copia
- 🔴 `remove` — limpia (no afecta el branch en remote)

**Footer pequeño:**
> Hay 5 comandos más. Los primeros 6 meses no los necesitás.

**Notas del speaker:**
> "No memoricen más que esto. Tres comandos. Aprenden los otros cinco cuando los necesiten."
> Acentuá: "El `add` crea Y checkea — no es un clone separado. Comparte el .git."
> Si te sobra tiempo: "Para borrar el branch además del worktree, agregás `--force`. Pero por ahora, manténganlo simple."

⏱ Tiempo objetivo: **90 segundos**

---

## Slide 7 · Pivot a demo · Tickets en 30s (07:00 → 08:30)

**Título:** Vamos a la terminal

**Visual:** screenshot del simulador con Tickets corriendo (home con cards de eventos)

**Subtítulo, indigo:**
> Feature: **"Compartir copia el link al portapapeles"**

**Bullets cortos:**
- 🎯 5 líneas de código
- 🎯 No depende de red ni APIs externas
- 🎯 El foco es el _workflow_, no el código

**Notas del speaker:**
> "Tickets es una app de eventos. Trae datos en vivo de Ticketmaster. La van a poder clonar."
> "Hoy le agrego una mini-feature: cuando toques 'Compartir', en vez de mostrar el URL en un snackbar feo, lo copiamos al clipboard."
> "5 líneas. El foco no es el código. Es CÓMO trabajamos."
> Antes de cambiar a la terminal: respirá hondo, pasá la presentación a "modo siguiente slide automático" o pausala.

⏱ Tiempo objetivo: **90 segundos**

---

## Slides 8 → 10 · DEMO LIVE (08:30 → 16:30)

> **Estos slides son placeholders.** Durante este tramo, vos hacés screen-share de la terminal + simulator + browser. Las slides quedan en pausa o muestran un cronómetro mental.

### Slide 8 · "Demo en curso"
**Centro de pantalla, grande:**
> 🎬 **Demo en vivo**

**Footer pequeño:**
> Volvemos en ~8 minutos

**Notas del speaker — guion del demo (memorízalo):**
```
1. [00:00] — Mostrar tres terminales abiertas en tmux
            "Acá está el repo principal en main. Flutter está corriendo."

2. [00:30] — git worktree add ../tickets-feat-share feat/share
            "Creo una worktree nueva. Branch nueva, directorio nuevo."

3. [01:00] — cd ../tickets-feat-share
            "Mismo .git, otro working dir."
            ls .git    # mostrar que es un FILE, no directory

4. [01:30] — Pego el prompt a Claude Code en otra terminal:
            "En lib/presentation/screens/events/event_detail_screen.dart,
             el botón Compartir muestra un SnackBar con el URL.
             Cambiarlo: copiar el URL al clipboard con Clipboard.setData,
             y mostrar SnackBar 'Link copiado'. Importar services.dart"

5. [03:00] — Mientras Claude piensa, vuelvo a la otra terminal:
            "Mientras Claude codea, yo sigo en main. Hot-reload sigue vivo."
            [navegás por la app]

6. [04:00] — Claude termina. Review del diff:
            git diff
            "Cinco líneas. Acepto."

7. [05:00] — git add, commit, push:
            git add lib/presentation/screens/events/event_detail_screen.dart
            git commit -m "Copy share URL to clipboard"
            git push -u origin feat/share

8. [06:00] — Browser: abrir el PR
            gh pr create --base main --title "Copy share URL to clipboard" --body "..."

9. [06:30] — Mostrar Action corriendo (o si ya pasó, screencap acelerado)
            "Mientras la Action corre, sigo trabajando."

10. [07:30] — Action verde. Merge.
             gh pr merge --squash --delete-branch

11. [08:00] — Volver a main, pull, hot-reload
              cd ../tickets
              git pull
              [tocar Compartir en el simulator]
              "Funciona."
```

**Plan B (si algo falla):**
> Si llegaste a 12 min sin haber mostrado el merge → cortá al video grabado. Decí: "Por velocidad les muestro el resto grabado." Sin disculparte. La gente entiende.

### Slide 9 · Pausa de respiración (si la usás)
**Centro:**
> 🎯 **3 minutos restantes de demo**

**Footer:**
> Si te perdiste el contexto, mirá tu teléfono o estirá los brazos.

### Slide 10 · PR pasando verde
**Si tenés tiempo, antes de cerrar el demo, pegá una captura de:**
- El PR con check verde de la Action
- Caption: "Mientras yo hablaba, esto corrió en CI."

⏱ Tiempo objetivo total para slides 8-10: **8 minutos**

---

## Slide 11 · Cuándo SÍ, cuándo NO (16:30 → 19:30)

**Título:** Worktrees: cuándo usarlos

**Layout: dos columnas**

**Columna izquierda (verde, ✅ títulos):**
> **SÍ valen la pena**
- ✅ Refactor grande mientras seguís fixing en main
- ✅ AI agents en paralelo, cada uno aislado
- ✅ Probar una idea wild sin contaminar tu setup
- ✅ Mantener un build "production-ready" en main mientras experimentás

**Columna derecha (gris, ❌ títulos):**
> **NO son la respuesta**
- ❌ Tareas chicas en archivos disjuntos (overkill)
- ❌ Tu primer día con un repo (aprendé branch primero)
- ❌ Cuando trabajás en una sola feature a la vez
- ❌ Cuando tu equipo no usa git

**Notas del speaker:**
> "Worktrees son una herramienta. Como toda herramienta, mal usada estorba."
> Da un ejemplo concreto del NO: "Si solo tenés que arreglar un typo, no necesitás una worktree. `git stash`, `git checkout`, fix, `git checkout -`, `git stash pop`. Más rápido."
> Pero el SÍ: "Cuando estás haciendo una refactor que toca 30 archivos y querés seguir mergeando bug fixes en main mientras tanto — worktree salva tu sanidad."

⏱ Tiempo objetivo: **3 minutos**

---

## Slide 12 · El Action que vale la pena (19:30 → 22:30)

**Título:** 15 líneas. CI en cada PR.

**Code block grande:**
```yaml
name: CI

on:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  backend:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: backend
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run build
```

**Texto debajo, mediano:**
> Resultado: tu PR muestra ✅ o ❌ antes que merges.

**Visual:** screenshot de un PR con Action verde + screenshot de un PR rojo (lado a lado)

**Notas del speaker:**
> "Esto es el Action más simple del mundo. Hace UNA cosa: chequea que el código compila. Punto."
> "No tests todavía. No deploy. Solo: ¿buildea?"
> "Y eso ya te ahorra el 80% de los PRs rotos que se hacen merge porque alguien olvidó correr `npm run build` antes."
> Storyline: "Empezá con esto. Después agregás tests, después linting, después deploy. Pero si arrancás con esto YA, tu equipo de 3 (vos + Claude + Actions) está completo."
> Frase clave: "Tu Action es tu colega más confiable. Nunca olvida correr el check."

⏱ Tiempo objetivo: **3 minutos**

---

## Slide 13 · Cierre (22:30 → 24:30)

**Título grande:**
> El repo es tuyo.

**Bullets:**
- 🐙 **github.com/Thirstypooch/tickets**
- 🍴 Cloná, experimentá, **rompelo**
- 🐛 Si encontrás un bug, abrime un issue
- ⭐ Si te sirvió, dejá una estrella

**Visual grande, derecha:** QR code apuntando al repo (generá en https://qr.io/ o similar)

**Footer pequeño:**
> Las charlas terminan, los repos quedan.

**Notas del speaker:**
> Cerrá fuerte. "Lo que vieron hoy no es magia. Son tres comandos de git, una IA, y 15 líneas de YAML."
> "Si están construyendo algo solos, dejen que su laptop trabaje como tres personas. Cloñen el repo, leán los commits, vean cómo está hecho."
> "Gracias. ¿Preguntas?"
> Apagá micrófono, esperá las preguntas, no llenes el silencio.

⏱ Tiempo objetivo: **2 minutos**

---

## Q&A · 24:30 → 30:00

**Preguntas que probablemente te van a hacer (preparate respuestas cortas):**

1. **"¿Cuál AI usaste?"**
   > Claude Code de Anthropic. Pero los principios funcionan con Copilot, Cursor, Aider, lo que sea.

2. **"¿Cuánto te cuesta?"**
   > Plan Pro de Claude, ~$20/mes. Para uso intenso, hay tier mayor. Lo amortizo en horas ahorradas.

3. **"¿No es trampa?"**
   > Trampa contra qué. Yo dirijo, la IA ejecuta, yo verifico. Es un equipo. El paradigma cambió.

4. **"¿Y si la IA mete un bug?"**
   > Mete bugs. Por eso tenés CI, tests, code review. La diferencia con un dev junior es que la IA itera más rápido cuando le decís qué falló.

5. **"¿Por qué worktrees y no clones?"**
   > Clones duplican `.git` (gigas). Worktrees comparten. Y mantener varios clones sincronizados es manual; con worktrees es automático.

6. **"¿Funciona en Windows?"**
   > Sí. Worktrees son cross-platform.

7. **"¿Qué pasa si modifico el mismo archivo en dos worktrees?"**
   > Cada worktree es independiente. Mergéas vía PR como con cualquier branch.

---

## Checklist pre-charla (semana del 1-5 jun)

- [ ] Practice run × 5 con cronómetro (objetivo: 25 min ± 2)
- [ ] Practice run con un colega que te corte cuando algo no se entienda
- [ ] Backup video del demo grabado en buena calidad (1080p mínimo)
- [ ] Backup branch en GitHub: `demo-fallback` con la feature ya hecha
- [ ] Probá HDMI con un proyector real (cualquier sala con TV grande sirve)
- [ ] Lleva: cable HDMI propio + adaptador USB-C → HDMI + USB-C → VGA (por si acaso)
- [ ] Tu laptop a media batería (cargada) y cargador a mano
- [ ] WiFi del venue confirmado de antemano (si no, usás hotspot del celular como respaldo)
- [ ] Slides en PDF como triple-backup (si Keynote no abre)
- [ ] Tu prompt para Claude pre-armado en un archivo `.txt` listo para `cat | pbcopy`
- [ ] Tu terminal con font size grande (Menlo 18+ mínimo, Menlo 24 ideal)
- [ ] tmux configurado con 3 panes para el demo
- [ ] Modo "no molestar" activo en macOS (sin notifications visibles)

---

## Día D · checklist morning of

- [ ] Llegar 60 minutos antes
- [ ] Probar HDMI + audio
- [ ] Cargar el simulator + abrir la app antes de empezar
- [ ] Cerrar Slack, Discord, mail, Chrome, todo lo no necesario
- [ ] Stage Manager con cronómetro privado
- [ ] Botella de agua a mano
- [ ] Respirar 5 veces antes de subir
