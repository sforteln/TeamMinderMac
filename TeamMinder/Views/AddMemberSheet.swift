//
//  sidebar.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/27/23.
//

import SwiftUI
               
struct AddTeamMemberSheet: View {
  @EnvironmentObject var team: Team
  @Environment(\.dismiss) var dismiss
  @State private var name = ""
   var body: some View {
       ZStack {
        
           VStack {
               Text("Team member name")
               TextField("Team member name", text: $name)
               HStack {
                  Button {
                      if name.count > 0 {
                          team.addMember(name: name)
                          dismiss()
                      }
                  } label: {
                      Text("Add a team member")
                          .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                  }
                  Button {
                     dismiss()
                  } label: {
                      Text("Cancel")
                          .foregroundColor(.black)
                  }
               }
           }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding()
   }
}

