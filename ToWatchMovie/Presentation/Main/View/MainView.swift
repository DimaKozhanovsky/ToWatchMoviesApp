//
//  ContentView.swift
//  ToWatchMovie
//
//  Created by Dima Kozhanovsky on 04/10/2023.
//

import SwiftUI

struct MainView: View {
    //  сначала вызовзовутся инициалзаторы
    //  потом переменные потом bady
    // тут сразу создается вьмодель после  MainView()
    
    @StateObject var viewModel  = MainScreenViewModel()
    // создается  MainScreenViewModel() после  MainView()
    
    // так так создаем же то @StateObject
    //SwiftUI’s @StateObject property wrapper is designed to fill a very specific gap in state management: when you need to create a reference type inside one of your views and make sure it stays alive for use in that view and others you share it with.
    //Previously you might have used @ObservedObject to get the same result, but that was dangerous – sometimes, and only sometimes, @ObservedObject could accidentally release the object it was storing, because it wasn’t designed to be the ultimate source of truth for the object. This won’t happen with @StateObject, so you should use it instead.
    
    //Important: You should use @StateObject only once per object, which should be in whichever view is responsible for creating the object. All other views that share your object should use
    
    //    @State private var isExpanded = false
    
    
    
    var body: some View {
    
        switch viewModel.state{
            
        case .moviesList(let movies):
            // cоздали дату сами movies ассосиацивный тип
            // можно вложить второй маасив
            
            VStack{
                HStack {
                    Text("Movie")
                        .foregroundColor(.blue)
                    
                    
                    Spacer()
                    Image(systemName: "circle")
                        .foregroundColor(.blue)
                    
                }
                .padding(.leading, 14.0)
                
                HStack {
                    Text("Popular Movies")
                        .foregroundColor(.blue)
                        .padding(.horizontal , -5)
                        .padding(.vertical , 6)
                    
                    
                    Spacer()
                    
                }
                .padding(13.0)
                .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
                
                
                PreviousView(movies: movies)
                
                
                HStack {
                    Text("TV Shows")
                        .foregroundColor(.blue)
                        .padding(.horizontal  , 2  )
                        .padding(.vertical , 6)
                    
                    Spacer()
                }
                
                PreviousView(movies: movies)
                
                HStack {
                    Text("Continue Watching ")
                        .foregroundColor(.blue)
                        .padding(.horizontal  , 2  )
                        .padding(.vertical , 6)
                    
                    Spacer()
                    
                    
                }
                PreviousView(movies: movies)
                
                
                
                
                Spacer()
                
                
                
                
            }
            .background(Color.black)
            
            
            
            
        case .empty:
            Image(systemName: "photo")
            
        case .idle:
            ProgressView()
            
            
            
        default:
            Text("Error")
        }
        
        
        
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




//
//Binding<T> is the property delegate of @Binding.
//
//$myText gives you a Binding<String>.
//
//The way that @State "does binding work" as you described it, is to give you a Binding<String> initialized with a getter/setter that captures reference of an instance of State<T>.
