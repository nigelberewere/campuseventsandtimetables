# UX Team Handoff

This document explains where we left the interface work, what each team now owns, and how the rest of the app should be carried forward from here.

## Working Rules

- Create a new branch before you start work.
- Do not work directly on `main`.
- Commit in small, readable chunks.
- Open a PR, review it, then merge.
- Keep UI, backend, and database changes separate unless a task clearly needs both.

## What We Have Built So Far

The main app files live in `lib/`.

- `lib/main.dart` holds the app theme and named route setup.
- `lib/pages/landing.dart` is only a short welcome screen that sends users to login or sign up.
- `lib/pages/login.dart` and `lib/pages/signup.dart` handle the auth UI.
- `lib/pages/home.dart` is the student dashboard.
- `lib/pages/events.dart` is the events screen.
- `lib/pages/timetables.dart` is the timetable screen.
- `lib/pages/profile.dart` is the profile screen.
- `lib/pages/notifications.dart` is the notifications screen.
- `lib/pages/admin.dart` is the admin dashboard.
- `lib/pages/manage_notifications.dart` is the admin notification-management page.
- `lib/pages/manage_users.dart` is the admin user-management page.
- `lib/pages/addEvent.dart` and `lib/pages/addClass.dart` handle create flows for events and classes.
- `lib/widgets/app_drawer.dart` contains the shared navigation drawer.
- `lib/constants/app_colors.dart` contains the shared theme colors.

## Ownership Matrix

### 1. Product & UI/UX + Frontend Pair

**Owns:** App design, visual system, main user interface, navigation structure.

**We commit:**
- Wireframes or screenshots from Figma.
- UI code for screens and layouts.
- App navigation shell and route structure.
- Reusable UI components and design consistency.

**What this means in this repo:**
- Keep the landing, login, signup, home, profile, notifications, timetable, and drawer experience consistent.
- Make sure the app looks cohesive on mobile and web.
- Keep the navigation flow simple and predictable.

**What we left for the rest of you:**
- Keep polishing the shared drawer and page styling.
- Replace any remaining placeholder UX copy when the real feature is ready.
- Remove mock profile values when backend data is available.
- Keep the landing page limited to a short welcome plus login and sign up entry points.

**Extra responsibility:**
- One of you acts as Project Coordinator.
- That person helps manage merges and keeps staff updated on progress.
- That person still codes so their commits are visible.

### 2. Events Feature Team (Frontend + Backend)

**Owns:** The full events system end to end.

**You commit:**
- Event list UI.
- Event creation and edit screens.
- Backend APIs for events.
- Filtering and search logic.

**Repo touchpoints:**
- `lib/pages/events.dart`
- `lib/pages/addEvent.dart`

**Current state from our side:**
- Event UI exists.
- Event creation currently returns local data back to the events page.
- Search and deeper persistence still need backend support.

**What to carry forward:**
- Connect events to persistent storage.
- Replace temporary local event handling with real APIs.
- Keep the event card layout and filtering behavior stable.

### 3. Timetable Feature Team (Frontend + Backend)

**Owns:** The student timetable system.

**You commit:**
- Timetable UI in list or calendar form.
- Add and edit class screens.
- Backend logic for storing schedules.

**Repo touchpoints:**
- `lib/pages/timetables.dart`
- `lib/pages/addClass.dart`

**Current state from our side:**
- Timetable screen exists.
- Add class flow exists.
- Schedule storage is still local UI logic.

**What to carry forward:**
- Connect timetable data to the backend.
- Add persistence for classes and schedule changes.
- Keep the timetable UX easy to read on small screens.

### 4. Backend Core + Database Pair

**Owns:** The system backbone.

**You commit:**
- Database schema.
- Authentication logic.
- API routes and controllers.

**Repo touchpoints:**
- `lib/pages/login.dart`
- `lib/pages/signup.dart`
- Any future backend service or API project.

**Current state from our side:**
- Login and sign up screens are still UI-first.
- Persistent storage is not connected yet.

**What to carry forward:**
- Implement real auth and storage.
- Replace hardcoded account values and mock flows.
- Provide the API contract early so the UI team can wire screens cleanly.

### 5. Notifications + QA + DevOps Pair

**Owns:** Reliability, testing, release support, and notification delivery.

**You commit:**
- Notification system and reminders.
- Test scripts and bug fixes.
- GitHub workflows and CI/CD.
- Documentation.

**Repo touchpoints:**
- `lib/pages/notifications.dart`
- `lib/pages/admin.dart`
- `lib/pages/manage_notifications.dart`
- `lib/pages/manage_users.dart`
- The admin flow that exposes notification management.

**Current state from our side:**
- Notifications screen exists.
- Admin dashboard exists.
- Baseline Manage Notifications and Manage Users pages are now in place and routed from Admin.

**What to carry forward:**
- Connect Manage Notifications and Manage Users pages to backend APIs.
- Add role-based actions (approve, suspend, broadcast, template CRUD).
- Add tests for critical flows.
- Keep CI and release automation active.
- Fix bugs as part of normal work, not as a separate cleanup phase.

## What We Also Handled For The UI Pair

Based on `tasks.txt` and the repo, we were not only supposed to write screen code. We were also expected to:

- Produce wireframes or visual references.
- Own the navigation structure.
- Keep the app shell and page layout consistent.
- Coordinate the project while still contributing visible UI commits.

So the extra UI work is not just "screens". It also includes the way users move through the app and how the experience feels from page to page.

## Current UI Notes

A few UI-only placeholder pieces still exist and are normal for this stage:

- `lib/pages/profile.dart` still has mock student data that should be replaced once backend data is ready.
- `lib/pages/profile.dart` still has temporary snackbar actions for Edit Profile and Change Password.
- `lib/pages/events.dart` still has a temporary search placeholder.
- The landing page is intentionally small and only routes users to login or sign up.
- Admin now routes to working Manage Notifications and Manage Users screens for handoff.

## Recommended Next Steps

- Events team: connect events to persistence and search.
- Timetable team: connect class schedules to storage.
- Backend team: implement auth and API persistence.
- Notifications team: build the manage notifications flow and keep QA/CI active.

## File Ownership Reminder

If you change a screen, update the related route or shared navigation only if needed.
If you add a new screen, register it in `lib/main.dart` and add it to the shared drawer if it should be reachable from the app shell.
