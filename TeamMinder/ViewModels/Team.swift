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
    @Published var trends = [Trend]()
    
    func deleteMember(member: TeamMember) {
        members.removeAll { $0 == member }
    }
    
    func addMember(name: String) {
        let newmember = TeamMember(name: name)
        addTrendsToMember(member: newmember)
        members.append(newmember)
    }
    
    func addMember(member: TeamMember) {
        addTrendsToMember(member: member)
        members.append(member)
    }
    
    private func addTrendsToMember(member: TeamMember) {
        for trend in trends {
            let existingTrend = member.trends.first { memberTrend in
                memberTrend.trendId == trend.id
            }
            
            if existingTrend != nil {
                continue
            }
            member.trends.append(TrendData(teamMemberId: member.id, trendId: trend.id, points: [TrendDataPoint]()))
        }
    }
    
    func addTrend(title: String, type: TrendType) {
        let trend = Trend(title: title, type: type)
        trends.append(trend)
        for member in members {
            member.trends.append(TrendData(teamMemberId: member.id, trendId: trend.id, points: [TrendDataPoint]()))
        }
    }
    
    func lastSaveDisplayValue() -> String {
//        let formatter = RelativeDateTimeFormatter()
//        formatter.unitsStyle = .full
//        let relativeDate = formatter.localizedString(for: lastSave, relativeTo: Date.now)
//        return relativeDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm:ss"
        return dateFormatter.string(from: lastSave)
    }
    
    init(){
        lastSave = Date()
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        members = try values.decode([TeamMember].self, forKey: .members)
        lastSave = try values.decode(Date.self, forKey: .lastSave)
        trends = try values.decode([Trend].self, forKey: .trends)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(members, forKey: .members)
        try container.encode(lastSave, forKey: .lastSave)
        try container.encode(trends, forKey: .trends)
    }
    
    enum CodingKeys: String, CodingKey {
        case members
        case lastSave
        case trends
    }
    
}

extension Team:Equatable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.members == rhs.members
    }
}

struct TestData {
    static var teamTestData = testTeamData()
}

func testTeamData() -> Team {
    let team = Team()
    team.addMember(name: "Bob")
    team.addMember(name: "Jane")
    team.addMember(name: "Fred")
    let points: [TrendDataPoint] = [
        TrendDataPoint(level: 2, date: Date.daysAgo(12)),
        TrendDataPoint(level: 3, date: Date.daysAgo(22)),
        TrendDataPoint(level: 1, date: Date.daysAgo(23)),
        TrendDataPoint(level: 1, date: Date.daysAgo(30)),
        TrendDataPoint(level: 5, date: Date.daysAgo(33)),
        TrendDataPoint(level: 4, date: Date.daysAgo(43)),
        TrendDataPoint(level: 5, date: Date.daysAgo(47)),
        TrendDataPoint(level: 5, date: Date.daysAgo(53)),
        TrendDataPoint(level: 3, date: Date.daysAgo(60)),
        TrendDataPoint(level: 3, date: Date.daysAgo(67)),
        TrendDataPoint(level: 2, date: Date.daysAgo(73)),
        TrendDataPoint(level: 1, date: Date.daysAgo(80)),
        TrendDataPoint(level: 4, date: Date.daysAgo(87)),
        TrendDataPoint(level: 1, date: Date.daysAgo(93)),
        TrendDataPoint(level: 3, date: Date.daysAgo(100))
    ]
    
    let points2: [TrendDataPoint] = [
        TrendDataPoint(level: 2, date: Date.daysAgo(12)),
        TrendDataPoint(level: 1, date: Date.daysAgo(22)),
        TrendDataPoint(level: 1, date: Date.daysAgo(23)),
        TrendDataPoint(level: 2, date: Date.daysAgo(30)),
        TrendDataPoint(level: 5, date: Date.daysAgo(33)),
        TrendDataPoint(level: 5, date: Date.daysAgo(43)),
        TrendDataPoint(level: 5, date: Date.daysAgo(47)),
        TrendDataPoint(level: 2, date: Date.daysAgo(53)),
        TrendDataPoint(level: 3, date: Date.daysAgo(60)),
        TrendDataPoint(level: 2, date: Date.daysAgo(67)),
        TrendDataPoint(level: 1, date: Date.daysAgo(73)),
        TrendDataPoint(level: 4, date: Date.daysAgo(80)),
        TrendDataPoint(level: 2, date: Date.daysAgo(87)),
        TrendDataPoint(level: 3, date: Date.daysAgo(93)),
        TrendDataPoint(level: 2, date: Date.daysAgo(100))
    ]
    
    let points3: [TrendDataPoint] = [
        TrendDataPoint(level: 1, date: Date.daysAgo(12)),
        TrendDataPoint(level: 2, date: Date.daysAgo(22)),
        TrendDataPoint(level: 4, date: Date.daysAgo(23)),
        TrendDataPoint(level: 4, date: Date.daysAgo(30)),
        TrendDataPoint(level: 5, date: Date.daysAgo(33)),
        TrendDataPoint(level: 3, date: Date.daysAgo(43)),
        TrendDataPoint(level: 2, date: Date.daysAgo(47)),
        TrendDataPoint(level: 2, date: Date.daysAgo(53)),
        TrendDataPoint(level: 2, date: Date.daysAgo(60)),
        TrendDataPoint(level: 1, date: Date.daysAgo(67)),
        TrendDataPoint(level: 1, date: Date.daysAgo(73)),
        TrendDataPoint(level: 1, date: Date.daysAgo(80)),
        TrendDataPoint(level: 4, date: Date.daysAgo(87)),
        TrendDataPoint(level: 1, date: Date.daysAgo(93)),
        TrendDataPoint(level: 2, date: Date.daysAgo(100))
    ]
    
    let trend1 = Trend(title: "How stessed", type: .lowerIsBetter)
    let trend2 = Trend(title: "How burned out", type: .lowerIsBetter)
    let trend3 = Trend(title: "How happy", type: .higherIsBetter)
    team.trends = [trend1, trend2, trend3]
    let trendData1 = TrendData(teamMemberId:team.members[0].id, trendId: trend1.id, points: points)
    let trendData2 = TrendData(teamMemberId:team.members[0].id, trendId: trend2.id, points: points)
    let trendData3 = TrendData(teamMemberId:team.members[0].id, trendId: trend3.id, points: points)
    team.members[0].trends = [trendData1, trendData2, trendData3]
    let trendData4 = TrendData(teamMemberId:team.members[1].id, trendId: trend1.id, points: points2)
    let trendData5 = TrendData(teamMemberId:team.members[1].id, trendId: trend2.id, points: points2)
    let trendData6 = TrendData(teamMemberId:team.members[1].id, trendId: trend3.id, points: points3)
    team.members[1].trends = [trendData4, trendData5, trendData6]
    let trendData7 = TrendData(teamMemberId:team.members[2].id, trendId: trend1.id, points: points2)
    let trendData8 = TrendData(teamMemberId:team.members[2].id, trendId: trend2.id, points: points3)
    let trendData9 = TrendData(teamMemberId:team.members[2].id, trendId: trend3.id, points: points3)
    team.members[2].trends = [trendData7, trendData8, trendData9]
    return team
}
extension Date {
    static func daysAgo(_ ago: Int) -> Date {
        return Date(timeIntervalSinceNow: TimeInterval(ago * -86400))
    }
}
