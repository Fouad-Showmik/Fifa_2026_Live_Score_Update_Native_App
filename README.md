<div align="center">

# ⚽ FIFA 2026 Live Score Update

### Real-time World Cup scores, fixtures, groups & teams — right in your pocket

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/State-Riverpod-1B1B1B?style=for-the-badge)](https://riverpod.dev)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

[![Downloads](https://img.shields.io/github/downloads/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App/total?style=for-the-badge&color=success&label=Downloads&cachebust=1)](https://github.com/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App/releases/download/v1.0.0/LiveScore-1.0.0.apk)
[![Latest Release](https://img.shields.io/github/v/release/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App?style=for-the-badge&color=blue)](https://github.com/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App/releases/latest)
[![Stars](https://img.shields.io/github/stars/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App?style=for-the-badge&color=orange)](https://github.com/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App/stargazers)
[![Issues](https://img.shields.io/github/issues/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App?style=for-the-badge&color=red)](https://github.com/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App/issues)

<br/>

**[⬇️ Download APK](https://github.com/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App/releases/download/v1.0.0/LiveScore-1.0.0.apk)** &nbsp;•&nbsp;
**[📖 Getting Started](#-getting-started)** &nbsp;•&nbsp;
**[🐛 Report Bug](https://github.com/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App/issues)** &nbsp;•&nbsp;
**[✨ Request Feature](https://github.com/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App/issues)**

</div>

<br/>

---

## 📲 Download

<div align="center">

### Tap below to download the latest APK directly — no extra pages, no waiting.

[![Download](https://img.shields.io/badge/⬇️_Download_APK-v1.0.0-2ea44f?style=for-the-badge)](https://github.com/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App/releases/download/v1.0.0/LiveScore-1.0.0.apk)

| Platform | Status | Link |
|:---:|:---:|:---:|
| 🤖 Android | ✅ Available | [Download APK](https://github.com/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App/releases/download/v1.0.0/LiveScore-1.0.0.apk) |
| 🍎 iOS | 🚧 Coming Soon | — |

</div>

> ⚠️ **Note:** Since this app isn't on the Play Store yet, Android may show a Play Protect warning on first install. Tap **"More details" → "Install anyway"** to proceed — this is expected for apps distributed outside the Play Store, not a sign anything is wrong.

---

## ✨ Features

- 🔴 **Live score updates** — real-time match scores with automatic background polling
- 📅 **Fixtures** — full schedule broken down by matchday and date
- 🏆 **Groups & Knockout stages** — standings and bracket progression at a glance
- 🏟️ **Venues** — stadium details for every match location
- 🌍 **Teams** — browse all participating national teams
- 🔎 **Search & filter** — quickly find matches by team name or live/upcoming/finished status
- 🎨 **Dark theme UI** — clean, modern interface built for readability
- ⚡ **Fast & lightweight** — built with Flutter for smooth, native performance

---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| **Framework** | Flutter |
| **Language** | Dart |
| **State Management** | Riverpod (`flutter_riverpod`) |
| **Networking** | Dio |
| **Environment Config** | `flutter_dotenv` |
| **Splash Screen** | `flutter_native_splash` |

---

<!-- ## 📸 Screenshots

<div align="center">

| Home | Fixtures | Groups |
|:---:|:---:|:---:|
| _screenshot_ | _screenshot_ | _screenshot_ |

</div> -->

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x or higher)
- Dart SDK (bundled with Flutter)
- Android Studio / Xcode (for platform-specific builds)

### Installation

```bash
git clone https://github.com/Fouad-Showmik/Fifa_2026_Live_Score_Update_Native_App.git
cd Fifa_2026_Live_Score_Update_Native_App
flutter pub get
```

Create a `.env` file in the project root (see `.env.example` for the required keys):
```env
API_KEY=your_api_key_here
BASE_URL=https://api.example.com
```

Run the app:
```bash
flutter run
```

### Building a signed release APK

```bash
flutter build apk --release
```

> Requires a configured `android/key.properties` and keystore. See the [Flutter signing docs](https://docs.flutter.dev/deployment/android#signing-the-app) if setting this up for the first time.

---

## 📁 Project Structure

```
lib/
├── App/
│   ├── root/            # Bottom nav + root shell
│   ├── home/             # Live matches
│   ├── fixture/          # Fixtures by date
│   ├── group/            # Group standings
│   ├── venues/           # Stadium info
│   ├── teams/            # Team list
│   └── models/           # Data models 
├── Common/
│   ├── constants/        # Colors, text styles, app-wide constants
│   ├── enums/            # Match status, nav tabs, filters
│   ├── exceptions/       # Custom app exceptions
│   ├── theme/            # App-wide theming
│   ├── utils/            # Date/time formatting helpers
│   └── widgets/          # Shared reusable widgets (buttons, pills, cards, etc.)
├── Services/             # API client & game data service
└── main.dart
```
---

## 🤝 Contributing

Contributions are welcome!

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for details.

---

<div align="center">


⭐ **Star this repo if you found it useful!**

</div>