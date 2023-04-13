//
//  TrendData.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/30/23.
//

import Foundation
enum TrendType : String , RawRepresentable, Codable {
    case higherIsBetter = "Higher is better"
    case lowerIsBetter = "Lower is better"
}

class Trend : Identifiable, ObservableObject, Codable {
    var id = UUID()
    var title : String
    var type : TrendType
    
    init(title: String, type: TrendType) {
        self.title = title
        self.type = type
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        id = try values.decode(UUID.self, forKey: .id)
        type = try values.decode(TrendType.self, forKey: .type)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(type, forKey: .type)
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case type
    }
}

class TrendData: Identifiable, ObservableObject, Codable {
    var id = UUID()
    @Published var points : [TrendDataPoint]
    var trendId : UUID
    var teamMemberId: UUID
    
    init(teamMemberId: UUID, trendId: UUID, points: [TrendDataPoint]) {
        self.teamMemberId = teamMemberId
        self.points = points
        self.trendId = trendId
    }
    
    func addNewPoint(level: Int) {
        points.insert(TrendDataPoint(level: level, date: Date.now), at: 0)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        teamMemberId = try values.decode(UUID.self, forKey: .teamMemberId)
        points = try values.decode([TrendDataPoint].self, forKey: .points)
        trendId = try values.decode(UUID.self, forKey: .trendId)
        id = try values.decode(UUID.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(teamMemberId, forKey: .teamMemberId)
        try container.encode(points, forKey: .points)
        try container.encode(trendId, forKey: .trendId)
        try container.encode(id, forKey: .id)
    }
    
    enum CodingKeys: String, CodingKey {
        case teamMemberId
        case points
        case trendId
        case id
    }
}

class TrendDataPoint: Identifiable, ObservableObject, Codable {
    var level: Int
    var date: Date
    var id = UUID()
    
    init(level: Int, date: Date) {
        self.level = level
        self.date = date
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        level = try values.decode(Int.self, forKey: .level)
        date = try values.decode(Date.self, forKey: .date)
        id = try values.decode(UUID.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(level, forKey: .level)
        try container.encode(date, forKey: .date)
        try container.encode(id, forKey: .id)
    }
    
    enum CodingKeys: String, CodingKey {
        case level
        case date
        case id
    }
}
