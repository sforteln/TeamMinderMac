//
//  TeamMemberSidebarCell.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/28/23.
//

import SwiftUI

struct TeamMemberSidebarCell: View {
    @ObservedObject var member: TeamMember
    var body: some View {
        NavigationLink(value: member) {
            Text(member.name)
        }
    }
}

struct TeamMemberSidebarCell_Previews: PreviewProvider {
    static var previews: some View {
        TeamMemberSidebarCell(member: testTeamData().members[0])
    }
}
