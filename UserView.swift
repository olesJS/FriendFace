//
//  UserView.swift
//  FriendFace
//
//  Created by Олексій Якимчук on 02.08.2023.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        VStack {
            HStack {
                Text(user.wrappedName)
                    .font(.largeTitle).bold()
                Image(systemName: "circle.fill")
                    .foregroundColor(user.isActive ? .green : .gray)
            }
            
            VStack {
                Text("\(user.age) y.o.")
                    .bold()
                Text(user.wrappedEmail)
                Text(user.wrappedAddress)
                Text("Works in \(user.wrappedCompany)")
                Text("Registered since: \(user.formattedRegistered)")
                Text("About me: \(user.wrappedAbout)")
            }
            
            VStack {
                Text("Friends")
                    .font(.title).bold()
                    .padding(.vertical)
                
                ScrollView {
                    ForEach(user.friendsArray) { friend in
                        Text(friend.wrappedName)
                    }
                }
            }
        }
        .navigationTitle("UserView")
        .navigationBarTitleDisplayMode(.inline)
    }
}
