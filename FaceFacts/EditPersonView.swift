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
    @Binding var navigationPath: NavigationPath
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
                        .tag(Optional<Event>.none)

                    if !events.isEmpty {
                        Divider()

                        ForEach(events) { event in
                            Text(event.name)
                                .tag(Optional(event))
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
        .navigationDestination(for: Event.self) { event in
            EditEventView(event: event)
        }
    }

    func addEvent() {
        let event = Event(name: "", location: "")
        modelContext.insert(event)
        navigationPath.append(event)
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return EditPersonView(navigationPath: .constant(NavigationPath()), person: previewer.person)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
