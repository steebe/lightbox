# Architecture Guide

This document explains the code structure and design patterns used in the Light Table app.

## Overview

The app follows **MVVM (Model-View-ViewModel)** architecture with SwiftUI best practices for separation of concerns, testability, and maintainability.

## Project Structure

```
light-table/
├── ViewModels/          # Business logic and state management
│   └── LightTableViewModel.swift
├── Views/               # Main screen views
│   ├── LandingView.swift
│   └── LightTableView.swift
├── Components/          # Reusable UI components
│   ├── GridOverlay.swift
│   └── ControlsPanel.swift
├── ContentView.swift    # Main coordinator view
└── light_tableApp.swift # App entry point
```

## Architecture Pattern: MVVM

### What is MVVM?

- **Model**: Data and business logic (in this app, state is managed in ViewModel)
- **View**: UI presentation (SwiftUI views)
- **ViewModel**: Mediator between Model and View, manages state

### Benefits

✅ **Separation of Concerns** - Each component has a single responsibility
✅ **Testability** - ViewModels can be unit tested without UI
✅ **Reusability** - Components can be easily reused
✅ **Maintainability** - Easy to find and modify specific functionality

## Component Breakdown

### 1. ContentView (Coordinator)

**Purpose**: Top-level view that coordinates navigation between screens

**Responsibility**:
- Owns the `LightTableViewModel` using `@StateObject`
- Switches between `LandingView` and `LightTableView`
- Handles animations and color scheme changes

**Key Pattern**: Uses `@StateObject` for view ownership of ViewModel

```swift
@StateObject private var viewModel = LightTableViewModel()
```

### 2. LightTableViewModel (State Management)

**Purpose**: Centralized state management and business logic

**Responsibility**:
- Manages all app state with `@Published` properties
- Provides computed properties for formatted values
- Exposes action methods (activateLightTable, toggleGrid, etc.)
- Defines constants for min/max values

**Key Patterns**:
- `ObservableObject` - Makes the class observable by SwiftUI
- `@Published` - Triggers view updates when properties change
- Computed properties - Encapsulates formatting logic
- Methods for actions - Better than direct property manipulation

**Why use ViewModel?**
- Keeps views simple and focused on presentation
- Easy to test business logic without UI
- Reusable across multiple views
- Single source of truth for state

### 3. Views (Presentation Layer)

#### LandingView
- **Purpose**: Welcome screen with activation button
- **Receives**: `onActivate` closure
- **Pattern**: Stateless, uses closure for actions

#### LightTableView
- **Purpose**: Main light table screen with controls
- **Receives**: `@ObservedObject viewModel`
- **Pattern**: Observes ViewModel for state changes

**Key Pattern**: Views use `@ObservedObject` to subscribe to ViewModel

```swift
@ObservedObject var viewModel: LightTableViewModel
```

### 4. Components (Reusable UI)

#### ControlsPanel
- **Purpose**: Settings panel (brightness, grid controls)
- **Receives**: `@ObservedObject viewModel`
- **Pattern**: Two-way binding with `$viewModel.property`

#### GridOverlay
- **Purpose**: Draws alignment grid
- **Receives**: `spacing` value
- **Pattern**: Stateless, pure rendering component

## SwiftUI Best Practices Used

### 1. **MARK Comments**
Organize code with section markers:
```swift
// MARK: - Properties
// MARK: - Body
// MARK: - Subviews
```

### 2. **Computed Properties for Subviews**
Break down complex views into smaller pieces:
```swift
var body: some View {
    VStack {
        header
        brightnessControl
        gridControls
    }
}

private var header: some View { ... }
```

### 3. **@ViewBuilder for Conditional Views**
Use when conditionally rendering views:
```swift
@ViewBuilder
private var gridOverlay: some View {
    if viewModel.showGrid {
        GridOverlay(spacing: viewModel.gridSpacing)
    }
}
```

### 4. **Property Wrappers**
- `@StateObject` - View owns the object (create once)
- `@ObservedObject` - View observes object owned elsewhere
- `@Published` - Property triggers view updates when changed
- `@State` - View-local state (private to view)

### 5. **Separation of State and Presentation**
- State lives in ViewModel
- Views are "dumb" - they just display data and call methods

### 6. **Preview Providers**
Every view has a preview for quick iteration:
```swift
#Preview {
    ContentView()
}
```

## How State Flows

1. **User interacts** with a view (taps button, moves slider)
2. **View calls** ViewModel method or updates @Published property
3. **ViewModel** updates its @Published state
4. **SwiftUI** automatically re-renders any views observing that state
5. **Views** display the new state

Example:
```
User taps "Activate" button
    → LandingView calls onActivate closure
        → ContentView's closure calls viewModel.activateLightTable()
            → ViewModel sets isLightActive = true
                → ContentView observes change and re-renders
                    → Shows LightTableView instead of LandingView
```

## Adding New Features

### To add a new control:

1. **Add state to ViewModel**:
   ```swift
   @Published var newFeature: Bool = false
   ```

2. **Add method to ViewModel**:
   ```swift
   func toggleNewFeature() {
       newFeature.toggle()
   }
   ```

3. **Create UI in appropriate View/Component**:
   ```swift
   Toggle("New Feature", isOn: $viewModel.newFeature)
   ```

### To add a new screen:

1. Create new View file in `Views/`
2. Pass ViewModel as `@ObservedObject`
3. Add navigation logic in ContentView

## Testing Strategy

### ViewModel Tests (Unit Tests)
- Test state changes
- Test computed properties
- Test action methods
- No UI dependencies

### View Tests (UI Tests)
- Test user interactions
- Test navigation flows
- Mock ViewModel for isolation

## Key Takeaways

1. **MVVM** separates logic from presentation
2. **ViewModel** is the single source of truth
3. **Views** are lightweight and focused
4. **Components** are small and reusable
5. **State flows** unidirectionally (View → ViewModel → View)

## Further Reading

- [Apple's SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [MVVM Design Pattern](https://www.avanderlee.com/swift/mvvm-design-pattern/)
- [SwiftUI Property Wrappers](https://www.hackingwithswift.com/quick-start/swiftui/all-swiftui-property-wrappers-explained-and-compared)
