//
//  DependencyContainer.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 27/06/2024.
//

import Factory

extension Container {
    var appConfiguration: Factory<AppConfigurationService> {
        self { AppConfigurationServiceImpl() }
            .cached
    }

    var networkManager: Factory<NetworkManagerProtocol> {
        self { NetworkManagerImpl() }
            .cached
    }

    var moviesNetworkService: Factory<MoviesNetworkService> {
        self {
            let apiKey: String = self.appConfiguration.resolve().apiKey
            let plugin = BasePlugin(apiKey: apiKey)
            return MoviesNetworkServiceImpl(
                provider: NetworkServiceProvider<MoviesNetworkEndpoinBuilder>(
                    apiInfo: self.appConfiguration.resolve(),
                    networkManager: self.networkManager.resolve(),
                    plugins: [plugin]
                )
            )
        }
    }

    var moviesManager: Factory<MoviesManager> {
        self { MoviesManagerImpl() }
            .cached
    }

    var reachabilityManager: Factory<ReachabilityManager> {
        self { ReachabilityManagerImpl() }
            .singleton
    }
}
