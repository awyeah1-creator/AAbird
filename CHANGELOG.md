# Changelog
All notable changes to this project will be documented in this file.

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

### Technical Details
- **Branch**: testing (7 commits ahead of main)
- **Base Framework**: Flutter
- **Active Development Period**: Oct 5, 2025 8:22 AM - 6:22 PM AWST
- **Total Commits Today**: 16 commits
- **Key Integrations**: Perplexity API, Google Fonts, flutter_launcher_icons

### Commit History (Oct 5, 2025 - Afternoon/Evening Session)
1. Remove assets folder and wagtail_promts.dart from tracking after updating .gitignore (6:22 PM)
2. Remove assets folder and wagtail_promts.dart from tracking after updating .gitignore (6:21 PM)  
3. Fix .gitignore entries for assets and wagtail_promts.dart (6:20 PM)
4. Added animated gradient background to home screen (6:14 PM)
5. Disable sync of assets and pplx prompt file (5:50 PM)
6. Disable sync of assets and pplx prompt file (5:45 PM)
7. Revamp prompt system: new widget signatures, dynamic topic support, bugfixes (5:16 PM)
8. Final changes before merge to main (3:34 PM)
9. Merge branch 'home-ui-upgrade-wagtailfact' (2:00 PM)
10. Fix: Add network permissions to AndroidManifest.xml for network access on device (1:57 PM)
11. Merge pull request #2 from awyeah1-creator/main (10:30 AM)
12. Implement multiplatform launcher icon and update pubspec.yaml (10:14 AM)
13. UI polish: responsive Wagtail fact widget with animation, chip, Google Fonts, auto font sizing, and copy/share (9:52 AM)
14. Wagtail AI widget working, UI refinements still needed (9:38 AM)
15. Working Perplexity API integration for wagtail facts; refactored widget for mobile readability and overflow fixes (9:27 AM)
16. Update CHANGELOG.md - Add timestamped v1.0.0 release notes to featuretesting051025 branch (8:22 AM)

### Lessons Learned
1. **Icon Generation**: flutter_launcher_icons package automates icon generation across all platforms, saving significant manual work
2. **Network Debugging**: Physical device testing revealed network permission requirements not apparent in emulator
3. **UI Responsiveness**: auto_size_text and proper constraints are essential for handling varied screen sizes and content lengths
4. **Git Hygiene**: Importance of properly configuring .gitignore before adding sensitive files (API keys, prompts)
5. **Widget Architecture**: Separating UI polish from core functionality allows for iterative refinement without breaking features
6. **Package Management**: Dev dependencies vs runtime dependencies distinction improves build times and app size
7. **Merge Strategies**: Successfully managed multiple branch merges while maintaining feature integrity

### Next Steps  
- Merge testing branch to main after final validation
- Expand wagtail fact topics and categories
- Add user preferences for fact display frequency
- Implement local caching for offline fact display
- Consider adding animation transitions between facts
- Explore additional AI-powered features using Perplexity API

---

## [1.0.0] - 2025-10-05 08:18 AWST

### Added
- **Perplexity Integration**: Implemented API service with prompt screen and comprehensive error handling
- **Video Features**: Golden wagtail icon now opens looping video screen
- **Grid Icons**: Added interactive grid icons with counter increment functionality
- **Wagtail Images**: Implemented responsive grid displaying 4 wagtail images on home screen
- **Interactive UI Elements**: Bird icon now increments counter and plays sound on tap
- **FAB Color Change**: Floating Action Button now changes background color to random values
- **Audio Integration**: Added wagtail bird icon button with audio chirp on tap
- **Splash Screen Icon**: Added wagtail icon to splash screen

### Changed
- **Code Quality**: Applied dart fix recommendations for code optimization
- **Security**: Removed apikeys.dart from tracking and updated .gitignore for better security practices
- **Home Screen**: Enhanced home_screen.dart with video icon testing implementation

### Technical Details
- **Branch**: main
- **Base Framework**: Flutter
- **Target**: Testing app features with Wagtail and Perplexity integration
- **Total Commits**: 20 commits
- **Update Period**: Oct 4, 2025 3:24 PM - Oct 5, 2025 7:58 AM

### Commit History (Since Last Update)
1. Apply dart fix recommendations (Oct 5, 2025 - 7:58 AM)
2. End of day commit (Oct 4, 2025 - 7:52 PM)
3. Remove apikeys.dart from tracking and update .gitignore (Oct 4, 2025 - 7:33 PM)
4. Remove apikeys.dart from tracking and update .gitignore (Oct 4, 2025 - 7:31 PM)
5. Perplexity integration: API service, prompt screen, and error handling implemented (Oct 4, 2025 - 7:22 PM)
6. WIP: Ready for PPX testing next from here (Oct 4, 2025 - 6:56 PM)
7. Golden wagtail icon opens looping video screen; grid icons increment counter (Oct 4, 2025 - 4:52 PM)
8. Start implementation for video icon testing on home screen (Oct 4, 2025 - 4:36 PM)
9. Show 4 wagtail images in responsive grid on home screen (Oct 4, 2025 - 4:32 PM)
10. Make bird icon increment counter and play sound; FAB changes background color to random (Oct 4, 2025 - 3:57 PM)
11. Add wagtail bird icon button to home screen with audio chirp on tap (Oct 4, 2025 - 3:52 PM)
12. Add wagtail icon to splash screen (Oct 4, 2025 - 3:37 PM)

### Lessons Learned
1. **API Integration**: Successfully integrated third-party API (Perplexity) with proper error handling
2. **Security Best Practices**: Learned importance of keeping API keys out of version control
3. **Video Playback**: Implemented looping video screens in Flutter
4. **Interactive UI**: Created engaging user interactions with sounds and visual feedback
5. **Code Quality**: Applied automated code fixes to improve code standards

### Next Steps
- Continue testing Perplexity integration features
- Expand multimedia capabilities
- Further enhance Wagtail backend integration
- Add more interactive elements and features

---

## [Unreleased] - feature/picturesoundonhome Branch

### Added
- **Splash Screen**: Implemented custom splash screen with animations and transitions
- **Home Screen**: Created home screen UI with picture and sound integration
- **Assets Integration**: Added assets folder containing images, videos, and audio files
- **Media Support**: Integrated audio and video playback capabilities in Flutter
- **Package Dependencies**: Added required packages for audio/video support in pubspec.yaml

### Changed
- Updated pubspec.yaml to include audio, video, and asset dependencies
- Modified home_screen.dart to support multimedia features  
- Resolved conflicts between splash and home screen implementations

### Technical Details
- **Branch**: feature/picturesoundonhome
- **Base Framework**: Flutter
- **Target**: Testing app features with Wagtail integration
- **Commits**: 7 total commits on this branch
- **Status**: 2 commits ahead of main branch

### Lessons Learned
1. **Asset Management**: Proper organization of media assets in Flutter projects
2. **Screen Navigation**: Smooth transitions between splash and home screens
3. **Conflict Resolution**: Successfully merged conflicting changes between screens
4. **Media Integration**: Implementation of audio and video playback in Flutter apps
5. **Flutter Development**: Practical experience with Flutter project structure and dependencies

### Commit History
1. Initial commit: base Flutter project (Oct 4, 2025 - 1:45 PM)
2. Update pubspec.yaml and home_screen.dart for audio, video, and asset support (Oct 4, 2025 - 3:18 PM)
3. Add assets folder and asset files (Oct 4, 2025 - 3:20 PM)
4. Resolve conflicts and finalize working splash and home screen integration (Oct 4, 2025 - 2:57 PM)

### Next Steps
- Merge feature branch into main after testing
- Further enhance multimedia features
- Integrate with Wagtail backend
- Add more interactive elements to home screen

---

*This changelog follows the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format.*
