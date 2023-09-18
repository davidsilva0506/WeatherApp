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
    }

    @Environment(\.managedObjectContext) private var context

    @EnvironmentObject private var settings: Settings
    @EnvironmentObject private var navigation: Navigation

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var savedCities: FetchedResults<CityDetail>

    @StateObject private var viewModel: CityListViewModel

    @State private var searchTerm = ""
    
    private let service: ServiceLayer
    private let coreDataService: CoreDataService
    
    init(service: ServiceLayer, coreDataService: CoreDataService) {
        
        _viewModel = StateObject(wrappedValue: CityListViewModel(service: service))
        self.service = service
        self.coreDataService = coreDataService
    }

    var body: some View {
            
        NavigationStack {
            
            List {
                
                Section() {
                    
                    ForEach(self.viewModel.cities, id: \.name) { city in
                        
                        CityDetailNavigationLink(service: self.service,
                                                 coreDataService: self.coreDataService,
                                                 city: city)
                    }
                }
                
                Section {
                    
                    ForEach(self.savedCities, id: \.name) { city in
                        
                        let cityDetail = City(name: city.name,
                                              lat: city.lat,
                                              lon: city.lon,
                                              country: city.country)
                        
                        CityDetailNavigationLink(service: self.service,
                                                 coreDataService: self.coreDataService,
                                                 city: cityDetail)
                    }
                    .onDelete(perform: deleteCity)

                } header: {
                    
                    if self.savedCities.isEmpty == false {
                        
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
                    
                    self.navigation.isShowingSettingsView = true
                    
                }) {
                    
                    Image(systemName: Constants.settingsImageName)
                }
            }
            .overlay {

                if self.viewModel.cities.isEmpty &&
                    self.savedCities.isEmpty {

                    EmptyCityListView()
                }
            }
        }
        .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
        .autocorrectionDisabled(true)
        .onChange(of: searchTerm) { value in
            
            Task {
                
                await self.viewModel.search(searchTerm: value)
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

    func deleteCity(at offsets: IndexSet) {
        
        withAnimation {
            
            offsets.map {
                  
                self.savedCities[$0]
                
            }.forEach(self.context.delete)
             
            Task {
             
                await self.coreDataService.save(context: self.context)
            }
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView(service: ServiceLayer(), coreDataService: CoreDataService())
    }
}
