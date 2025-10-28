# Car Configurator

An interactive augmented reality (AR) car visualization app built with SwiftUI and RealityKit for visionOS.

## Features

- **AR Car Visualization**: View 3D car models in augmented reality using plane detection
- **Interactive Gestures**: 
  - Drag to move cars in 3D space
  - Pinch to scale models up/down
  - Rotate gesture to spin cars around the Y-axis
- **Car Selection**: Choose from multiple car models through an intuitive selector interface
- **Reset Functionality**: One-tap reset to restore original position, rotation, and scale
- **Glass UI**: Modern glass effect styling throughout the interface

## Requirements

- visionOS device
- Xcode 15.0+
- Swift 5.9+

## Architecture

### Key Components

- **ContentView**: Main AR view controller with RealityView integration
- **CarsViewModel**: Observable object managing car data and state
- **CarSelectorView**: Sheet presentation for car model selection

### Technologies Used

- **SwiftUI**: Modern declarative UI framework
- **RealityKit**: 3D rendering and AR capabilities
- **Spatial Computing**: Optimized for visionOS spatial interactions

## Usage

1. Launch the app on a visionOS device
2. Allow camera permissions for AR functionality
3. Point device at a horizontal surface for plane detection
4. Use gestures to interact with the 3D car model:
   - **Drag**: Move the car around
   - **Pinch**: Scale the model size
   - **Rotate**: Spin the car
5. Tap the car icon to select different vehicle models
6. Tap the reset button to restore original positioning

## Project Structure

```
CarConfigurator/
├── ContentView.swift          # Main AR view
├── Views/
│   └── CarSelectorView.swift  # Car selection interface
├── ViewModels/
│   └── CarsViewModel.swift    # Car data management
└── Models/                    # 3D car assets
```

## Development Notes

- Models are loaded asynchronously with fallback error handling
- Special scaling considerations for different car models (e.g., AMG GT 63)
- Gesture state management prevents conflicts between simultaneous interactions
- Glass effects provide modern visionOS-appropriate styling

## Future Enhancements

- Car customization options (colors, wheels, etc.)
- Additional car models
- Environment lighting controls
- Sharing and screenshot capabilities

---

Created by Angel Docampo - October 2025