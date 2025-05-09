//
//  BuyTicketView.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoin on 5/8/25.
//

import SwiftUI

struct SelectedTicket {
    let ticket: TicketInfo
    var quantity: Int = 1
}

struct BuyTicketView: View {
    let ticketInfos: [TicketInfo]
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    @State private var selectedTickets: [UUID: SelectedTicket] = [:]
    @State private var expandedTicketId: UUID?
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userCart: UserCart

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Select a Ticket")
                    .font(.title2)
                    .bold()
                
                ForEach(ticketInfos) { ticket in
                    ticketRow(for: ticket)
                }

                Divider()
                
                Button(action: {
                    showDatePicker = true
                }) {
                    HStack {
                        Text(dateFormatter.string(from: selectedDate))
                            .font(.headline)
                        
                        Spacer()
                        
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                .sheet(isPresented: $showDatePicker) {
                    DateSelectionView(selectedDate: $selectedDate, isPresented: $showDatePicker)
                        .padding()
                }
                
                Spacer(minLength: 20)
                
                buyButton
            }
            .padding()
        }
        .navigationTitle("Buy Tickets")
    }
    
    private func ticketRow(for ticket: TicketInfo) -> some View {
        _ = selectedTickets[ticket.id] != nil
        let quantity = selectedTickets[ticket.id]?.quantity ?? 1

        return VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    Text(ticket.name)
                        .font(.headline)
                    Text(String(format: "$%.2f", ticket.price * Double(quantity)))
                        .font(.subheadline)
                }

                Spacer()

                Menu {
                    ForEach(1...10, id: \.self) { i in
                        Button(action: {
                            selectedTickets[ticket.id] = SelectedTicket(ticket: ticket, quantity: i)
                        }) {
                            Text("\(i)")
                            if quantity == i {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text("\(quantity)")
                        Image(systemName: "chevron.down")
                    }
                    .padding(8)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(6)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }

    
    private var buyButton: some View {
        Button(action: {
            let newTickets = Array(selectedTickets.values)
            userCart.addTickets(newTickets)

            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Buy Now")
                .frame(maxWidth: .infinity)
                .padding()
                .background(!selectedTickets.isEmpty ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disabled(selectedTickets.isEmpty)
    }


}

struct DateSelectionView: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Select a Date")
                .font(.title2)
                .bold()
                .padding()
            
            DatePicker(
                "Event Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            
            Button("Confirm") {
                isPresented = false
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

