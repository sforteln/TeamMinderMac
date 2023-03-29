//
//  CompletedQuestionsView.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/29/23.
//

import SwiftUI

struct CompletedQuestionsView: View {
    @EnvironmentObject var team: Team
    @ObservedObject var member: TeamMember
    @State private var showAddQuestionSheet = false
    var body: some View {
        VStack {
            List{
                ForEach(member.getCompletedQuestions(), id: \.question) { question in
                    SingleCompletedQuestionView(teammember: member, question: question)
                }
            }
        }
    }
}

struct SingleCompletedQuestionView: View {
    @ObservedObject var teammember: TeamMember
    @ObservedObject var question : Question
    @State private var showCompleteQuestionSheet = false
    var body: some View {
        VStack {
            TitleText("Question")
            TMTextField($question.question)
            TitleText("Notes from \(question.completedDateDisplay())")
            TMTextField($question.notes)
            Divider()
            Spacer()
        }
    }
}

struct CompletedQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedQuestionsView(member: testTeamData().members[0])
    }
}
