//
//  QuestionsView.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/27/23.
//

import SwiftUI

struct QuestionsView: View {
    @EnvironmentObject var team: Team
    
    var body: some View {
        if team.members.count == 0 {
            NoTeamViewOfFull()
        }else {
            FullQuestionsView()
        }    }
}

struct FullQuestionsView: View {
    @EnvironmentObject var team: Team
    
    var body: some View {
        Text("qs")
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView()
    }
}
