//
//  TeamMember.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/23/23.
//

import Foundation

class TeamMember : ObservableObject {
    @Published var name : String
    @Published var city : String?
    @Published var notes : String?
    @Published var family : String?
    @Published var questions : [Question]?
    
    
    init(name: String) {
        self.name = name
    }
}

extension TeamMember:Equatable {
    static func == (lhs: TeamMember, rhs: TeamMember) -> Bool {
        return lhs.name == rhs.name
        && lhs.city == rhs.city
        && lhs.notes == rhs.notes
        && lhs.family == rhs.family
        && lhs.questions == rhs.questions
    }
}
