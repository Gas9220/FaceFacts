//
//  ContentView.swift
//  FaceFacts
//
//  Created by Gaspare Monte on 08/01/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var people: [Person]
    @State private var path = [Person]()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(people) { person in
                    NavigationLink(value: person) {
                        Text(person.name)
                    }
                }
            }
            .navigationTitle("FaceFacts")
            .navigationDestination(for: Person.self) { person in
                EditPersonView(person: person)
            }
            .toolbar {
                Button("Add Person", systemImage: "plus", action: addPerson)
            }
        }
    }

    func addPerson() {
        let person = Person(name: "", emailAddress: "", details: "")
        modelContext.insert(person)
        path.append(person)
    }
}

#Preview {
    ContentView()
}
