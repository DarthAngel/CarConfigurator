//
//  Model.swift
//  CarConfigurator
//
//  Created by Angel Docampo on 24/10/25.
//

import Foundation

// We give the struct the codable property so that in a production environment, cars can be obtained through an API connected to the server.

struct Car: Identifiable, Codable, Equatable {
    var id: Int
    var name: String
    var assetName3D: String
    var description: String
}

struct CarParameters {
    
    var carX:Float = 0
    var carY:Float = 0
    var carZ:Float = 0
    var carScale:Float = 1
    var carRotation:Float = 0
    
}
