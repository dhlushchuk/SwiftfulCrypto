//
//  SearchBarView.swift
//  SwiftfulCrypto
//
//  Created by Dzmitry Hlushchuk on 9.12.24.
//

import SwiftUI

struct SearchBarView: View {
    // MARK: - Properties
    @Binding var searchText: String
    @FocusState private var focusState: Bool
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled()
                .focused($focusState)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
//                            UIApplication.shared.endEditing()
                            focusState = false
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10)
        )
        .padding()
    }
}

// MARK: - Preview
#Preview("Light") {
    SearchBarView(searchText: .constant(""))
}

#Preview("Dark") {
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
}
