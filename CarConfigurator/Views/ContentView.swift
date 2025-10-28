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
    
   
   
    @State private var carSelected = 0
    @State private var currentAnchor: AnchorEntity?
    @State private var currentCarEntity: Entity?
    
    // Gesture state variables
    @State private var initialScale: SIMD3<Float> = SIMD3(0.1, 0.1, 0.1)
    @State private var currentRotation: Float = 0
    
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
                // Update the model when carSelected changes
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
            .gesture(
                SimultaneousGesture(
                    // Drag gesture for moving
                    DragGesture()
                        .onChanged { value in
                            guard let carEntity = currentCarEntity else { return }
                            
                            let translation = value.translation
                            let scaleFactor: Float = 0.00005 // Reduced for more precise control
                            
                            carEntity.position.x += Float(translation.width) * scaleFactor
                            carEntity.position.z += Float(translation.height) * scaleFactor
                        },
                    
                    SimultaneousGesture(
                        // Rotation gesture
                        RotationGesture()
                            .onChanged { value in
                                guard let carEntity = currentCarEntity else { return }
                                
                                let totalRotation = currentRotation + Float(value.radians)
                                let rotationY = simd_quatf(angle: totalRotation, axis: SIMD3<Float>(0, 1, 0))
                                carEntity.orientation = rotationY
                            }
                            .onEnded { value in
                                currentRotation += Float(value.radians)
                            },
                        
                        // Scale gesture
                        MagnificationGesture()
                            .onChanged { value in
                                guard let carEntity = currentCarEntity else { return }
                                
                                let clampedValue = max(0.5, min(3.0, Float(value))) // Limit scaling range
                                let newScale = initialScale * clampedValue
                                carEntity.scale = newScale
                            }
                            .onEnded { value in
                                let clampedValue = max(0.5, min(3.0, Float(value)))
                                initialScale = initialScale * clampedValue
                            }
                    )
                )
            )
            .edgesIgnoringSafeArea(.all)
            
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
                    
                    
                    Spacer()
                    
                    // Reset button to restore original position, rotation, and scale
                    Button(action: {
                        resetCarTransform()
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.largeTitle)
                            .glassEffect()
                    }
                    .padding(15)
                    .buttonStyle(PlainButtonStyle())
                    
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
            let baseScale: SIMD3<Float>
            if carSelected == 3 {
                baseScale = SIMD3(0.002, 0.002, 0.002)
            } else {
                baseScale = SIMD3(0.1, 0.1, 0.1)
            }
            
            loadedModel.scale = baseScale
            initialScale = baseScale
            currentRotation = 0 // Reset rotation when loading new model
            
            anchor.addChild(loadedModel)
            currentCarEntity = loadedModel // Store reference for gesture handling
            print("Loaded car model: \(carsViewModel.cars[carSelected].name)")
        } catch {
            // If loading fails, use the fallback model
            let fallbackScale = SIMD3<Float>(1.0, 1.0, 1.0)
            fallbackModel.scale = fallbackScale
            initialScale = fallbackScale
            currentRotation = 0
            
            anchor.addChild(fallbackModel)
            currentCarEntity = fallbackModel // Store reference for gesture handling
            print("Failed to load car model: \(error)")
        }
    }
    
    @MainActor
    private func resetCarTransform() {
        guard let carEntity = currentCarEntity else { return }
        
        // Reset position to origin
        carEntity.position = SIMD3<Float>(0, 0.05, 0)
        
        // Reset rotation
        carEntity.orientation = simd_quatf(angle: 0, axis: SIMD3<Float>(0, 1, 0))
        currentRotation = 0
        
        // Reset scale to initial scale
        let baseScale: SIMD3<Float>
        if carSelected == 3 {
            baseScale = SIMD3(0.002, 0.002, 0.002)
        } else {
            baseScale = SIMD3(0.1, 0.1, 0.1)
        }
        
        carEntity.scale = baseScale
        initialScale = baseScale
        
        print("Reset car transform")
    }

}



#Preview {
    ContentView()
}
