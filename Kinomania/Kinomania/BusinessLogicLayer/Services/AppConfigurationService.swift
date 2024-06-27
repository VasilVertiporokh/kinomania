//
//  AppConfigurationService.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Foundation

enum AppEnvironment: String {
    case dev
    case prod
}

protocol AppConfigurationService {
    var appName: String { get }
    var bundleId: String { get }
    var environment: AppEnvironment { get }
    var appVersion: String { get }
}

final class AppConfigurationServiceImpl: AppConfigurationService {
    // MARK: - Internal properties
    let appName: String
    let bundleId: String
    let environment: AppEnvironment
    let appVersion: String

    // MARK: - Init
    init(bundle: Bundle = .main) {
        guard
            let bundleId = bundle.bundleIdentifier,
            let infoDict = bundle.infoDictionary,
            let environmentValue = infoDict[Key.Environment] as? String,
            let environment = AppEnvironment(rawValue: environmentValue),
            let appVersion = infoDict["APP_VERSION"] as? String,
            let appName = infoDict["APP_NAME"] as? String
        else {
            fatalError("config file error")
        }

        self.bundleId = bundleId
        self.environment = environment
        self.appVersion = appVersion
        self.appName = appName

        debugPrint("BUNDLE ID   ➡️ \(bundleId)")
        debugPrint("ENVIRONMENT ➡️ \(environment)")
        debugPrint("APP VERSION ➡️ \(appVersion)")
        debugPrint("APP NAME ➡️ \(appName)")
    }
}

private enum Key {
    static let Environment: String = "APP_ENVIRONMENT"
    static let AppVersion: String = "APP_VERSION"
    static let AppName: String = "APP_NAME"
}
