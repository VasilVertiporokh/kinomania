//
//  ReachabilityManager.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import Foundation
import Connectivity

protocol ReachabilityManager {
    var reachabilityDelegate: ReachabilityManagerDelegate? { get set }
}

protocol ReachabilityManagerDelegate: AnyObject {
    func connnectionError(connectionError: ReachabilityError)
    func connectionRestored()
}

final class ReachabilityManagerImpl: ReachabilityManager {
    // MARK: - Internal properties
    weak var reachabilityDelegate: ReachabilityManagerDelegate?

    // MARK: - Private  proeprties
    private let connectivity: Connectivity

    // MARK: - Init
    init() {
        self.connectivity = Connectivity()
        self.connectivity.startNotifier()
        startNotifier()
    }

    private func startNotifier() {
        let connectivityChanged: (Connectivity) -> Void = { [weak self] connectivity in
            switch connectivity.status {
            case .connectedViaCellularWithoutInternet,
                 .connectedViaEthernetWithoutInternet,
                 .connectedViaWiFiWithoutInternet,
                 .determining,
                 .notConnected:
                self?.reachabilityDelegate?.connnectionError(connectionError: .connectionError)
            default:
                self?.reachabilityDelegate?.connectionRestored()
            }
        }
        connectivity.whenConnected = connectivityChanged
        connectivity.whenDisconnected = connectivityChanged
    }
}

enum ReachabilityError: Error, LocalizedError {
    case connectionError

    var errorDescription: String? {
        switch self {
        case .connectionError:
            Localization.General.networkError
        }
    }
}
