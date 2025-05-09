//
//  SearchBar.swift
//  AppleVision-SF
//
//  Created by Noah tesson on 12/11/24.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search for event"
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search for event",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        searchBar.searchTextField.textColor = .black
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}
