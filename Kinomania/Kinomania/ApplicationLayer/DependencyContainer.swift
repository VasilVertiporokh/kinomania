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
}
