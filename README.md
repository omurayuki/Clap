# project_clap_ios

## Getting Started

To get started and run the app, you need to follow these simple steps:

1. Open the project_clap_ios workspace in Xcode.
2. Change the Bundle Identifier to match your domain.
3. Go to Firebase and create new project.
4. Select "Add Firebase to your iOS app" option, type the bundle Identifier & click continue.
5. Download "GoogleService-Info.plist" file and add to the project. Make sure file name is "GoogleService-Info.plist".
6. Go to Firebase Console, select your project, choose "Authentication" from left menu, select "SIGN-IN METHOD" and enable "Email/Password" option.
7. Open the terminal, navigate to project folder and run "pod install".
8. Run Quick Chat on your iPhone or the iOS Simulator.



## Compatibility

This project is written in Swift 4.2 and requires Xcode 10.1 to build and run.



## Main functions
- timeline
- calendar
- mypage
- comment
- reply



## Technology used

- RxSwift
- RxCocoa
- Firebase Authorization
- FirebaseFirestore



## Architecture used

- MVVM



## Author

- [Yuki Omura](https://twitter.com/yuking_0319)
