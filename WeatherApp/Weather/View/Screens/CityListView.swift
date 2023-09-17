//
//  CityListView.swift
//  WeatherApp
//
//  Created by David Silva on 12/09/2023.
//

import SwiftUI

struct CityListView: View {
    
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var navigation: Navigation

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var savedCities: FetchedResults<CityDetail>
    
    @StateObject private var viewModel = CityListViewModel()
    @State private var searchTerm = ""

    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    Section() {
                        ForEach(viewModel.cities, id: \.name) { city in
                            Button {
                                viewModel.activeCity = city
                                navigation.activeSheet = .cityDetailView
                            } label: {
                                Text("\(city.name), \(city.country)")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .scaledToFit()
                            }
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                            .listRowSeparator(.hidden)
                        }
                    }
                    
                    Section {
                        
                        ForEach(savedCities, id: \.name) { city in
                            Text("\(city.name), \(city.country)")
                                .font(.body)
                                .fontWeight(.semibold)
                                .scaledToFit()
                                .onTapGesture {
                                    
                                    let cityToShow = City(name: city.name,
                                                          lat: city.lat,
                                                          lon: city.lon,
                                                          country: city.country)
                                    
                                    viewModel.activeCity = cityToShow
                                    navigation.activeSheet = .cityDetailView
                                }
                        }
                        .onDelete(perform: deleteCity)

                    } header: {
                        
                        if savedCities.isEmpty == false {
                            Text("Your Saved Cities")
                        }
                    }
                    .headerProminence(.increased)
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Cities")
                .sheet(item: $navigation.activeSheet) { sheet in
                    
                    switch sheet {
                        
                    case .cityDetailView:
                        CityDetailView(city: $viewModel.activeCity)
                    case .seetings:
                        SettingsView(currentUnit: $settings.unit)
                    }
                }
                .toolbar {

                    Button(action: {
                        navigation.activeSheet = .seetings
                     }) {
                        Image(systemName: "gearshape")
                    }
                }
                .overlay {

                    if viewModel.cities.isEmpty &&
                        savedCities.isEmpty {

                        EmptyCityListView()
                    }
                }
            }
            .searchable(text: $searchTerm)
            .autocorrectionDisabled(true)
            .onChange(of: searchTerm) { value in
                
                Task {
                    
                    if value.isEmpty == false,
                       value.count >= 3 {
                        
                        await viewModel.search(searchTerm: value)
                        
                    } else {
                        
                        viewModel.cities.removeAll()
                    }
                }
            }
        }
    }
}

extension CityListView {
    
    func deleteCity(at offsets: IndexSet) {
        
        withAnimation {
            
            offsets.map {
                  
                savedCities[$0]
                
            }.forEach(context.delete)
            
            CoreDataService.shared.save(context: context)
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
