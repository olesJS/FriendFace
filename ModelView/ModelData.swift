//
//  ModelData.swift
//  FriendFace
//
//  Created by Олексій Якимчук on 02.08.2023.
//

import Foundation
import CoreData

final class ModelData: ObservableObject {
    
    let dataController = DataController.instance
    @Published var users: [User] = []
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        let request = NSFetchRequest<User>(entityName: "User")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            users = try dataController.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = dataController.context
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedData = try? decoder.decode([User].self, from: data) {
                DispatchQueue.main.async { // Dispatch the update on the main thread
                    self.users = decodedData
                    self.saveData()
                    print("success")
                }
            }
        } catch {
            print("Invalid data")
        }
    }
    
    func saveData() {
        dataController.saveData()
        fetchUsers()
    }
}
