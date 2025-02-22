//
//  Command.swift
//
//
//  Created by Yume on 2022/4/28.
//

import ArgumentParser
import BazelizeKit
import Foundation
import PathKit

struct Command: AsyncParsableCommand {
    @Option(name: [.customLong("project", withSingleDash: false)], help: "PATH/TO/YOUR.xcodeproj")
    var project: String

    @Option(name: [.short], help: "Debug/Release")
    var config = "Release"

    @Option(name: [.long], help: "plugin list")
    var manifest = ".bazelize.yml"

    @Flag
    var dump = false

    func run() async throws {
        let path = Path.current + project
        let kit = try await Kit(path)
        if dump {
            try kit.dump()
        } else {
            try await kit.run(Path(manifest))
        }
    }
}
