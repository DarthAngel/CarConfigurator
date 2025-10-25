//
//  ContentView.swift
//  CarConfigurator
//
//  Created by Angel Docampo on 10/10/25.
//

import SwiftUI
import RealityKit



struct ContentView : View {

    
    
    @State private var carX:Float = 0
    @State private var carY:Float = 0
    @State private var carZ:Float = 0
    @State private var carScale:Float = 1
    @State private var carRotation:Float = 0
    @State private var carSelected = 0
    
    // MARK: - PROPERTIES
       
    @ObservedObject private var carsViewModel : CarsViewModel =  CarsViewModel()
       
       // MARK: - BODY
    
    var body: some View {
        
        
        RealityView { content in

            // Create a cube model
            let model = Entity()
            let mesh = MeshResource.generateText("Error Loading Model!", extrusionDepth: 0.03, font: .systemFont(ofSize: 0.05), containerFrame: .zero, alignment: .center, lineBreakMode: .byCharWrapping)
            let material = SimpleMaterial(color: .lightGray, roughness: 0.15, isMetallic: true)
            model.components.set(ModelComponent(mesh: mesh, materials: [material]))
            model.position = [0, 0.05, 0]
       
            

            // Store reference to the model for later updates
            let carModel = try? Entity.load(named: carsViewModel.cars[carSelected].assetName3D)
            carModel?.scale = SIMD3(0.1, 0.1, 0.1)
            
            // Create horizontal plane anchor for the content
            let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
            anchor.addChild(carModel ?? model)
         //   anchor.addChild(model2)
         //   anchor.addChild(model3)

            // Add the horizontal plane anchor to the scene
            content.add(anchor)

            content.camera = .spatialTracking

        }
        .edgesIgnoringSafeArea(.all)
        
        
    }
     

}

// Helper function to recursively find all entities with ModelComponent
func getAllEntitiesWithModelComponent(from entity: Entity) -> [Entity] {
    var result: [Entity] = []
    
    // Check if current entity has ModelComponent
    if entity.components.has(ModelComponent.self) {
        result.append(entity)
    }
    
    // Recursively check all children
    for child in entity.children {
        result.append(contentsOf: getAllEntitiesWithModelComponent(from: child))
    }
    
    return result
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

#Preview {
    ContentView()
}
