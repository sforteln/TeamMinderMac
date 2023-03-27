//
//  Question.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/25/23.
//

import Foundation

class Question : ObservableObject {
    @Published var question : String?
    @Published var notes : String?
    @Published var talkedBout : Bool?
    @Published var talkedAboutOn : Date?
    
    
}

extension Question: Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.question == rhs.question
        && lhs.notes == rhs.notes
        && lhs.talkedBout == rhs.talkedBout
        && lhs.talkedAboutOn == rhs.talkedAboutOn
    }
}
