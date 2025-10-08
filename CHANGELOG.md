# Changelog
All notable changes to this project will be documented in this file.

## [Unreleased]
- Removed embedded repo aabird-clean
- Updated .gitignore to ignore aabird-clean/ and wagtail_prompts.dart
- Deleted tracked sensitive file lib/integrations/perplexity/wagtail_prompts.dart
- Added wagtail_prompts.example.dart as template for prompt logic
- Updated documentation (README.md) to include workflow for sensitive files and assets
- Confirmed TTS works on device

## [1.0.2] - 2025-10-08
### Added
- **Text-to-Speech (TTS) Feature**: Implemented TTS functionality, tested on physical device and confirmed working as expected
- **App Launch Capability**: Code additions enable successful app launches
- **Updated Icons**: Refreshed application icons for improved branding and visual consistency

### Changed
- **Widget Updates**: App launches successfully but existing widget requires updates for full functionality
- **Branch Synchronization**: Merged branch 'main' to keep codebase in sync
- **Code Organization**: Checked in minor changes before creating new development branch

### Fixed
- **Branch Merge Conflicts**: Resolved merge conflicts during branch synchronization
- **Build Stability**: Ensured clean build state before new feature development

### Technical Details
- **Branch**: main
- **Base Framework**: Flutter
- **Active Development Period**: Oct 6-8, 2025
- **Total Commits**: 8 commits (Oct 6-8)
- **Key Features**: TTS integration, widget system updates, icon improvements

### Commit History (Oct 6-8, 2025)
1. Merge branch 'main' of https://github.com/awyeah1-creator/AAbird (Oct 8)
2. tts working in emulator but needs to be tested on physical device (Oct 7)
3. code added, app launches need to update existing widget (Oct 7)
4. check in minor changes before new branch (Oct 7)
5. updated icons (Oct 6)

### Next Steps
- TTS functionality has been tested on physical Android device and is confirmed working as expected
- Complete widget updates for full integration
- Continue UI/UX improvements

---

## [1.0.1] - 2025-10-05 18:26 AWST
### Added
- **Multiplatform Launcher Icons**: Implemented custom wagtail icon across Android, Web, and Windows platforms using flutter_launcher_icons package
- **Wagtail Fact Widget**: Created responsive UI widget displaying AI-generated wagtail facts with animations and visual polish
- **Animated Gradient Background**: Added dynamic gradient background to home screen for enhanced visual appeal
- **Copy/Share Functionality**: Integrated copy-to-clipboard and share features for wagtail facts
- **Google Fonts Integration**: Added Google Fonts package for improved typography (google_fonts: ^6.3.2)
- **Auto Font Sizing**: Implemented auto_size_text package (^3.0.0) for responsive text display
- **Network Permissions**: Added proper network permissions to AndroidManifest.xml for API calls on physical devices

### Changed
- **Perplexity API Refinements**: Enhanced prompt system with new widget signatures, dynamic topic support, and bug fixes
- **Package Organization**: Moved flutter_launcher_icons from dependencies to dev_dependencies for cleaner project structure  
- **Code Cleanup**: Removed excessive comments from pubspec.yaml for better maintainability
- **.gitignore Updates**: Fixed entries for assets folder and wagtail_promts.dart to prevent sensitive file tracking
- **UI Polish**: Refined Wagtail fact widget with animation chips, improved responsiveness, and overflow handling

### Fixed
- **Network Access**: Resolved network connectivity issues on Android devices by adding INTERNET permission
- **Asset Tracking**: Properly excluded assets folder and Perplexity prompt files from version control
- **Widget Overflow**: Fixed text overflow issues in mobile view with proper constraint handling
