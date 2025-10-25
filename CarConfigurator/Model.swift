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


