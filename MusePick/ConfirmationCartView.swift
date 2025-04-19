//
//  ConfirmationCartView.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 19/04/25.
//

import SwiftUI

struct ConfirmationView: View {
    @State private var isPaymentAlertPresented = false
    @State private var isAddressAlertPresented = false
    @State private var proceedToFinalPage = false
    @State private var selectedDeliveryOption = "I'll pick it up Myself"
    @State private var address = ""
    @State private var cardNumber = ""
    @State private var cartItemCount: Int = 0
    @State private var highlight: Int = 2

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack {

                    Text("Confirmation Check")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.black)
                        .padding()
                }


                // Payment Method
                SectionView(title: "Payment Method", detail: cardNumber.isEmpty ? "Card not available Please add" : cardNumber , imageName: "creditcard", showAlert: {
                    isPaymentAlertPresented = true
                }).padding()

                // Delivery Address
                SectionView(title: "Delivery Address", detail: address.isEmpty ? "Address not added yet" : address , imageName: "house", showAlert: {
                    isAddressAlertPresented = true
                }).padding()

                DeliveryOptionRadioButtons(selectedOption: $selectedDeliveryOption)

                HStack {
                    Text("Non-Contact Delivery (Default)")
                        .fontWeight(.bold)
                    Spacer()
                    Toggle(isOn: .constant(true)) {
                        // Leaving it Empty
                    }
                    .labelsHidden()
                    .tint(.purple)
                }
                .padding()
                Spacer()
                Button("Proceed") {
                    proceedToFinalPage = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)

                Spacer()

                CustomNavigationBar(cartItemCount: $cartItemCount, highlightedIcon: $highlight)
            }
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
            .alert("Add new  Card Number", isPresented: $isPaymentAlertPresented) {
                TextField("Enter the 12 digit cardNumber", text: $cardNumber)
                    .keyboardType(.numberPad)
                Button("OK", action: submitCardNumber)
            }
                .alert("Change Delivery Address", isPresented: $isAddressAlertPresented) {
                    TextField("Enter the Required Quantity", text: $address)
                    Button("OK", action: submit)
                }
                .navigationDestination(isPresented: $proceedToFinalPage) {
                    FinalContentView()
                }
            .onAppear() {
                if CommonVariables.address.isEmpty {
                    address = ""
                } else {
                    address = CommonVariables.address
                }
                
                if CommonVariables.cardNumber.isEmpty {
                    cardNumber = ""
                } else {
                    cardNumber = CommonVariables.cardNumber
                }
                
                cartItemCount = CommonVariables.shoppingCartListItem.count

            }
        }
    }
    
    func submit() {
        if address.isEmpty, !containsAlphaNumeric(text: address) {
            address = "address Not Added"
        } else {
             CommonVariables.address = address
        }
    }
    
    func submitCardNumber() {
        if cardNumber.isEmpty, !containsAlphaNumeric(text: cardNumber) {
            cardNumber = "Card Number not saved"
        } else {
            CommonVariables.cardNumber = cardNumber
        }
    }
    
    func containsAlphaNumeric(text: String) -> Bool {
            let alphaNumericRegex = "[a-zA-Z0-9]+"
            let alphaNumericTest = NSPredicate(format:"SELF MATCHES %@", alphaNumericRegex)
            return alphaNumericTest.evaluate(with: text)
        }
}

struct SectionView: View {
    let title: String
    let detail: String
    let imageName: String
    let showAlert: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            SectionHeader(title: title, showAlert: showAlert)
            HStack {
                Image(systemName: imageName)
                    .foregroundColor(.purple)
                Text(detail)
            }
            .padding(.horizontal)
        }
    }
}

struct SectionHeader: View {
    let title: String
    let showAlert: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            Button("CHANGE") {
                showAlert()
            }
            .foregroundColor(.purple)
        }
        .padding()
    }
}

struct DeliveryOptionRadioButtons: View {
    @Binding var selectedOption: String
    let options = [
        ("I'll pick it up Myself", "figure.walk"),
        ("By Courier", "bicycle"),
        ("By Drone", "airplane")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Delivery Options")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .padding(.leading, 30)
            .padding(.bottom, 15)

            ForEach(options, id: \.0) { (title, imageName) in
                Button(action: {
                    selectedOption = title
                }) {
                    HStack {
                        Image(systemName: title == selectedOption ? "largecircle.fill.circle" : "circle")
                            .foregroundColor(.purple)
                        Image(systemName: imageName)
                            .foregroundColor(.purple)
                        Text(title)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.leading, 30)
            }
        }
        .padding(.top, 8)
        
    }
}
