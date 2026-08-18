# Erhan Ant Portfolio

A bilingual personal portfolio built with Flutter for the web. It presents my background in IT and software, current learning, selected projects, and professional profiles.

## Live Site

[Open the portfolio](https://erhant-ant.github.io/erhan_ant_portfolio/)

## Highlights

- English and Turkish interface with saved language preference
- Light and dark themes with saved preference
- Responsive layout for mobile and desktop screens
- Project case study for the SupportDesk IT ticket tracker
- CV download and professional profile links
- GitHub Pages deployment through GitHub Actions

## Tech Stack

- Flutter and Dart
- Material 3
- `shared_preferences` for local settings
- `url_launcher` for external profile and project links
- GitHub Actions and GitHub Pages

## Run Locally

```bash
flutter pub get
flutter run -d chrome
```

## Run Checks

```bash
flutter analyze
flutter test
```

## Deployment

Every push to `main` builds the web app and deploys it to GitHub Pages. The workflow is defined in [`.github/workflows/main.yml`](.github/workflows/main.yml).

## Related Project

[SupportDesk IT Ticket Tracker](https://github.com/Erhant-ant/it_support_ticket_tracker) is a bilingual Flutter application for recording, prioritizing, and tracking IT support requests.
