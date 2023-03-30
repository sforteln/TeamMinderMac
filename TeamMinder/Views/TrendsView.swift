//
//  TrendsView.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/29/23.
//

import SwiftUI
import Charts





struct TrendsView: View {
    var data : [TrendData]
    
    var body: some View {
        List {
            ForEach(data) { datum in
                TrendsChartView(trendData: datum)
            }
        }
    }
}

struct TrendsChartView: View {
    var trendData : TrendData
    var body: some View {
        VStack{
            Text(trendData.title).font((.largeTitle))
            Chart {
                ForEach(trendData.points) { trendPoint in
                    LineMark(
                        x: .value("date", trendPoint.date),
                        y: .value("scale", trendPoint.level)
                    )
                }
            }
            .chartYScale(domain: [1,5])
            
            VStack{
                HStack{
                    Text("Add today").font(.title3).padding(.leading, 10)
                    Spacer()
                }.padding(.bottom,1)
                HStack{
                    EmojiButton(emoji: "😟", label: "1", action: {})
                    EmojiButton(emoji: "😕", label: "2", action: {})
                    EmojiButton(emoji: "😐", label: "3", action: {})
                    EmojiButton(emoji: "😀", label: "4", action: {})
                    EmojiButton(emoji: "😎", label: "5", action: {})
                    Spacer()
                }.padding([.leading,.bottom], 20)
            }
            
        }
        Spacer()
    }
}

struct EmojiButton: View {
    var emoji : String
    var label : String
    var action : () -> Void
    var body: some View {
        VStack{
            Button(action: action) {
                Text(" \(emoji) ")
            }.font(.largeTitle).buttonStyle(.plain)
            Text(label)
        }.background(.white).cornerRadius(10)
    }
}

struct TrendsView_Previews: PreviewProvider {
    static var previews: some View {

        TrendsView(data: testTrendData())
    }
}



