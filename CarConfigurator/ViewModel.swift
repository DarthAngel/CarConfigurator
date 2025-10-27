//
//  ViewModel.swift
//  CarConfigurator
//
//  Created by Angel Docampo on 24/10/25.
//

import Foundation
import Combine


class CarsViewModel: ObservableObject {
    
    @Published var cars = [Car]()
    
    
    init() {
        // For this example, we manually initialize the car array. In a production environment, we would obtain the cars through an API by connecting to a server.
        
        
        let car1 = Car(id: 1, name: "Mercedes-AMG A45", assetName3D: "2020_Mercedes-Benz_A45_S_AMG_4Matic", description: """
  The Mercedes-AMG A45 is a high-performance "hot hatch" known for its powerful turbocharged engine, all-wheel drive, and sporty design. It combines a luxurious interior with aggressive performance, offering a dynamic driving experience that can be comfortable for daily use or thrilling for performance driving. The A45S is a higher-performance version that features even more power, sharper handling, and additional upgrades like drift mode.
  """)
        
        let car2 = Car(id: 2, name: "Mercedes-Benz S-Class Maybach", assetName3D: "2021_Mercedes-Benz_S-Class_Maybach", description: """
            The 2021 Mercedes-Benz S-Class Maybach is an ultra-luxury sedan with a focus on rear-seat comfort and performance, featuring models like the S 580 with a 4.0L V8 engine and the upcoming S 680 with a V12. It comes standard with features such as Executive rear seats, five screens including a 12.8-inch OLED central display, and has an extended wheelbase for increased rear space. Notable technology includes Active Body Control with a camera-based system to scan the road for a smoother ride, rear-axle steering, and advanced driver assistance systems
            """)
        
        let car3 = Car(id: 3, name: "Mercedes-Benz G-Class AMG G 63", assetName3D: "2025_Mercedes-Benz_G-Class_AMG_G_63", description: """
            The Mercedes-AMG G 63: Visually a power, motorised an elemental force. Off-road brilliance meets breathtaking on-road performance - and the throaty roar of the 4.0-litre V8 biturbo engine turns every drive into pure bliss.
            """)
        
        let car4 = Car(id: 4, name: "Mercedes-AMG gt 4 door 63s", assetName3D: "Mercedes_Gt63_Amg", description: """
            Developments from Formula 1 and Affalterbach: the Mercedes-AMG GT 63 S E PERFORMANCE has a 4.0-litre V8 biturbo engine combined with a permanently revved synchronous electric motor and a high-performance battery. The electric motor delivers its power directly to the rear axle – without delay and without being limited by the combustion engine’s transmission. As is typical for this type of vehicle, the electric motor delivers full torque for pure power release from zero seconds. And for longitudinal dynamics that are second to none.
            """)
        
        self.cars = [car1, car2, car3, car4]
        
        
                       
                       
        
        
    }
}
