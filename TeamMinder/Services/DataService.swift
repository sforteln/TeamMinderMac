//
//  File.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/27/23.
//

import Foundation
class DataService :ObservableObject {
    var team = Team()
    
    init() {
        load()
    }
    
    func save(){
        if let encoded = try? JSONEncoder().encode(team) {
                UserDefaults.standard.set(encoded, forKey: "SavedData")
            print("Saved")
            team.lastSave = Date.now
        }
    }
    
    func load(){
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            do{
                let decoded = try JSONDecoder().decode(Team.self, from: data)
                team = decoded
                return
            }
            catch {
                print(error)
            }
        }
    }
}
