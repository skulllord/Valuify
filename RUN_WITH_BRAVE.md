# 🦁 Running Valuify with Brave Browser

## Quick Start

After completing Firebase setup, run these commands:

```powershell
cd D:\Valuify

# Clean and get dependencies
flutter clean
flutter pub get

# Run on web server (works with any browser)
flutter run -d web-server --web-port=8080
```

Then open **Brave browser** and navigate to:
```
http://localhost:8080
```

## Alternative Methods

### Method 1: Web Server (Recommended for Brave)
```powershell
flutter run -d web-server --web-port=8080
```
- Opens on localhost:8080
- Works with ANY browser (Brave, Chrome, Firefox, Edge, etc.)
- You manually open Brave and go to the URL

### Method 2: Build and Serve
```powershell
# Build the web app
flutter build web

# Serve it (requires Python or any web server)
cd build/web
python -m http.server 8080
```
Then open Brave: `http://localhost:8080`

### Method 3: Use Chrome (Flutter will auto-open)
```powershell
flutter run -d chrome
```
- Flutter automatically opens Chrome
- You can copy the URL and paste in Brave

## Full Command Sequence

```powershell
# Navigate to project
cd D:\Valuify

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Run on web server
flutter run -d web-server --web-port=8080

# Open Brave and go to: http://localhost:8080
```

## What You'll See

1. **Terminal Output:**
   ```
   Launching lib\main.dart on Web Server in debug mode...
   Building application for the web...
   
   ✓ Built build\web
   Serving web on http://localhost:8080
   ```

2. **In Brave Browser:**
   - Open Brave
   - Type: `localhost:8080` in address bar
   - Press Enter
   - Valuify app loads!

## Hot Reload

While the app is running:
- Press `r` in terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

## Troubleshooting

### Port Already in Use
If port 8080 is busy, use a different port:
```powershell
flutter run -d web-server --web-port=8081
```
Then open: `http://localhost:8081`

### "No devices found"
This is normal! Just use web-server mode:
```powershell
flutter run -d web-server
```

### Brave Shows Blank Page
1. Check terminal for errors
2. Try hard refresh: `Ctrl + Shift + R`
3. Clear Brave cache
4. Try incognito mode

### Firebase Errors in Brave
Brave's shields might block Firebase. If you see errors:
1. Click the Brave shield icon (top right)
2. Turn shields OFF for localhost
3. Refresh the page

## Development Tips

### Enable Brave DevTools
1. Press `F12` in Brave
2. Check Console for errors
3. Use Network tab to see Firebase requests

### Test Responsive Design
1. Press `F12` in Brave
2. Click device toolbar icon (or `Ctrl + Shift + M`)
3. Test different screen sizes

## Production Build

When ready to deploy:

```powershell
# Build optimized web app
flutter build web --release

# Output will be in: build/web/
# Upload these files to your web hosting
```

## Summary

**For Brave Browser, use:**
```powershell
flutter run -d web-server --web-port=8080
```

**Then open Brave and go to:**
```
http://localhost:8080
```

That's it! 🎉

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `flutter run -d web-server` | Run on localhost (any browser) |
| `flutter run -d chrome` | Run on Chrome (auto-opens) |
| `flutter build web` | Build production web app |
| `r` | Hot reload |
| `R` | Hot restart |
| `q` | Quit |

---

**Ready to run?** Complete Firebase setup first, then use the commands above! 🚀
