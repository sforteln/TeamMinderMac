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
            HStack {
                Text("Question").font(.headline)
                Spacer()
            }
            TextField("Question", text: $question.question, axis: .vertical)
                .lineLimit(2...10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 2)
                )
                
            HStack {
                Text("Notes from \(question.completedDateDisplay())")
                    .font(.headline)
                Spacer()
            }
             TextField("Notes", text: $question.notes, axis: .vertical)
                 .lineLimit(2...10)
                 .overlay(
                     RoundedRectangle(cornerRadius: 8)
                         .stroke(Color.gray, lineWidth: 2)
                 )
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
