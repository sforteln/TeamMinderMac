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
                ForEach(member.questions, id: \.question) { question in
                    SingleQuestionView(question: question)
                }
                
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {showAddQuestionSheet.toggle()}) {
                    Text("Add Question")
                        .foregroundColor(.blue)
                    
                }.padding(1.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .sheet(isPresented: $showAddQuestionSheet) { AddQuestionSheet(teammember: member) }
                Button(action: {}) {
                    Text("Previous Questions")
                        .foregroundColor(.blue)
                    
                }.padding(1.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                Spacer()
            }
        }
    }
}

struct SingleQuestionView: View {
    @ObservedObject var question : Question
    @State private var showCompleteQuestionSheet = false
    var body: some View {
        HStack {
            TextField("Family", text: $question.question, axis: .vertical)
                .lineLimit(2...10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                
            Spacer()
            Button(action: {showCompleteQuestionSheet.toggle()}, label: {
                Label("Complete", systemImage: "checkmark.seal").foregroundColor(.green)
            }).sheet(isPresented: $showCompleteQuestionSheet) { CompleteQuestionSheet(question: question) }
            Spacer()
        }
    }
}

struct CompleteQuestionSheet: View {
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
                        question.complete(notes: notes)
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
