//
//  PreviousView.swift
//  ToWatchMovie
//
//  Created by Dima Kozhanovsky on 21/10/2023.
//

import SwiftUI

struct PreviousView: View {
    
    let movies: [MovieModel]
    
    init(movies: [MovieModel]) {
        self.movies = movies
    }
    
    var body: some View {
        ScrollView(.horizontal){
            LazyHStack(spacing: 0){
                
                //
                ForEach(movies, id: \.id) { movie in
                    if let url = movie.url {
                        ImageLoaderView(imageUrlString: url, placeholder: {
                            Text("Урр")
                        }, progressBlock: {
                            Text("Грузится")
                        })
                        .scaledToFill()
                        .frame(height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .padding(.horizontal, 20)
                    } else {
                        Image(systemName: "photo")
                    }
                    
                }
                
            }
            
            
            
            
        }
        .padding(.leading, -63.0)
        .frame(width: 300,height: 150)
    }
}
    struct PreviousView_Previews: PreviewProvider {
        static var previews: some View {
            PreviousView(movies: [])
        }
    }
