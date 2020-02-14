//
//  CardView.swift
//  WhoIsHere
//
//  Created by Marc on 13/02/2020.
//  Copyright © 2020 Marc. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    var image: UIImage
    var name: String
    var login: String
//    var author: String
    

    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
         
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(login)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
//                    Text(author.uppercased())
//                        .font(.caption)
//                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
         
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Simon Ng")
//    }
//}
