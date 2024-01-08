//
//  ContentView.swift
//  FaceFacts
//
//  Created by Gaspare Monte on 08/01/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var people: [Person]

    var body: some View {
        NavigationStack {
            List {
                ForEach(people) { person in
                    NavigationLink(value: person) {
                        Text(person.name)
                    }
                }
            }
            .navigationTitle("FaceFacts")
            .navigationDestination(for: Person.self) { person in
                Text(person.name)
            }
        }
    }
}

#Preview {
    ContentView()
}
