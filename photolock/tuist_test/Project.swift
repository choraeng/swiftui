import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains TuistTest App target and TuistTest unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: "TuistTest",
                          platform: .iOS,
                          additionalTargets: ["TuistTestKit", "TuistTestUI"])

let projectName = "TuistTest"
let bundleID = "com.cho.test.TuistTest"
// let iOSTargetVersion = "14.0"

//let project = Project(
//    name: projectName,
//    organizationName: "cho",
//    packages: [],
//    settings: nil,
//    targets: [
//      Target(name: projectName,
//             platform: .iOS,
//             product: .staticFramework, // Static Framework, Dynamic Framework
//             bundleId: bundleID,
////             deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone, .ipad]),
//             infoPlist: .default,
//             sources: ["Targets/\(projectName)/Sources/**"],
//             resources: [],
//             dependencies: [] // tuist generate할 경우 pod install이 자동으로 실행
//            )
//    ],
//    schemes: [
//      Scheme(name: "\(projectName)-Debug"),
//      Scheme(name: "\(projectName)-Release")
//    ],
//    fileHeaderTemplate: nil,
//    additionalFiles: [],
//    resourceSynthesizers: []
//  )

