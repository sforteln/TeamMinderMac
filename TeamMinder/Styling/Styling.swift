//
//  Styling.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/29/23.
//

import SwiftUI

struct TMTextFieldStyleVM: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 1.0))
            .padding( 2.0)
            .background(Color(red: 0.85, green: 0.85, blue: 0.85, opacity: 1.0))
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .padding([.top,.bottom], 2.0)
//            .font(.title3)
//            .foregroundColor(.black)
//            .padding([.top,.bottom], 2.0)
//            .background(Color(red: 0.95, green: 0.95, blue: 0.95, opacity: 1.0))
//            .clipShape(RoundedRectangle(cornerRadius: 8))
            
    }
}
extension View {
    func TMTextFieldStyle() -> some View {
        modifier(TMTextFieldStyleVM())
    }
}

extension View {
    func TMTextField(_ textBinding: Binding<String>) -> some View {
        return HStack {
            Spacer(minLength: 8)
            TextField("", text: textBinding, axis: .vertical)
                .lineLimit(2...10).TMTextFieldStyle()
        }
    }
}

extension View {
    func TMTextField(_ textBinding: Binding<String>, limit: ClosedRange<Int>) -> some View {
        return HStack {
            Spacer(minLength: 8)
            TextField("", text: textBinding, axis: .vertical)
                .lineLimit(2...10).TMTextFieldStyle()
        }
    }
}

extension View {
    func TMSingleLineTextField(_ textBinding: Binding<String>) -> some View {
        return HStack {
            Spacer(minLength: 8)
            TextField("", text: textBinding).TMTextFieldStyle()
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

extension View {
    func TMButton(color: Color, action: @escaping () -> Void, text: String) -> some View {
        return Button(action: action) {
            Text(text).foregroundColor(color)
        }.padding(4.0).buttonStyle(.bordered).tint(color)
    }
}

extension View {
    func TMTextEditor(_ binding: Binding<String>) -> some View {
        TextEditor(text: binding)
            .font(.title3)
            .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 1.0))
            .padding( 2.0)
            .background(Color(red: 0.85, green: 0.85, blue: 0.85, opacity: 1.0))
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .padding([.top,.bottom], 2.0)
    }
}
