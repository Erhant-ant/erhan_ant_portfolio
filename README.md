# Erhan Ant Portfolio

A bilingual personal portfolio built for the web. It presents my background in IT and software, current learning, selected projects, and professional profiles.

## Live Site

[Open the portfolio](https://erhant-ant.github.io/erhan_ant_portfolio/)

## Highlights

- English and Turkish interface with saved language preference
- Light and dark themes with saved preference
- Responsive layout for mobile and desktop screens
- Categorized GitHub project gallery with animations
- Case study showcase for key projects
- CV summary and PDF download
- Professional profile links (GitHub, LinkedIn)
- GitHub Pages deployment through GitHub Actions

## Tech Stack

- Dart & Material 3
- `flutter_animate` for micro-animations
- `go_router` for URL-based navigation
- `google_fonts` for Inter typography
- `shared_preferences` for local settings
- `url_launcher` for external links
- GitHub Actions & GitHub Pages

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
