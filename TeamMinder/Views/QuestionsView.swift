//
//  QuestionsView.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/27/23.
//

import SwiftUI

struct QuestionsView: View {
    @EnvironmentObject var team: Team
    @ObservedObject var member: TeamMember
    @State private var showAddQuestionSheet = false
    var body: some View {
        VStack {
            List{
                ForEach(member.getNotCompletedQuestions(), id: \.question) { question in
                    SingleQuestionView(teammember: member, question: question)
                }
                
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {showAddQuestionSheet.toggle()}) {
                    Text("Add Question")
//                        .foregroundColor(.blue)
                    
                }
                .padding(1.0)
                .buttonStyle(.bordered)
                .sheet(isPresented: $showAddQuestionSheet) { AddQuestionSheet(teammember: member) }
                Spacer()
            }
        }
    }
}

struct SingleQuestionView: View {
    @ObservedObject var teammember: TeamMember
    @ObservedObject var question : Question
    @State private var showCompleteQuestionSheet = false
    var body: some View {
        HStack {
            TMTextField($question.question)
            Spacer()
            Button(action: {showCompleteQuestionSheet.toggle()}, label: {
                Label("Complete", systemImage: "checkmark.seal").foregroundColor(.green)
            }).sheet(isPresented: $showCompleteQuestionSheet) { CompleteQuestionSheet(teammember: teammember,question: question) }
            Spacer()
        }
    }
}

struct CompleteQuestionSheet: View {
    @ObservedObject var teammember: TeamMember
    @ObservedObject var question: Question
    @Environment(\.dismiss) var dismiss
    @State private var notes = ""
    var body: some View {
        ZStack {
            
            VStack {
                Text("Notes")
                TextField("Notes", text: $notes, axis: .vertical).lineLimit(5...10)
                HStack {
                    Spacer(minLength: 40)
                    Button {
                        teammember.complete(question: question, notes: notes)
                        dismiss()
                    } label: {
                        Text("Complete Question")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    
                    Spacer(minLength: 30)
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                    }
                    Spacer(minLength: 40)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding()
    }
}

struct AddQuestionSheet: View {
    @ObservedObject var teammember: TeamMember
    @Environment(\.dismiss) var dismiss
    @State private var question = ""
    var body: some View {
        ZStack {
            
            VStack {
                Text("Question")
                TextField("Question", text: $question, axis: .vertical).lineLimit(5...10)
                HStack {
                    Spacer(minLength: 40)
                    Button {
                        teammember.addQuestion(question: question)
                        dismiss()
                    } label: {
                        Text("Add a Question")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    Spacer(minLength: 30)
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                    }
                    Spacer(minLength: 40)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding()
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView( member: testTeamData().members[0]).environmentObject(testTeamData())
    }
}
