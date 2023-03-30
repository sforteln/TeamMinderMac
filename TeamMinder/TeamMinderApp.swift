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
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    @State var lastSaveDisplay : String = "---"
    
    func save() {
        dataService.save()
        lastSaveDisplay = dataService.team.lastSaveDisplayValue()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataService)
                .environmentObject(dataService.team)
                .toolbar {
                    Text("Last saved: \(lastSaveDisplay)").fontWeight(.thin).onReceive(timer) { _ in
                        save()
                    }
                    Button(action: {save()}) {
                        Text("Save")
                    }
                }
        }
    }
}
