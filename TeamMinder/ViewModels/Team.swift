//
//  Team.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/25/23.
//

import Foundation

class Team : ObservableObject, Codable {
    @Published var members = [TeamMember]()
    @Published var lastSave : Date
    
    func deleteMember(member: TeamMember) {
        members.removeAll { $0 == member }
    }
    
    func addMember(name: String) {
        members.append(TeamMember(name: name))
    }
    
    func lastSaveDisplay() -> String {
//        let formatter = RelativeDateTimeFormatter()
//        formatter.unitsStyle = .full
//        let relativeDate = formatter.localizedString(for: lastSave, relativeTo: Date.now)
//        return relativeDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: lastSave)
    }
    
    init(){
        lastSave = Date()
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        members = try values.decode([TeamMember].self, forKey: .members)
        lastSave = try values.decode(Date.self, forKey: .lastSave)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(members, forKey: .members)
        try container.encode(lastSave, forKey: .lastSave)
    }
    
    enum CodingKeys: String, CodingKey {
        case members
        case lastSave
    }
    
}

extension Team:Equatable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.members == rhs.members
    }
}


func testTeamData() -> Team {
    let team = Team()
    team.addMember(name: "Bob")
    team.addMember(name: "Jane")
    team.addMember(name: "Fred")
    return team
}
