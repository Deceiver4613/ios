

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "DroneAR",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "DroneAR",
            targets: ["AppModule"],
            bundleIdentifier: "sage.DroneARApp",
            teamIdentifier: "4E33XWS7UW",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.brown),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .process("Resources")
            ]
        )
    ]
)