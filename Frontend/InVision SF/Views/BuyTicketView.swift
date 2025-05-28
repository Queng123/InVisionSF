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
    var eventName: String = ""
    var eventDate: Date = Date()
}

struct BuyTicketView: View {
    let ticketInfos: [TicketInfo]
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    @State private var selectedTickets: [UUID: SelectedTicket] = [:]
    @State private var expandedTicketId: UUID?
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user: User
    @State private var isProcessingPayment = false
    @State private var showConfirmation = false
    @State private var paymentComplete = false
    let eventName: String

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if paymentComplete {
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                        
                        Text("Tickets Purchased!")
                            .font(.title2)
                            .bold()
                        
                        Text("Your tickets have been added to your cart.")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                } else {
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
                            VStack(alignment: .leading, spacing: 2) {
                                Text(dateFormatter.string(from: selectedDate))
                                    .font(.headline)
                                
                                Text(timeFormatter.string(from: selectedDate))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
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
                }
                
                Spacer(minLength: 20)
                
                if !paymentComplete {
                    Button(action: {
                        showConfirmation = true
                    }) {
                        HStack {
                            Text("Review Order")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .foregroundColor(.white)
                        .background(selectedTickets.isEmpty ? Color.gray : Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(selectedTickets.isEmpty)
                    .sheet(isPresented: $showConfirmation) {
                        NavigationView {
                            PaymentConfirmationView(
                                selectedTickets: Array(selectedTickets.values),
                                eventName: eventName,
                                eventDate: selectedDate,
                                onPaymentComplete: {
                                    paymentComplete = true
                                }
                            )
                        }
                    }
                }

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(paymentComplete ? "Done" : "Return")
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .navigationTitle(paymentComplete ? "Purchase Complete" : "Buy Tickets")
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
                            selectedTickets[ticket.id] = SelectedTicket(ticket: ticket, quantity: i, eventName: eventName, eventDate: Date())
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
}

struct DateSelectionView: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Select Date & Time")
                .font(.title2)
                .bold()
                .padding()
            
            DatePicker(
                "Event Date & Time",
                selection: $selectedDate,
                displayedComponents: [.date, .hourAndMinute]
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

struct PaymentConfirmationView: View {
    let selectedTickets: [SelectedTicket]
    let eventName: String
    let eventDate: Date
    let onPaymentComplete: () -> Void
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user: User
    @State private var isProcessingPayment = false
    @State private var paymentComplete = false
    
    private var totalAmount: Double {
        selectedTickets.reduce(0) { $0 + ($1.ticket.price * Double($1.quantity)) }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if paymentComplete {
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                        
                        Text("Payment Successful!")
                            .font(.title2)
                            .bold()
                        
                        Text("Your tickets have been added to your cart.")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                } else {
                    Text("Order Summary")
                        .font(.title2)
                        .bold()
                    
                    ForEach(selectedTickets, id: \.ticket.id) { ticket in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(ticket.ticket.name)
                                    .font(.headline)
                                Spacer()
                                Text("x\(ticket.quantity)")
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text("Price per ticket:")
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(String(format: "$%.2f", ticket.ticket.price))
                            }
                            
                            HStack {
                                Text("Subtotal:")
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                                Text(String(format: "$%.2f", ticket.ticket.price * Double(ticket.quantity)))
                                    .font(.subheadline)
                                    .bold()
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Total Amount:")
                            .font(.headline)
                        Spacer()
                        Text(String(format: "$%.2f", totalAmount))
                            .font(.headline)
                    }
                    .padding()
                }
                
                Spacer(minLength: 20)
                
                if !paymentComplete {
                    Button(action: {
                        isProcessingPayment = true
                        // Simulate payment processing
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            var newTickets = selectedTickets
                            for i in 0..<newTickets.count {
                                newTickets[i].eventDate = eventDate
                            }
                            user.addTickets(newTickets)
                            isProcessingPayment = false
                            paymentComplete = true
                            onPaymentComplete()
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
                    .disabled(isProcessingPayment)
                }
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(paymentComplete ? "Done" : "Return")
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .navigationTitle(paymentComplete ? "Payment Complete" : "Confirm Payment")
        .background(Color.white.ignoresSafeArea())
    }
}

