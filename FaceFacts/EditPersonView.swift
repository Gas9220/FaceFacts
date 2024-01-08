//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by Gaspare Monte on 08/01/24.
//

import SwiftUI
import SwiftData

struct EditPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var person: Person
    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)

                TextField("Email address", text: $person.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }

            Section("Where did you meet them?") {
                Picker("met at", selection: $person.metAt) {
                    Text("Unknown event")

                    if !events.isEmpty {
                        Divider()

                        ForEach(events) { event in
                            Text(event.name)
                        }
                    }
                }

                Button("Add a new event", action: addEvent)
            }

            Section("Notes") {
                TextField("Details about this person", text: $person.details, axis: .vertical)
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
    }

    func addEvent() {
        let event = Event(name: "", location: "")
        modelContext.insert(event)
    }
}

//#Preview {
//    EditPersonView()
//}
