//
//  ContentView.swift
//  19930331-ThrinadhPonnapatiNYCSchools
//
//  Created by Thrinadh Ponnapati  on 9/13/23.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        SchoolListView()
    }
}

struct School: Identifiable, Decodable {
    let id: String
    let schoolName: String
    let takers: String
    let reading: String
    let mathAvgScore: String
    let writingAngScore: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case schoolName = "school_name"
        case takers = "num_of_sat_test_takers"
        case reading = "sat_critical_reading_avg_score"
        case mathAvgScore = "sat_math_avg_score"
        case writingAngScore = "sat_writing_avg_score"
    }
}

struct SchoolListView: View {
    @State private var schools: [School] = []
    @State private var searchText = ""
    
    func fetchSchools() {
        // https://data.cityofnewyork.us/resource/f9bf-2cp4.json
        guard let url = URL(string:"https://data.cityofnewyork.us/resource/f9bf-2cp4.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([School].self, from: data)
                    DispatchQueue.main.async {
                        self.schools = decodedData
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
    var body: some View {
        NavigationView {
            List(schools.filter { searchText.isEmpty || $0.schoolName.localizedCaseInsensitiveContains(searchText) }) { school in
                NavigationLink(destination: SchoolDetailView(school: school)) {
                    Text(school.schoolName)
                }
            }
            .navigationTitle("NYC High Schools")
            .searchable(text: $searchText)
        }
        .onAppear {
            fetchSchools()
        }
    }
}

struct SchoolDetailView: View {
    let school: School
    
    var body: some View {
        VStack {
            Text("School Name: \(school.schoolName)")
            Text("Takers: \(school.takers)")
            Text("Reading: \(school.reading)")
            Text("Maths: \(school.mathAvgScore)")
            Text("Writing: \(school.writingAngScore)")
        }
        .navigationBarTitle(school.schoolName, displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView()
    }
}
