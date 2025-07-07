# TicTacToe Duel

A beautiful, cross-platform TicTacToe game built with Flutter, featuring automatic dark mode support and an intuitive touch interface.

## 🎮 Features

- **Classic TicTacToe Gameplay**: Traditional 3x3 grid game for two players
- **Two-Player Local Mode**: Play with a friend on the same device
- **Automatic Dark Mode**: Seamlessly switches between light and dark themes based on system settings
- **Touch-Friendly Interface**: Intuitive tap-to-play controls with visual feedback
- **Winning Line Highlight**: Clear visual indication when a player wins
- **Restart Functionality**: Easy game reset with a dedicated restart button
- **Cross-Platform**: Runs on Android, iOS, Linux, Web, and Windows
- **Responsive Design**: Adapts to different screen sizes and orientations
- **Dual-Sided Interface**: Upside-down controls for players sitting across from each other

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.3.3 <4.0.0)
- Dart SDK
- Android Studio / VS Code (recommended)
- For platform-specific builds:
  - Android: Android SDK
  - iOS: Xcode (macOS only)
  - Web: Chrome browser
  - Desktop: Platform-specific requirements

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd tictactoe_flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For debug mode
   flutter run

   # For specific platforms
   flutter run -d chrome          # Web
   flutter run -d android         # Android
   flutter run -d ios             # iOS
   flutter run -d linux           # Linux
   flutter run -d windows         # Windows
   ```

### Building for Release

```bash
# Android APK
flutter build apk --release

# iOS (macOS only)
flutter build ios --release

# Web
flutter build web --release

# Desktop
flutter build linux --release
flutter build windows --release
```

## 🎯 How to Play

1. **Start the Game**: Launch the app to see the 3x3 game grid
2. **Make Your Move**: Player X goes first - tap any empty cell to place your mark
3. **Take Turns**: Players alternate between X and O
4. **Win the Game**: Get three of your marks in a row (horizontal, vertical, or diagonal)
5. **Restart**: Tap the "RESTART" button to start a new game
6. **Get Help**: Tap the info icon (ℹ️) for quick instructions

## 🛠️ Dependencies

- **flutter**: Flutter SDK
- **cupertino_icons**: iOS-style icons
- **touchable**: Enhanced gesture detection for custom canvas painting

### Dev Dependencies

- **flutter_test**: Testing framework
- **flutter_lints**: Code analysis and linting
- **flutter_launcher_icons**: Custom app icon generation

## 📁 Project Structure

```
lib/
├── main.dart              # Main application entry point and game logic
assets/
├── logo.png              # App icon/logo
android/                  # Android-specific files
ios/                      # iOS-specific files
web/                      # Web-specific files
linux/                    # Linux-specific files
windows/                  # Windows-specific files
```

## 🎨 Theming

The app automatically detects your system's theme preference:
- **Light Mode**: Clean white background with blue accents
- **Dark Mode**: Dark gray background with enhanced contrast
- **Automatic Switching**: Follows system theme changes in real-time

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Igor Polyakov** - *Initial work* - (2022)

## 🔄 Version History

- **v1.2.0** - Dark mode support (automatic switch)
- **v1.0.0** - Initial release

## 🐛 Known Issues

- None currently reported

---

*Built with ❤️ using Flutter*
