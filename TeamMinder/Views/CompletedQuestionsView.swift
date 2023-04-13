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
            if member.getCompletedQuestions().count > 0 {
                List{
                    ForEach(member.getCompletedQuestions(), id: \.question) { question in
                        SingleCompletedQuestionView(teammember: member, question: question)
                    }
                }
            }else {
                Spacer()
                Text("Add a question and complete it to later review it here").font(.title2)
                Spacer()
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
        CompletedQuestionsView(member: TestData.teamTestData.members[0])
    }
}
