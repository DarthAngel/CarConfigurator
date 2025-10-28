//
//  ConfigView.swift
//  CarConfigurator
//
//  Created by Angel Docampo on 27/10/25.
//

import SwiftUI

struct ConfigView: View {
    
    // MARK: - PROPERTIES

    @Binding var carParameters: CarParameters 
  
    // MARK: - BODY
    
    var body: some View {
        
        VStack {
            
            Text("Rotate Car")
                .font(.largeTitle)
                .padding(.top, 40)
                
            
            HStack {
                Button(action: {
                    carParameters.carRotation += .pi / 2
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.largeTitle)
                        .glassEffect()
                    
                }
                .padding(30)
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    carParameters.carRotation -= .pi / 2
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.largeTitle)
                        .glassEffect()
                    
                }
                .padding(30)
                .buttonStyle(PlainButtonStyle())
            }
            
            Spacer()
            
            Text ("Car Scale")
                .font(.largeTitle)
            
            Slider(value: $carParameters.carScale, in: 0.1...1, step: 0.1, label: {})
                .padding(.horizontal, 30)
                .buttonStyle(PlainButtonStyle())
            Text("\(carParameters.carScale * 100, specifier: "%.0f")%")
        }.padding(.bottom, 20)
        
    }
}

#Preview {
    ConfigView(carParameters: .constant(CarParameters()))
}
