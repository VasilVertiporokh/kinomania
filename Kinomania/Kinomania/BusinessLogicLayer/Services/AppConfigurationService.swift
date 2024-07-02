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

protocol AppConfigurationService: ApiInfo {
    var appName: String { get }
    var bundleId: String { get }
    var environment: AppEnvironment { get }
    var appVersion: String { get }
    var apiKey: String { get }
}

final class AppConfigurationServiceImpl: AppConfigurationService {
    // MARK: - Internal properties
    let appName: String
    let bundleId: String
    let environment: AppEnvironment
    let appVersion: String
    let apiKey: String

    lazy var baseURL: URL = {
        guard let url = URL(string: "https://api.themoviedb.org") else {
            fatalError("Invalid url")
        }
        return url
    }()

    // MARK: - Init
    init(bundle: Bundle = .main) {
        guard
            let bundleId = bundle.bundleIdentifier,
            let infoDict = bundle.infoDictionary,
            let environmentValue = infoDict[Key.environment] as? String,
            let environment = AppEnvironment(rawValue: environmentValue),
            let appVersion = infoDict["APP_VERSION"] as? String,
            let appName = infoDict["APP_NAME"] as? String,
            let apiKey = infoDict[Key.apiKey] as? String
        else {
            fatalError("config file error")
        }

        self.bundleId = bundleId
        self.environment = environment
        self.appVersion = appVersion
        self.appName = appName
        self.apiKey = apiKey

        debugPrint("BUNDLE ID   ➡️ \(bundleId)")
        debugPrint("ENVIRONMENT ➡️ \(environment)")
        debugPrint("APP VERSION ➡️ \(appVersion)")
        debugPrint("APP NAME ➡️ \(appName)")
    }
}

private enum Key {
    static let environment: String = "APP_ENVIRONMENT"
    static let baseUrl: String = "BASE_URL"
    static let apiKey: String = "API_KEY"
}
