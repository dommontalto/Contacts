//
//  EditContactView.swift
//  Contacts
//
//  Created by Dominic Montalto on 23/04/2025.
//

import SwiftUI

struct EditContactView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ContactsViewModel.self) var viewModel
    
    @State private var contact: Contact
    @State private var contactDidChange = false
    @State private var showExitConfirmation = false
    @State private var showDeleteConfirmation = false
    
    private let originalContact: Contact
    
    init(contact: Contact) {
        _contact = State(initialValue: contact)
        self.originalContact = contact
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("First Name", text: $contact.firstName)
                
                TextField("Last Name", text: $contact.lastName)
                
                TextField("Email", text: $contact.email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            Button("Delete") {
                showDeleteConfirmation.toggle()
            }
        }
        .onChange(of: contact, { oldValue, newValue in
            contactDidChange = newValue != originalContact
        })
        .alert("Delete Contact?", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                deleteContact()
            }
        }
        .alert("Unsaved Changes", isPresented: $showExitConfirmation) {
            Button("Stay", role: .cancel) { }
            Button("Discard Changes", role: .destructive) {
                dismiss()
            }
        }
        .navigationTitle("Edit Contact")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        onCancel()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                       updateContact()
                       dismiss()
                    }
                    .disabled(!contactDidChange)
                    .opacity(contactDidChange ? 1 : 0.5)
                    .font(.headline)
                }
            }
        
    }
}

private extension EditContactView {
    func deleteContact() {
        viewModel.deleteContact(contact)
    }
    
    func onCancel() {
        if contactDidChange {
            showExitConfirmation = true
        } else {
            dismiss()
        }
    }
    
    func updateContact() {
        viewModel.addContact(contact)
    }
}

#Preview {
    EditContactView(
        contact: .init(
            id: "1",
            firstName: "Michael",
            lastName: "Jordan",
            email: "test@gmail.com"
        )
    )
    .environment(ContactsViewModel())
}

