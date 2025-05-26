//
//  BuyTicketView.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoin on 5/8/25.
//

import SwiftUI
import PassKit

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
    @State private var isProcessingPayment = false

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

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Return")
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .navigationTitle("Buy Tickets")
        .background(Color.white.ignoresSafeArea())
    }
    
    private func ticketRow(for ticket: TicketInfo) -> some View {
        _ = selectedTickets[ticket.id] != nil
        let quantity = selectedTickets[ticket.id]?.quantity ?? 0

        return VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "ticket")
                            .foregroundColor(.blue)
                            .font(.system(size: 20))

                        Text(ticket.name)
                            .font(.headline)
                        
                        Text(String(format: "$%.2f", ticket.price))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                    }
                    HStack {
                        Text("Total:")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        Text(String(format: "$%.2f", ticket.price * Double(quantity)))
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                    }
                }

                Spacer()

                Menu {
                    ForEach(0...10, id: \.self) { i in
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
            isProcessingPayment = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let newTickets = Array(selectedTickets.values)
                userCart.addTickets(newTickets)
                
                isProcessingPayment = false
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            HStack {
                if isProcessingPayment {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                    Text("Processing...")
                        .font(.system(size: 16, weight: .medium))
                } else {
                    Image(systemName: "apple.logo")
                        .font(.system(size: 16, weight: .medium))
                    Text("Pay")
                        .font(.system(size: 16, weight: .medium))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .foregroundColor(.white)
            .background(isProcessingPayment ? Color.gray : Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .animation(.easeInOut(duration: 0.2), value: isProcessingPayment)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(selectedTickets.isEmpty || isProcessingPayment)
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

