# Github_Community_Day — Project Context for Claude

## What this project is
A monorepo for an **events / ticketing** application:
- `backend/` — **NestJS 11** API with **Apollo GraphQL**, integrating **Supabase** (auth + DB) and the **Ticketmaster Discovery API** (live event data).
- `flutter/` — **Flutter** mobile/web client using Riverpod, GoRouter, Freezed, Dio.

Git remote: `git@github.com:Thirstypooch/tickets.git` (branch `main`).

## Origin and migration history (important)
- This project was originally developed at `/Volumes/code/tickets` on an **external drive**.
- The drive became unstable (intermittent ASCII corruption while files were in use), so on **2026-05-09** the project was migrated to this Mac at `/Users/thirstypooch/Github_Community_Day`.
- The migration excluded regenerable artifacts (`node_modules`, `dist`, `build`, `.dart_tool`, `Pods`, `.gradle`, `.idea`). Source, git history, manifests, and lockfiles were preserved.
- Prior Claude Code conversation logs for this project are **not on this machine** — they were in the original development environment. This `CLAUDE.md` is a reconstruction from code + git history, not transcripts.

## Naming caveat — pivot from "CRIBS"
The project was originally a property-rental app codenamed **CRIBS**, then pivoted to events/ticketing (commit `e4d7b98` — "Pivot Flutter app from property rentals to events/ticketing"). Internal package names were **not renamed** after the pivot:
- `backend/package.json` → `"name": "cribs-backend"`
- `flutter/pubspec.yaml` → `name: cribs_flutter`, `description: "CRIBS - Premium Property Rental Platform"`
- Some helper files (e.g. `cribs_flutter.iml`) still carry the old name.

When working on the project: **treat it as ticketing/events**, not rentals. Don't "fix" the cribs naming unless explicitly asked — the user is aware.

## Backend (`backend/`)
**Stack**: NestJS 11, Apollo Server 5, GraphQL 16, Supabase JS client, Axios + cache-manager, class-validator.

**Modules** (under `src/`):
- `auth/` — Supabase-backed auth (controller + service + module).
- `users/` — user profile management.
- `events/` — event listing/detail, GraphQL resolver + REST controller.
- `bookings/` — ticket bookings (resolver, service, DTOs, models).
- `favorites/` — saved events per user.
- `reviews/` — event reviews.
- `dashboard/` — aggregated stats (resolver + service + model).
- `ticketmaster/` — wraps the Ticketmaster Discovery API; has `service`, `transformer` (maps TM payloads to internal models), and `types`.
- `supabase/` — Supabase client provider/module.
- `common/` — `current-user` decorator and `supabase-auth.guard.ts`.

**Entry**: `src/main.ts` → `app.module.ts`. GraphQL schema auto-generated to `src/schema.gql`.

**Run**:
```bash
cd backend
npm install
npm run start:dev   # watch mode
```

**Env** (`backend/.env`, gitignored — already present in this copy, migrated byte-identical from the external drive). Variables actually used (per `src/config/configuration.ts`):
- `TM_API_KEY`, `TM_BASE_URL` (Ticketmaster — note the `TM_` prefix, not `TICKETMASTER_`)
- `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY`
- `PORT`, `NODE_ENV`, `CACHE_TTL`
- `.env.example` is committed and shows the expected shape.

## Flutter app (`flutter/`)
**Stack**: Flutter SDK ^3.11.1; Riverpod (+ codegen), GoRouter, Freezed, json_serializable, Dio, Google Fonts, Lucide icons, cached_network_image, photo_view, shimmer, flutter_animate.

**Layout** (under `lib/`):
- `main.dart`, `app.dart` — entry + root widget.
- `core/` — `api/api_client.dart` (Dio wrapper), `router/app_router.dart` (GoRouter), `theme/`, `constants/`, `utils/` (booking/currency/date helpers).
- `data/` — `models/` (Freezed), `repositories/` (real API + mock variants — `api_event_repository.dart` / `mock_event_repository.dart` etc.), `datasources/mock_*` for offline/dev.
- `presentation/providers/` — Riverpod providers per feature (auth, bookings, dashboard, events, search, theme).
- `presentation/screens/` and `presentation/widgets/` — UI.

**Run**:
```bash
cd flutter
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # for Freezed/Riverpod codegen
flutter run
```

The Flutter client points at the live backend (commit `358e188` connected it to Ticketmaster via the NestJS API).

## What needs to be set up after the migration
1. `backend/`: `npm install`. **`.env` is already present** (copied byte-identical from the external drive — verified via md5 on 2026-05-09).
2. `flutter/`: `flutter pub get`, then `dart run build_runner build --delete-conflicting-outputs` for Freezed/Riverpod codegen.
3. Optional: `git remote -v` already points to GitHub — `git pull` if upstream has new commits.
4. Optional sanity-check: confirm Supabase project + Ticketmaster key still work (they may have rotated since 2026-03-29, the date of the last commit).

## Recent work / known issues from git history
- `cd71f99` — search dialog now wires to `eventFilterProvider`; replaced `ElevatedButton` with `MaterialButton` to avoid a `TextStyle.lerp` crash from Google Fonts inherit-mismatch; dashboard tabs replaced with stateful segmented control to avoid GlobalKey conflict + 99602px overflow; LA destination image URL fixed; Login/SignUp removed from header (auth not demo-ready).
- `09d845e` — auth flow auto-confirms users + ensures `display_name` on profile.
- Last commit dated 2026-03-29 — work is fresh, not stale.

## Conventions worth knowing
- Commits follow a "Fix X, Y, Z" or "Add X" style with detailed bullet-point bodies. Co-authored with `Claude Opus 4.6 (1M context)`.
- Both halves of the monorepo can run independently for development.
- The repo uses two parallel repository implementations (real + mock) on the Flutter side — useful when backend or Ticketmaster is unavailable.
