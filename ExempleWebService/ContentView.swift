//
//  ContentView.swift
//  ExempleWebService
//
//  Created by Maxime Britto on 29/07/2020.
//

import SwiftUI

struct User:Identifiable, Codable {
    let id:Int
    let name:String
    let email:String
}

struct ContentView: View {
    @State var userList:[User] = []
    @State var isLoading = true
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Chargement des utilisateurs")
            } else {
                List(userList) { user in
                    Text(user.name)
                }.padding()
            }
        }
        .onAppear {
            loadUserList()
        }
    }
    
    
    func loadUserList() {
        guard let userListApiUrl = URL(string: "https://jsonplaceholder.typicode.com/users") else { return  }
        
        
        URLSession.shared.dataTask(with: userListApiUrl) { data, response, error in
            if let data = data {
                do {
                    let dataUserList = try JSONDecoder().decode([User].self, from: data)
                    
                    self.userList = dataUserList
                    self.isLoading = false
                    
                } catch let error {
                    print(error)
                }
            }
        }.resume()
       
        
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
