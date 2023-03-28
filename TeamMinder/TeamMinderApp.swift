//
//  TeamMinderApp.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/23/23.
//

import SwiftUI

@main
struct TeamMinderApp: App {
    @StateObject var dataService = DataService()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataService)
                .environmentObject(dataService.team)
                .toolbar {
                    Text("Last saved: \(dataService.team.lastSaveDisplay())")
                    Button(action: {dataService.save()}) {
                        Text("Save")
                            .foregroundColor(.blue)
                        
                    }.padding(1.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                    Button(action: {dataService.load()}) {
                    Text("Load")
                                .foregroundColor(.blue)
                        
                }
                    
                }
        }
    }
}
