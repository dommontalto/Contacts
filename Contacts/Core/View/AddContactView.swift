//
//  AddContactView.swift
//  Contacts
//
//  Created by Dominic Montalto on 15/04/2025.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Contact Details")) {
                    TextField("First Name", text: $firstName)
                    
                    TextField("Last Name", text: $lastName)
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
            }
            .navigationTitle("Add Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                       dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        // add contact
                       dismiss()
                    }
                    .font(.headline)
                }
            }
        }
    }
}

#Preview {
    AddContactView()
}
