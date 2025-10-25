//
//  ContentView.swift
//  Hello-AR
//
//  Created by Angel Docampo on 10/10/25.
//

import SwiftUI
import RealityKit


struct ContentView : View {

    
    @State private var boxMaterial:SimpleMaterial = SimpleMaterial(color: .red, roughness: 0.15, isMetallic: true)
    @State private var mercedesModel: Entity?
    
    var body: some View {
        
        
        RealityView { content in

            // Create a cube model
            let model = Entity()
            let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
            let material = boxMaterial
            model.components.set(ModelComponent(mesh: mesh, materials: [material]))
            model.position = [0, 0.05, 0]
            
            // Store reference to the model for later updates
            
            
            let model2 = Entity()
            let mesh2 = MeshResource.generateSphere(radius: 0.1)
            let material2 = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
            model2.components.set(ModelComponent(mesh: mesh2, materials: [material2]))
            model2.position = [0, 0.4, 0]
            
            
            let model3 = Entity()
            let mesh3 = MeshResource.generateText("Hello World!", extrusionDepth: 0.03, font: .systemFont(ofSize: 0.05), containerFrame: .zero, alignment: .center, lineBreakMode: .byCharWrapping)
            let material3 = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
            model3.components.set(ModelComponent(mesh: mesh3, materials: [material3]))
            model3.position = [0, 0.25, 0]
            
            // Store reference to the model for later updates
            mercedesModel = try? Entity.load(named: "Mercedes-Benz_Maybach_2022")
            
            
            // Create horizontal plane anchor for the content
            let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
            anchor.addChild(mercedesModel ?? model)
         //   anchor.addChild(model2)
         //   anchor.addChild(model3)

            // Add the horizontal plane anchor to the scene
            content.add(anchor)

            content.camera = .spatialTracking

        }
        .edgesIgnoringSafeArea(.all)
        .onTapGesture { tapGesture in
            // Update the stored material
            boxMaterial = SimpleMaterial(color: .random, roughness: 0.15, isMetallic: true)
            
            // Update the model's material directly
            if let model = mercedesModel {
                let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
                model.components.set(ModelComponent(mesh: mesh, materials: [boxMaterial]))
            }
            
            print("Tap detected!")
        }
        
        
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
