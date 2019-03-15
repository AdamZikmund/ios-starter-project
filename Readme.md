# iOS start project

Base iOS project with examples how to structure application.
Includes patterns, pods dependencies and base architecture.

## Guidelines

iOS guidelines for developing applications.

### Project

- Manage dependencies using [CococaPods](https://cocoapods.org)
- Configuration data like `API_URL` keep in target build settings
- Create target for release and for testing
- Propagate configuration data to `Configuration.swift` file
- Keep shared files in `shared` folder (`models`, `protocols`, `extensions`)
- Static files like `fonts`, `animations` and `localization` keep in `static` folder
- For each screen create files (`controller`, `storyboard`, `coordinator`) in `ui` folder
- Map one `controller` to one `storyboard` file
- For automatic fonts management use custom bash script called `fonts.sh`
- Use [agvtool](https://developer.apple.com/library/archive/qa/qa1827/_index.html) for project versioning

### Assets

- Add only vector files (pdf recomended)
- Create and manage custom colors
- Use clear naming convention `icon-arrow-left-black`, `icon-arrow-right-white`
- Organize files into folders

### Architecutre & patterns

- MVVM
- Flow coordinators
- Repository
- Delegate

### Frameworks

- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [RxCocoa](https://github.com/ReactiveX/RxSwift/tree/master/RxCocoa)
- [Moya](https://github.com/Moya/Moya)
- [Realm](https://github.com/realm/realm-cocoa)
- [Localize](https://github.com/andresilvagomez/Localize)
- [lottie-ios](https://github.com/airbnb/lottie-ios)
- [MBProgressHUD](https://github.com/jdg/MBProgressHUD)
- [pop](https://github.com/facebook/pop)
- [Fabric](https://fabric.io/kits)
- [SwiftLint](https://github.com/realm/SwiftLint)

### Code style

- Use Swift rules from [RayWenderlich](https://github.com/raywenderlich/swift-style-guide)
- Use [SwiftLint](https://github.com/realm/SwiftLint) in all projects
- For formatting use [Swimat](https://github.com/Jintin/Swimat)

### Comments

- For comments use default Xcode documentation generator
- Use comments for classes, structs, enums and functions
- More complex code comment with inline comments
- Use Xcode markdowns `// MARK:`, `// TODO:`

### Building

- Use [fastlane](https://fastlane.tools)

### Git

- For versioning use [git](https://git-scm.com)
- Keep `master` and `dev` branch in project
  - `master` for `release` versions
  - `dev` for `development` versions
- Checkout new `feature` branch from `dev` branch for each task
- Use meaningful commit names

### Certificates & Provisioning profiles

- Use [match](https://docs.fastlane.tools/actions/match/) for managing certificates
- Certificates and provisioning profiles are stored in this [repository](https://gitlab.com/company/ios/certificates)
