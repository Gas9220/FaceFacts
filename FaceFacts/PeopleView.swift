//
//  PeopleView.swift
//  FaceFacts
//
//  Created by Gaspare Monte on 08/01/24.
//

import SwiftUI
import SwiftData

struct PeopleView: View {
    @Query var people: [Person]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        List {
            ForEach(people) { person in
                NavigationLink(value: person) {
                    Text(person.name)
                }
            }
            .onDelete(perform: deletePerson)
        }
    }

    init(searchString: String = "") {
        _people = Query(filter: #Predicate { person in
            if searchString.isEmpty {
                true
            } else {
                person.name.localizedStandardContains(searchString) ||
                person.emailAddress.localizedStandardContains(searchString) ||
                person.details.localizedStandardContains(searchString)
            }
        })
    }

    func deletePerson(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            modelContext.delete(person)
        }
    }
}

#Preview {
    PeopleView()
}
