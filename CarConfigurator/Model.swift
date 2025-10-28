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


let carPlaceHolder = Car(id: 1, name: "Mercedes-AMG A45", assetName3D: "2020_Mercedes-Benz_A45_S_AMG_4Matic", description: """
The Mercedes-AMG A45 is a high-performance "hot hatch" known for its powerful turbocharged engine, all-wheel drive, and sporty design. It combines a luxurious interior with aggressive performance, offering a dynamic driving experience that can be comfortable for daily use or thrilling for performance driving. The A45S is a higher-performance version that features even more power, sharper handling, and additional upgrades like drift mode.
""")



