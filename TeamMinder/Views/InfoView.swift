//
//  InfoView.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/27/23.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var team: Team
    @State var member: TeamMember
    
    init(member: TeamMember) {
        self.member = member
    }
    
    var body: some View {
        if team.members.count == 0 {
            NoTeamViewOfFull()
        }else {
            FullInfoView(member: member)
        }
    }
}

struct FullInfoView: View {
    @State var member: TeamMember
    var body: some View {
        Text(member.name)
        
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(member: testTeamData().members[0])
    }
}
