# CarConfigurator

An augmented reality (AR) app for iOS that allows users to visualize and configure 3D car models in their real-world environment using ARKit and RealityKit.

## Features

- **AR Car Visualization**: Place realistic 3D car models in your physical space using your device's camera
- **Multiple Car Models**: Browse and select from different car models with unique 3D assets
- **Interactive UI**: Clean, glass-effect interface with easy-to-use controls
- **Car Selection**: Choose from various car models with detailed descriptions
- **Configuration Panel**: Access settings and configurations for the AR experience
- **Spatial Tracking**: Advanced camera tracking for stable AR placement on horizontal surfaces

## Technology Stack

- **SwiftUI**: Modern declarative UI framework
- **RealityKit**: 3D rendering and AR capabilities
- **ARKit**: Augmented reality tracking and scene understanding
- **MVVM Architecture**: Clean separation of concerns with view models

## Requirements

- iOS 17.0+
- Device with ARKit support (iPhone 6s/iPad Pro or newer)
- Xcode 15.0+

## Key Components

### Models
- `Car`: Represents a car with ID, name, 3D asset, and description
- `CarParameters`: Contains positioning and scaling parameters for AR placement

### Views
- `ContentView`: Main AR view with RealityView integration
- `CarSelectorView`: Modal sheet for selecting different car models
- `ConfigView`: Configuration panel for app settings

### Features
- Automatic fallback handling if 3D models fail to load
- Dynamic scaling for different car model dimensions
- Horizontal plane detection for realistic AR placement
- Glass effect UI elements for modern iOS design

## Usage

1. Launch the app and grant camera permissions
2. Point your device at a flat surface (table, floor, etc.)
3. Tap the car icon to browse and select different car models
4. Tap the gear icon to access configuration options
5. Move around to view the car model from different angles

## Project Structure

```
CarConfigurator/
├── CarConfiguratorApp.swift    # Main app entry point
├── ContentView.swift           # Primary AR view
├── Model.swift                 # Data models
├── CarSelectorView.swift       # Car selection interface
├── ConfigView.swift           # Configuration panel
└── Assets/                    # 3D car models and resources
```

## Development

This app demonstrates modern iOS development practices including:
- SwiftUI with RealityKit integration
- Async/await for model loading
- MVVM architectural pattern
- Sheet presentations with custom detents
- Error handling with fallback content

## Author

Created by Angel Docampo

---

*This app showcases the power of ARKit and RealityKit for creating immersive automotive visualization experiences.*