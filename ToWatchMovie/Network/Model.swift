//
//  Model.swift
//  ToWatchMovie
//
//  Created by Dima Kozhanovsky on 04/10/2023.
//

import Foundation
//  эта модель отвечает за нетворкинк
struct DataForPreview : Decodable {
    let  preview : [ImagesForPreview]?
    
    
    enum CodingKeys: String, CodingKey {
        case preview = "items"
        
        // создаем свои удобные названия для того что прриходит с чейсона
    }
    
    
}

struct ImagesForPreview : Decodable {
    let imageUrl : String?
    let previewUrl : String?
    
    // id создаем чтобы сожно было передать в 
}



