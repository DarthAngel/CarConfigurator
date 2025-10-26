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
    
    @State private var carX:Float = 0
    @State private var carY:Float = 0
    @State private var carZ:Float = 0
    @State private var carScale:Float = 1
    @State private var carRotation:Float = 0
    @State private var carSelected = 0
    
    @State private var showCarSelector: Bool = false
    @State private var showConfig: Bool = false
       
    @ObservedObject private var carsViewModel : CarsViewModel =  CarsViewModel()
       
    
    // MARK: - BODY
    
    var body: some View {
        
        
        ZStack {
            
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
                        Image(systemName: "car.circle")
                            .font(.largeTitle)
                            .glassEffect()
                    }
                    /*.sheet(isPresented: $showDateTimeView, content: {
                        SetDateTimeView()
                    })*/
                    
                    
                    Spacer(minLength: 2)
                    
                    
                    
                 
                    Button(action: {
                        showConfig.toggle()
                    }) {
                        Image(systemName: "gearshape.circle")
                            .font(.largeTitle)
                            .glassEffect()
                    }
                    /*
                    .sheet(isPresented: $showHelpView, content: {
                        SupportView()
                    }) */
                    
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 5)
            }
        }
        
        
    }
     

}



#Preview {
    ContentView()
}
