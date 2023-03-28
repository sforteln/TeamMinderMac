//
//  Question.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/25/23.
//

import Foundation

class Question : ObservableObject, Codable {
    @Published var question : String = ""
    @Published var notes : String = ""
    @Published var talkedAbout : Bool = false
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        question = try values.decode(String.self, forKey: .question)
        notes = try values.decode(String.self, forKey: .notes)
        talkedAbout = try values.decode(Bool.self, forKey: .talkedAbout)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(question, forKey: .question)
        try container.encode(notes, forKey: .notes)
        try container.encode(talkedAbout, forKey: .talkedAbout)
    }
    
    enum CodingKeys: String, CodingKey {
        case question
        case notes
        case talkedAbout
    }
}

extension Question: Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.question == rhs.question
        && lhs.notes == rhs.notes
        && lhs.talkedAbout == rhs.talkedAbout
    }
}
