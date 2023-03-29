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
    var completeDate : Date?
    
    init(question: String) {
        self.question = question
    }
    
    func complete(notes: String) {
        talkedAbout = true
        self.notes = notes
        self.completeDate = Date.now
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        question = try values.decode(String.self, forKey: .question)
        notes = try values.decode(String.self, forKey: .notes)
        talkedAbout = try values.decode(Bool.self, forKey: .talkedAbout)
        if values.contains(.completeDate) {
            completeDate = try values.decode(Date.self, forKey: .completeDate)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(question, forKey: .question)
        try container.encode(notes, forKey: .notes)
        try container.encode(talkedAbout, forKey: .talkedAbout)
        if let completeDate = completeDate {
            try container.encode(completeDate, forKey: .completeDate)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case question
        case notes
        case talkedAbout
        case completeDate
    }
}

extension Question: Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.question == rhs.question
        && lhs.notes == rhs.notes
        && lhs.talkedAbout == rhs.talkedAbout
    }
}
