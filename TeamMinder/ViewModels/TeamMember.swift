//
//  TeamMember.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/23/23.
//

import Foundation
import Combine

class TeamMember : ObservableObject, Codable, Identifiable {
    @Published var id : UUID
    @Published var name : String
    @Published var city : String = ""
    @Published var notes : String = ""
    @Published var family : String = ""
    @Published var questions : [Question] = [Question]()
    @Published var trends : [TrendData] = [TrendData]()
    @Published var performanceGood : String = ""
    @Published var performanceNeedsImprovement : String = ""
    
    private var cancellable: Cancellable?
        
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
    
    func addQuestion(question: String) {
        let newQuestion = Question(question: question)
        questions.append(newQuestion)
    }
    
    func getCompletedQuestions() -> [Question] {
        return questions.filter { question in
            return question.completeDate != nil
        }
    }
    
    func getNotCompletedQuestions() -> [Question] {
        return questions.filter { question in
            return question.completeDate == nil
        }
        
    }
    
    func complete(question: Question, notes: String) {
        question.talkedAbout = true
        question.notes = notes
        question.completeDate = Date.now
        objectWillChange.send()
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        city = try values.decode(String.self, forKey: .city)
        notes = try values.decode(String.self, forKey: .notes)
        family = try values.decode(String.self, forKey: .family)
        questions = try values.decode(Array.self, forKey: .questions)
        trends = try values.decode(Array.self, forKey: .trends)
        performanceGood = try values.decode(String.self, forKey: .performanceGood)
        performanceNeedsImprovement = try values.decode(String.self, forKey: .performanceNeedsImprovement)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(city, forKey: .city)
        try container.encode(notes, forKey: .notes)
        try container.encode(family, forKey: .family)
        try container.encode(questions, forKey: .questions)
        try container.encode(trends, forKey: .trends)
        try container.encode(performanceGood, forKey: .performanceGood)
        try container.encode(performanceNeedsImprovement, forKey: .performanceNeedsImprovement)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case city
        case notes
        case family
        case questions
        case trends
        case performanceGood
        case performanceNeedsImprovement
    }
}

extension TeamMember:Equatable {
    static func == (lhs: TeamMember, rhs: TeamMember) -> Bool {
        return lhs.name == rhs.name
        && lhs.city == rhs.city
        && lhs.notes == rhs.notes
        && lhs.family == rhs.family
        && lhs.questions == rhs.questions
        && lhs.performanceGood == rhs.performanceGood
        && lhs.performanceNeedsImprovement == rhs.performanceNeedsImprovement
    }
}


extension TeamMember:Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
