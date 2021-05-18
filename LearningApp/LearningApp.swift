//
//  LearningApp.swift
//  LearningApp
//
//  Created by Rahul Parekh on 2021-05-17.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
