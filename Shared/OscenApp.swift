//
//  OscenApp.swift
//  Shared
//
//  Created by Andrew Pirkl on 8/1/21.
//

import SwiftUI

@main
struct OscenApp: App {
    var body: some Scene {
        WindowGroup {
            #if DEBUG
            ContentView(contentViewModel: ContentViewModel(appConfigController: MockAppConfigController(), webhookController: MockWebhookController()))
            #else
            ContentView(contentViewModel: ContentViewModel(appConfigController: AppConfigController(), webhookController: WebhookController()))
            #endif

        }
    }
}
