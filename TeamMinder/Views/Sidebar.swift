//
//  sidebar.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/27/23.
//

import SwiftUI

struct Sidebar: View {
    @EnvironmentObject var team: Team
    @State private var showAddUserSheet = false
    @State private var selection: TeamMember?
    var body: some View {
        
        List(selection: $selection){
            Text("Team")
                .font(.headline)
            Divider()
            ForEach(team.members, id: \.name) { member in
                NavigationLink(value: member) {
                    Text(member.name)
                }
            }
            Spacer()
            
        }
        
        
        Button(action: {
            showAddUserSheet.toggle()
        }, label: {
            Label("Add Teammate", systemImage: "person.fill.badge.plus").font(.subheadline)
        })
        .padding([.leading, .trailing], 2.0)
        .padding(.bottom, 4.0)
        .sheet(isPresented: $showAddUserSheet) { AddTeamMemberSheet() }
    }
}
               
struct AddTeamMemberSheet: View {
  @EnvironmentObject var team: Team
  @Environment(\.dismiss) var dismiss
  @State private var name = ""
   var body: some View {
       ZStack {
        
           VStack {
               Text("Teammate name")
               TextField("Teammate name", text: $name)
               HStack {
                  Button {
                      if name.count > 0 {
                          team.addMember(name: name)
                          dismiss()
                      }
                  } label: {
                      Text("Add Teammate")
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

struct sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar().environmentObject(testTeamData())
    }
}
