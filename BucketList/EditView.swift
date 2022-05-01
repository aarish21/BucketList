//
//  EditView.swift
//  BucketList
//
//  Created by Aarish on 26/04/22.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel: ViewModel
    
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby..."){
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                                
                        }
                    case .loading:
                        ForEach(0..<10){_ in
                            Text("Loadinjasndjsanjdnsajndjsandjnsajsanjdnjsandjsnaj")
                        }
                        .redacted(reason: .placeholder)
                        
                           
                    case .failed:
                        ForEach(0..<10){_ in
                            Text("Loadinjasndjsanjdnsajndjsandjnsajsanjdnjsandjsnaj")
                        }
                        .redacted(reason: .placeholder)
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save"){
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    init(location: Location,onSave: @escaping (Location)-> Void){
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
        self.onSave = onSave
    }
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example){ newLocation in }
    }
}
