//
//  TeamTrendsView.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/29/23.
//

import SwiftUI
import Charts

struct TeamTrendsView: View {
    @EnvironmentObject var team: Team
    @State private var showAddTrendSheet = false
    
    var body: some View {
        Group {
            if team.trends.count > 0 {
                List {
                    ForEach(team.trends) { trend in
                        TeamTrendChartView(trend: trend)
                    }
                }
            }
            AddTrendButton()
        }
    }
}

struct AddTrendButton: View {
    @EnvironmentObject var team: Team
    @State private var showAddTrendSheet = false
    var body: some View {
        Button(action: {
            showAddTrendSheet.toggle()
        }, label: {
            Label("Add new trend", systemImage: "chart.xyaxis.line").font(.subheadline)
        })
        .padding([.leading, .trailing], 2.0)
        .padding(.bottom, 4.0)
        .sheet(isPresented: $showAddTrendSheet) { AddTrendSheet() }
    }
}

struct TeamTrendChartView: View {
    @EnvironmentObject var team: Team
    @State var trend : Trend
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(trend.title).font((.largeTitle))
                Spacer()
            }
            Text("(\(trend.type.rawValue))")
        }.padding(.bottom,2)
        
        Chart {
            ForEach(team.members) { member in
                if let trendData = member.trends.first { $0.trendId == trend.id} {
                    ForEach(trendData.points) { trendPoint in
                        LineMark(
                            x: .value("date", trendPoint.date),
                            y: .value("scale", trendPoint.level)
                        )
                        .foregroundStyle(by: .value("Person", "\(member.name)"))
                    }
                }
            }
        }
        .chartYScale(domain: [0,5])
    }
}

struct AddTrendSheet: View {
  @EnvironmentObject var team: Team
  @Environment(\.dismiss) var dismiss
  @State private var name = ""
    @State private var type : TrendType = .higherIsBetter
   var body: some View {
       ZStack {
        
           VStack {
               Text("Trend name")
               TextField("Trend name", text: $name)
               Picker(selection: $type, label: Text("Type:")) {
                   Text(TrendType.higherIsBetter.rawValue).tag(TrendType.higherIsBetter)
                   Text(TrendType.lowerIsBetter.rawValue).tag(TrendType.lowerIsBetter)
               }.pickerStyle(RadioGroupPickerStyle())
               Spacer()
               HStack {
                  Button {
                      if name.count > 0 {
                          team.addTrend(title: name, type: type)
                          dismiss()
                      }
                  } label: {
                      Text("Add trend")
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

struct TeamTrendsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamTrendsView().environmentObject(TestData.teamTestData)
    }
}
