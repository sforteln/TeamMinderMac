//
//  Styling.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/29/23.
//

import SwiftUI

struct QuestionTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.black)
            .padding([.top,.bottom], 2.0)
            .background(Color(red: 0.95, green: 0.95, blue: 0.95, opacity: 1.0))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
    }
}
extension View {
    func questionTextFieldStyle() -> some View {
        modifier(QuestionTextFieldStyle())
    }
}

extension View {
    func QuestionTextField(_ textBinding: Binding<String>) -> some View {
        return HStack {
            Spacer(minLength: 8)
            TextField("", text: textBinding, axis: .vertical)
                .lineLimit(2...10).questionTextFieldStyle()
        }
    }
}

extension View {
    func TitleText(_ text: String) -> some View {
        return HStack {
            Text(text).font(.headline)
            Spacer()
        }
    }
}

