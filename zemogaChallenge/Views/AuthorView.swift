//
//  AuthorView.swift
//  zemogaChallenge
//
//  Created by Nico on 2022-11-04.
//

import SwiftUI

struct AuthorView: View {
    @EnvironmentObject var allPost : PostViewModel
    
    var body: some View {
        Text("Author:")
            .font(.title2)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
        if let author = allPost.user {
            VStack{
                HStack{
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                    VStack(alignment: .leading, spacing: 5){
                        HStack{
                            Text("Username:").foregroundColor(.blue).bold()
                            Text(author.username)
                        }
                        HStack{
                            Text("Name:").foregroundColor(.blue).bold()
                            Text(author.name)
                        }
                        HStack{
                            Text("Mail:").foregroundColor(.blue).bold()
                            Text(author.email)
                        }
                        HStack{
                            Text("City:").foregroundColor(.blue).bold()
                            Text(author.address.city)
                        }
                        HStack{
                            Text("Phone:").foregroundColor(.blue).bold()
                            Text(author.phone)
                        }
                        HStack{
                            Text("Website:").foregroundColor(.blue).bold()
                            Text(author.website)
                        }
                    }
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct AuthorView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorView()
    }
}
