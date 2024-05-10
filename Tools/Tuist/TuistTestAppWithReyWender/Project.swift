import ProjectDescription
import ProjectDescriptionHelpers

/*
                +-------------+
                |             |
                |     App     | Contains TuistTestAppWithReyWender App target and TuistTestAppWithReyWender unit-test target
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

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(
    name: "MovieInfo",
    organizationName: "kwangsoo Kim",
    settings: nil,
    targets: [
        Target(
            name: "MovieInfo",
            platform: .iOS, product: .app,
            bundleId: "com.tootooma.MovieInfoTuist",
            infoPlist: "MovieInfo/Info.plist",
            sources: ["MovieInfo/Source/**"],
            resources: ["MovieInfo/Resource/**"],
            dependencies: [],
            settings: nil
        )
    ]
)
