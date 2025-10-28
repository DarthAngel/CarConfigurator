//
//  ContentView.swift
//  CarConfigurator
//
//  Created by Angel Docampo on 10/10/25.
//

import SwiftUI
import RealityKit



struct ContentView : View {

    // MARK: - PROPERTIES
    
    @State private var carParameters: CarParameters = CarParameters()
   
    @State private var carSelected = 0
    @State private var currentAnchor: AnchorEntity?
    
    @State private var showCarSelector: Bool = false
    @State private var showConfig: Bool = false
       
    @ObservedObject private var carsViewModel : CarsViewModel =  CarsViewModel()
    
    
    
    // MARK: - BODY
    
    var body: some View {
        
        
        ZStack {
        
        // MARK: - AR VIEW
            
            RealityView { content in
                
                // Create a fallback model
                let fallbackModel = Entity()
                let mesh = MeshResource.generateText("Error Loading Model!", extrusionDepth: 0.03, font: .systemFont(ofSize: 0.05), containerFrame: .zero, alignment: .center, lineBreakMode: .byCharWrapping)
                let material = SimpleMaterial(color: .lightGray, roughness: 0.15, isMetallic: true)
                fallbackModel.components.set(ModelComponent(mesh: mesh, materials: [material]))
                fallbackModel.position = [0, 0.05, 0]
                
                // Create horizontal plane anchor for the content
                let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
                currentAnchor = anchor
                
                // Load the initial car model asynchronously
                await loadCarModel(anchor: anchor, fallbackModel: fallbackModel)
                
                // Add the horizontal plane anchor to the scene
                content.add(anchor)
                
                content.camera = .spatialTracking
                
            } update: { content in
                // Update the model when carSelected or carParameters changes
                guard let anchor = currentAnchor else { return }
                
                // Create a new fallback model for updates
                let fallbackModel = Entity()
                let mesh = MeshResource.generateText("Error Loading Model!", extrusionDepth: 0.03, font: .systemFont(ofSize: 0.05), containerFrame: .zero, alignment: .center, lineBreakMode: .byCharWrapping)
                let material = SimpleMaterial(color: .lightGray, roughness: 0.15, isMetallic: true)
                fallbackModel.components.set(ModelComponent(mesh: mesh, materials: [material]))
                fallbackModel.position = [0, 0.05, 0]
                
                // Remove existing children and load new model
                anchor.children.removeAll()
                
                Task {
                    await loadCarModel(anchor: anchor, fallbackModel: fallbackModel)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .id("\(carSelected)-\(carParameters.carScale)-\(carParameters.carRotation)")
            
        // MARK: - LABEL BUTTONS LAYER
            
            VStack {
                
                Text(carsViewModel.cars[carSelected].name)
                    .font(.subheadline)
                    .padding(20)
                    .glassEffect()
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        showCarSelector.toggle()
                    }) {
                        Image(systemName: "car")
                            .font(.largeTitle)
                            .glassEffect()
                            
                    }
                    .padding(15)
                    .buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: $showCarSelector, content: {
                        CarSelectorView(carSelected: $carSelected, cars: $carsViewModel.cars)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                            
                    })
                    
                    
                    Spacer(minLength: 2)
                    
                    
                    
                 
                    Button(action: {
                        showConfig.toggle()
                    }) {
                        Image(systemName: "gearshape")
                            .font(.largeTitle)
                            .glassEffect()
                            
                    }
                    .padding(15)
                    .buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: $showConfig, content: {
                        ConfigView(carParameters: $carParameters)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                            
                    })
                    
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 5)
            }
        }
        
        
    }
    
    // MARK: - HELPER FUNCTIONS
    
    @MainActor
    private func loadCarModel(anchor: AnchorEntity, fallbackModel: Entity) async {
        do {
            let loadedModel = try await Entity(named: carsViewModel.cars[carSelected].assetName3D)
            
            // AMG GT 63 has different dimensions
            if carSelected == 3 {
                loadedModel.scale = SIMD3(carParameters.carScale/50, carParameters.carScale/50, carParameters.carScale/50)
            } else {
                loadedModel.scale = SIMD3(carParameters.carScale, carParameters.carScale, carParameters.carScale)
            }
            loadedModel.transform.rotation = simd_quatf(angle: carParameters.carRotation / 2, axis: SIMD3(0, 1, 0))
            anchor.addChild(loadedModel)
            print("Loaded car model: \(carsViewModel.cars[carSelected].name)")
        } catch {
            // If loading fails, use the fallback model
            anchor.addChild(fallbackModel)
            print("Failed to load car model: \(error)")
        }
    }

}



#Preview {
    ContentView()
}
