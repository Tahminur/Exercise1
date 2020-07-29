//
//  MapDIContainer.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/28/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation

protocol MapControllerFactory{
    
}

final class MapDIContainer:MapControllerFactory{
    
    struct Dependencies{
        let mapRepo:MapRepository
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
    }
    
    func makeMapViewModel() -> MapViewModel{
        return MapViewModel(repository: dependencies.mapRepo)
    }
    
    func makeMapViewController() -> MapViewController{
        return MapViewController()
    }
}
