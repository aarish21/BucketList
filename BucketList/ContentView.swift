//
//  ContentView.swift
//  BucketList
//
//  Created by Aarish on 25/04/22.
//

import SwiftUI

import MapKit


struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack{
            if viewModel.isUnlocked{
                ZStack {
                    Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                        MapAnnotation(coordinate: location.coordinate){
                            VStack {
                                Image(systemName: "mappin")
                                    .foregroundColor(.red)
                                    .font(.system(size: 44))
                                Text(location.name)
                                    .fixedSize()
                                }
                            .onTapGesture {
                                viewModel.selectedPlace = location
                            }
                        }
                    }
                    .ignoresSafeArea()
                    Circle()
                        .fill(.blue)
                        .opacity(0.3)
                        .frame(width: 32, height: 32)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                // create a new location
                                viewModel.addLocation()
                            } label: {
                                Image(systemName: "plus")
                                    .padding()
                                    .background(.black.opacity(0.75))
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .clipShape(Circle())
                                    .padding()
                            }
                            
                        }
                    }
                }
                .sheet(item: $viewModel.selectedPlace){ place in
                    EditView(location: place) { newLocation in
                        viewModel.update(location: newLocation)
                    }
                }
            }else{
                Button("Unlock Places") {
                    viewModel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $viewModel.unlockError) {
                Alert(title: Text("Authentication Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("Dismiss")))
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
