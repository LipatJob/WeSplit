//
//  ContentView.swift
//  WeSplit
//
//  Created by Job Lipat on 2/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var subtotal = 0.0
    @State private var numberOfPeopleIndex = 2
    @State private var tipPercentage = 20
    
    @FocusState private var isAmountFocused: Bool
    
    let tipPercentages = 0...100
    
    var totalAmount: Double{
        let tipSelected = Double(tipPercentage)
        let tipAmount = subtotal * tipSelected / 100
        return subtotal + tipAmount
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeopleIndex + 2)
        let tipSelected = Double(tipPercentage)
        let tipAmount = subtotal * tipSelected / 100
        return (subtotal + tipAmount) / peopleCount
    }
    
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    TextField(
                        "Amount",
                        value: $subtotal,
                        format: .currency(code: "PHP")
                    )
                    .keyboardType(.decimalPad)
                    .focused($isAmountFocused)
                    Picker("number of people",
                           selection: $numberOfPeopleIndex){
                        ForEach(0..<100){Text("\($0) people")}
                    }
                }
                
                Section("How much do you want to tip"){
                    Picker("Tip precentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){Text($0, format: .percent)}
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                Section("Total Amount"){
                    Text(totalAmount, format: .currency(code: "PHP"))
                }
                Section("Amount per Person"){
                    Text(totalPerPerson, format: .currency(code: "PHP"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar(content: {
                ToolbarItemGroup(placement: isAmountFocused ? .keyboard : .automatic){
                    Spacer()
                    Button("Done"){
                        isAmountFocused.toggle()
                    }
                }
            })
        }
        
    }
}

#Preview {
    ContentView()
}
