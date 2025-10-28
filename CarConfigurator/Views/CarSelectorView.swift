//
//  CarSelectorView.swift
//  CarConfigurator
//
//  Created by Angel Docampo on 27/10/25.
//

import SwiftUI

struct CarSelectorView: View {
    
        // MARK: - PROPERTIES
        
        @Binding var carSelected: Int
        @Binding var cars: [Car]
        
        // MARK: - BODY
        
        var body: some View {
            VStack {
                Picker("Select a car", selection: $carSelected) {
                    ForEach(cars.indices, id: \.self) { index in
                        Text(cars[index].name)
                            .tag(index)
                        
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 15)
                
                Spacer()
                
                Text(cars[carSelected].description)
                    .multilineTextAlignment(.leading)
                    .font(.caption)
                    .padding(25)
            }
        }
    }

    #Preview {
        CarSelectorView(carSelected: .constant(0), cars: .constant([carPlaceHolder]))
    }
