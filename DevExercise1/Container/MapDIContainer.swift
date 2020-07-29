//
//  MapDIContainer.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/28/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation


final class MapDIContainer{
    
    
    struct Dependencies{
        let mapRepo:MapRepository
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
    }
    
    func makeMapViewModel(){
        
    }
}
