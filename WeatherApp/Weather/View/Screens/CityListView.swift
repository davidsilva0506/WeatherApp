//
//  CityListView.swift
//  WeatherApp
//
//  Created by David Silva on 12/09/2023.
//

import SwiftUI

struct CityListView: View {
    
    private enum Constants {
        
        static let savedCitiesSectionHeader = "Your Saved Cities"
        static let navigationTitle = "Cities"
        static let settingsImageName = "gearshape"
        static let searchThrottle = 3
    }

    @Environment(\.managedObjectContext) private var context

    @EnvironmentObject private var settings: Settings
    @EnvironmentObject private var navigation: Navigation

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var savedCities: FetchedResults<CityDetail>
    
    @StateObject private var viewModel = CityListViewModel()
    @State private var searchTerm = ""

    var body: some View {
            
        NavigationStack {
            
            List {
                
                Section() {
                    
                    ForEach(viewModel.cities, id: \.name) { city in
                        
                        NavigationLink(destination: CityDetailView(city: city)) {
                                
                            Text("\(city.name), \(city.country)")
                                .font(.body)
                                .fontWeight(.semibold)
                                .scaledToFit()
                        }
                    }
                }
                
                Section {
                    
                    ForEach(savedCities, id: \.name) { city in
                        
                        let cityDetail = City(name: city.name,
                                              lat: city.lat,
                                              lon: city.lon,
                                              country: city.country)
                        
                        NavigationLink(destination: CityDetailView(city: cityDetail)) {
                         
                            Text("\(cityDetail.name), \(cityDetail.country)")
                                .font(.body)
                                .fontWeight(.semibold)
                                .scaledToFit()
                        }
                    }
                    .onDelete(perform: deleteCity)

                } header: {
                    
                    if savedCities.isEmpty == false {
                        
                        Text(Constants.savedCitiesSectionHeader)
                    }
                }
                .headerProminence(.increased)
            }
            .navigationTitle(Constants.navigationTitle)
            .listStyle(.insetGrouped)
            .sheet(isPresented: $navigation.isShowingSettingsView) {
                    
                SettingsView()
            }
            .toolbar {

                Button(action: {
                    
                    navigation.isShowingSettingsView = true
                    
                }) {
                    
                    Image(systemName: Constants.settingsImageName)
                }
            }
            .overlay {

                if viewModel.cities.isEmpty &&
                    savedCities.isEmpty {

                    EmptyCityListView()
                }
            }
        }
        .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
        .autocorrectionDisabled(true)
        .onChange(of: searchTerm) { value in
            
            Task {
                
                await search(value: value)
            }
        }
        .alert(item: $viewModel.alertItem) { alert in
            
            Alert(title: alert.title,
                  message: alert.message,
                  dismissButton: alert.dismiss)
        }
    }
}

extension CityListView {
    
    func search(value: String) async {
        
        if value.isEmpty == false,
           value.count >= Constants.searchThrottle {

            await viewModel.search(searchTerm: value)
            
        } else {
            
            viewModel.cities.removeAll()
        }
    }

    func deleteCity(at offsets: IndexSet) {
        
        withAnimation {
            
            offsets.map {
                  
                savedCities[$0]
                
            }.forEach(context.delete)
             
            Task {
             
                await CoreDataService.shared.save(context: context)
            }
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
