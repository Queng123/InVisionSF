//
//  User.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoin on 5/8/25.
//

import SwiftUI

class User: ObservableObject {
    @Published var items: [SelectedTicket] = []
    let userName: String = "Quentin"
    
    func addTickets(_ tickets: [SelectedTicket]) {
        items.append(contentsOf: tickets)
    }
}
