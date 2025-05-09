//
//  UserCart.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoin on 5/8/25.
//

import SwiftUI

class UserCart: ObservableObject {
    @Published var items: [SelectedTicket] = []
    
    func addTickets(_ tickets: [SelectedTicket]) {
        items.append(contentsOf: tickets)
    }
}
