//
//  TeamMinderApp.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/23/23.
//

import SwiftUI

@main
struct TeamMinderApp: App {
    
    
    @StateObject var team = testTeamData()
    var body: some Scene {
        WindowGroup {
            ContentView(team: team)
        }
    }
}
