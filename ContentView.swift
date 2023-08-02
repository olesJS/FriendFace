//
//  ContentView.swift
//  FriendFace
//
//  Created by Олексій Якимчук on 02.08.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(modelData.users) { user in
                        NavigationLink {
                            UserView(user: user)
                        } label: {
                            HStack {
                                Text(user.wrappedName)
                                Spacer()
                                Text(user.isActive ? "Online" : "Offline")
                                Image(systemName: "circle.fill")
                                    .foregroundColor(user.isActive ? .green : .gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("FriendFace")
            .toolbar {
                Button("Save") {
                    Task {
                        modelData.saveData()
                    }
                }
            }
        }
        .task {
            if modelData.users.isEmpty {
                await modelData.loadData()
            }
        }
    }
}

