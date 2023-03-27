//
//  Team.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/25/23.
//

import Foundation

class Team : ObservableObject {
    @Published var members = [TeamMember]()
    
    func deleteMember(member: TeamMember) {
        members.removeAll { $0 == member }
    }
    
    func addMember(name: String) {
        members.append(TeamMember(name: name))
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
