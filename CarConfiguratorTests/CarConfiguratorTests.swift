//
//  CarConfiguratorTests.swift
//  CarConfiguratorTests
//
//  Created by Angel Docampo on 25/10/25.
//

import Testing
import Foundation
@testable import CarConfigurator

@Suite("Car Configurator Tests")
struct CarConfiguratorTests {
    
    // MARK: - Car Model Tests
    
    @Suite("Car Model Tests")
    struct CarModelTests {
        
        @Test("Car model initialization")
        func testCarInitialization() {
            let car = Car(
                id: 1,
                name: "Test Car",
                assetName3D: "test_asset",
                description: "Test description"
            )
            
            #expect(car.id == 1)
            #expect(car.name == "Test Car")
            #expect(car.assetName3D == "test_asset")
            #expect(car.description == "Test description")
        }
        
        @Test("Car model equality")
        func testCarEquality() {
            let car1 = Car(id: 1, name: "Mercedes A45", assetName3D: "asset1", description: "Description 1")
            let car2 = Car(id: 1, name: "Mercedes A45", assetName3D: "asset1", description: "Description 1")
            let car3 = Car(id: 2, name: "Mercedes S-Class", assetName3D: "asset2", description: "Description 2")
            
            #expect(car1 == car2, "Cars with same properties should be equal")
            #expect(car1 != car3, "Cars with different properties should not be equal")
        }
        
        @Test("Car placeholder validation")
        func testCarPlaceholder() {
            #expect(carPlaceHolder.id == 1)
            #expect(carPlaceHolder.name == "Mercedes-AMG A45")
            #expect(carPlaceHolder.assetName3D == "2020_Mercedes-Benz_A45_S_AMG_4Matic")
            #expect(!carPlaceHolder.description.isEmpty, "Placeholder description should not be empty")
        }
    }
    
    // MARK: - CarsViewModel Tests
    
    @Suite("Cars ViewModel Tests")
    struct CarsViewModelTests {
        
        @Test("ViewModel initialization")
        func testViewModelInitialization() {
            let viewModel = CarsViewModel()
            
            #expect(viewModel.cars.count == 4, "ViewModel should initialize with 4 cars")
            #expect(!viewModel.cars.isEmpty, "Cars array should not be empty")
        }
        
        @Test("Car data integrity")
        func testCarDataIntegrity() {
            let viewModel = CarsViewModel()
            
            // Test that all cars have required properties
            for car in viewModel.cars {
                #expect(car.id > 0, "Car ID should be positive")
                #expect(!car.name.isEmpty, "Car name should not be empty")
                #expect(!car.assetName3D.isEmpty, "Asset name should not be empty")
                #expect(!car.description.isEmpty, "Description should not be empty")
            }
        }
        
        @Test("Specific car models validation")
        func testSpecificCarModels() {
            let viewModel = CarsViewModel()
            
            // Test first car (Mercedes-AMG A45)
            let firstCar = viewModel.cars[0]
            #expect(firstCar.id == 1)
            #expect(firstCar.name == "2020 Mercedes-AMG A45")
            #expect(firstCar.assetName3D == "2020_Mercedes-Benz_A45_S_AMG_4Matic")
            
            // Test last car (Mercedes-AMG GT 63S)
            let lastCar = viewModel.cars[3]
            #expect(lastCar.id == 4)
            #expect(lastCar.name == "2025 Mercedes-AMG gt 4 door 63s")
            #expect(lastCar.assetName3D == "Mercedes_Gt63_Amg")
        }
        
        @Test("Car IDs are unique")
        func testUniqueCarIDs() {
            let viewModel = CarsViewModel()
            let carIDs = viewModel.cars.map { $0.id }
            let uniqueIDs = Set(carIDs)
            
            #expect(carIDs.count == uniqueIDs.count, "All car IDs should be unique")
        }
        
        @Test("Car names are unique")
        func testUniqueCarNames() {
            let viewModel = CarsViewModel()
            let carNames = viewModel.cars.map { $0.name }
            let uniqueNames = Set(carNames)
            
            #expect(carNames.count == uniqueNames.count, "All car names should be unique")
        }
        
        @Test("Asset names are unique")
        func testUniqueAssetNames() {
            let viewModel = CarsViewModel()
            let assetNames = viewModel.cars.map { $0.assetName3D }
            let uniqueAssets = Set(assetNames)
            
            #expect(assetNames.count == uniqueAssets.count, "All asset names should be unique")
        }
    }
    
    // MARK: - Data Validation Tests
    
    @Suite("Data Validation Tests")
    struct DataValidationTests {
        
        @Test("Mercedes brand consistency")
        func testMercedesBrandConsistency() {
            let viewModel = CarsViewModel()
            
            for car in viewModel.cars {
                #expect(car.name.contains("Mercedes"), "All cars should be Mercedes models")
            }
        }
        
        @Test("Asset naming convention")
        func testAssetNamingConvention() {
            let viewModel = CarsViewModel()
            
            for car in viewModel.cars {
                // Asset names should not contain spaces (typical 3D asset naming)
                #expect(!car.assetName3D.contains(" "), "Asset names should not contain spaces")
                
                // Asset names should have reasonable length
                #expect(car.assetName3D.count > 5, "Asset names should be descriptive")
                #expect(car.assetName3D.count < 100, "Asset names should not be excessively long")
            }
        }
        
        @Test("Description quality")
        func testDescriptionQuality() {
            let viewModel = CarsViewModel()
            
            for car in viewModel.cars {
                // Descriptions should be substantial
                #expect(car.description.count > 50, "Descriptions should be informative")
                
                // Descriptions should contain car-related keywords
                let description = car.description.lowercased()
                let hasCarKeywords = description.contains("mercedes") || 
                                   description.contains("engine") || 
                                   description.contains("performance") ||
                                   description.contains("luxury")
                
                #expect(hasCarKeywords, "Description should contain relevant car information")
            }
        }
    }
    
    // MARK: - Edge Cases and Error Handling
    
    @Suite("Edge Cases Tests")
    struct EdgeCasesTests {
        
        @Test("Car array bounds")
        func testCarArrayBounds() {
            let viewModel = CarsViewModel()
            
            // Test valid indices
            #expect(viewModel.cars.indices.contains(0), "Index 0 should be valid")
            #expect(viewModel.cars.indices.contains(3), "Index 3 should be valid")
            
            // Test bounds
            #expect(!viewModel.cars.indices.contains(-1), "Negative index should be invalid")
            #expect(!viewModel.cars.indices.contains(4), "Index 4 should be invalid (only 4 cars)")
        }
        
        @Test("Car model codable compliance")
        @MainActor func testCarCodableCompliance() throws {
            let originalCar = Car(
                id: 99,
                name: "Test Car",
                assetName3D: "test_asset",
                description: "Test description"
            )
            
            // Test encoding
            let encoder = JSONEncoder()
            let data = try encoder.encode(originalCar)
            #expect(!data.isEmpty, "Encoded data should not be empty")
            
            // Test decoding
            let decoder = JSONDecoder()
            let decodedCar = try decoder.decode(Car.self, from: data)
            
            #expect(decodedCar == originalCar, "Decoded car should equal original")
        }
    }
    
    
    
    
}
