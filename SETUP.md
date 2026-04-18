# Light Table Setup Guide

## What's Been Created

Your iOS light table app is ready to build! Here's what was set up:

### Core Files

1. **light_tableApp.swift** - Main app entry point
2. **ContentView.swift** - The light table interface with:
   - Bright white background (adjustable brightness 30-100%)
   - Collapsible controls panel
   - Image loading and overlay functionality
   - Opacity controls for reference images

3. **ImagePicker.swift** - Photo library integration for selecting reference images

4. **Info.plist** - Privacy permissions for photo library access

### Features Implemented

✅ **Adjustable Brightness**: Slider to control backlight intensity
✅ **Reference Image Overlay**: Load images from photo library
✅ **Opacity Control**: Make overlay images more or less transparent
✅ **Collapsible UI**: Hide controls for maximum screen space
✅ **Clean Design**: Minimal interface with smooth animations

## Next Steps

1. **Open the project**:
   ```bash
   open light-table.xcodeproj
   ```

2. **Configure signing**:
   - Select the "light-table" target in Xcode
   - Go to "Signing & Capabilities" tab
   - Select your Apple Developer team (or use automatic signing)

3. **Run the app**:
   - Connect your iPhone/iPad, or use the iOS Simulator
   - Press ⌘R (or click the Play button)
   - The app will build and launch

## Usage Tips

- **Start simple**: Just launch the app for a bright white screen
- **Load reference**: Tap "Select Image" to add an image to trace
- **Adjust opacity**: Use the slider to make the reference more/less visible
- **Hide controls**: Tap the chevron button for full-screen mode
- **Best results**: Use in a dark room for maximum contrast when tracing

## Troubleshooting

**App won't build?**
- Make sure you have Xcode 15 or later
- Check that a development team is selected in Signing & Capabilities

**Can't select images?**
- The first time you try to select an image, iOS will ask for permission
- Make sure you allow photo library access

**Screen too bright/dim?**
- Use the brightness slider in the app
- Also adjust your device's system brightness for best results

## Customization Ideas

Want to extend the app? Here are some ideas:
- Add color picker for different backlight colors (useful for different tracing materials)
- Add pinch-to-zoom for the reference image
- Save favorite brightness/opacity presets
- Add a grid overlay option
- Support multiple reference images in a gallery

Enjoy your light table! 🎨
