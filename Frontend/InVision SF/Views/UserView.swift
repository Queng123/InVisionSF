//
//  UserView.swift
//  InVision SF
//
//  Created by Quentin Brejoin on 5/28/25.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var user: User
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    
                    Text("\(user.userName) - My Orders")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)

                if user.items.isEmpty {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("You don't have any tickets yet")
                                .font(.title2)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        Spacer()
                    }
                } else {
                    List(user.items.indices, id: \.self) { index in
                        TicketRowView(ticket: user.items[index])
                    }
                    .listStyle(PlainListStyle())
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct TicketRowView: View {
    let ticket: SelectedTicket
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(ticket.eventName.isEmpty ? "Event" : ticket.eventName)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("\(ticket.ticket.name)    Qty: \(ticket.quantity)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text("\(ticket.eventDate, style: .date) - \(ticket.eventDate, style: .time)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
        .padding(.vertical, 4)
    }
}
