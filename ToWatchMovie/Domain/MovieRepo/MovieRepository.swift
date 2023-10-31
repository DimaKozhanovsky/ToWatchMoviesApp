//
//  MovieRepositorei.swift
//  ToWatchMovie
//
//  Created by Dima Kozhanovsky on 21/10/2023.
//

import Foundation

class MovieRepository {
    
    @Published var movies: [MovieModel] = []
    //
    
    init() {
        getMovies()
    }

    
    func getMovies()  {
        NetworkService.getYandexpreview(imagePreview: Endpoints.imageId) {[weak self] result in
            // xчтобы кложур не захватывал сильную сылку
            
            guard let self = self else {
                return
            }
            // развертывание селфа
            switch result {
            case .failure(let error):
                #warning("Handle error")
                debugPrint(error)
                //дебаг принт чтобы когда выпущу приложение
                break
            case .success( let datapreview) :
                guard let previes = datapreview.preview else {
                    return 
                }
                //compactMap может перебирать опционалы погонять мапы ( основые методы для работы с масивами ) обязательно!!!!!!
                self.movies = previes.map({ modelYandex in
                    return self.fromYandexDataToMovieModel(modelYandex)
                })
            }
        }
    }
    private func fromYandexDataToMovieModel(_ model: ImagesForPreview) -> MovieModel {
        return MovieModel(
            id: UUID(),
            url: model.imageUrl
        )
    }
    
    
}



 
