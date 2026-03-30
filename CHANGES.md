# Changes: Adding 3 Stateful Widgets

## Overview
Added 3 new **StatefulWidget** classes to meet the assignment requirement of 4 Stateful + 6 Stateless widgets (10 total). The app previously had 1 Stateful widget (`HomePage`) and 1 Stateless widget (`MyApp`).

## New Widgets

### 1. `FavoriteButton` — `lib/widgets/favorite_button.dart`
- **Type:** StatefulWidget
- **State variable:** `bool isFavorited` — tracks whether the item is favorited
- **Behavior:** Tapping the heart icon toggles between an outlined heart (unfavorited) and a filled red heart (favorited) using `setState`
- **Placement:** Replaces the old `button.svg` GestureDetector in each popular diet card row
- **Concepts demonstrated:** `setState`, `GestureDetector`, `Icon` with conditional rendering

### 2. `DarkModeSwitch` — `lib/widgets/dark_mode_switch.dart`
- **Type:** StatefulWidget
- **State variable:** `bool isDarkMode` — tracks the toggle state
- **Behavior:** A row containing a sun/moon icon and a `Switch` widget. Toggling the switch flips the icon and switch color via `setState`
- **Placement:** Added to the AppBar's `actions` list, before the existing dots menu button
- **Concepts demonstrated:** `setState`, `Switch` widget, conditional icon rendering

### 3. `CalorieCounter` — `lib/widgets/calorie_counter.dart`
- **Type:** StatefulWidget
- **State variable:** `int calorieGoal` — starts at 1500, changes by ±100
- **Behavior:** Displays "Daily Calorie Goal" with a large number and +/- buttons. Pressing the buttons increments or decrements the calorie goal by 100 using `setState`
- **Placement:** New section between the search bar and the categories section in the main ListView
- **Concepts demonstrated:** `setState`, `ElevatedButton`, dynamic `Text` with string interpolation

## Files Modified
| File | Change |
|------|--------|
| `lib/widgets/favorite_button.dart` | NEW — FavoriteButton StatefulWidget |
| `lib/widgets/dark_mode_switch.dart` | NEW — DarkModeSwitch StatefulWidget |
| `lib/widgets/calorie_counter.dart` | NEW — CalorieCounter StatefulWidget |
| `lib/pages/home.dart` | Added imports for 3 new widgets; placed them in the UI |
| `CHANGES.md` | NEW — This file documenting all changes |

## Widget Count After Changes
| Type | Widgets |
|------|---------|
| **Stateful** | `HomePage`, `FavoriteButton`, `DarkModeSwitch`, `CalorieCounter`, `MyApp` (5 total) |
| **Stateless** | (more Stateless widgets to be added separately) |

---

# Changes: Dark Mode / Light Mode Implementation

## Overview
Made the `DarkModeSwitch` actually functional — toggling it now switches the entire app between a light theme and a dark theme. This required lifting theme state up to the root widget and making all UI elements theme-aware.

## How It Works

### Architecture — State Lifting Pattern
The theme state (`isDarkMode`) lives in `MyApp` (the root widget), which was converted from a **StatelessWidget** to a **StatefulWidget**. When the switch is toggled:

1. `DarkModeSwitch.onToggle` fires → calls `MyApp.toggleTheme()`
2. `MyApp.setState()` flips `isDarkMode`
3. `MaterialApp` rebuilds with a different `themeMode` (`ThemeMode.dark` or `ThemeMode.light`)
4. All descendant widgets that use `Theme.of(context)` automatically adapt

```
MyApp (holds isDarkMode state)
  └─ MaterialApp (theme + darkTheme + themeMode)
       └─ HomePage (receives isDarkMode & onThemeToggle as props)
            └─ AppBar → DarkModeSwitch (receives isDarkMode & onToggle)
            └─ Body → all sections use theme-derived colors
```

### Theme Definition (`main.dart`)
Two `ThemeData` objects are defined:

| Property | Light Theme | Dark Theme |
|----------|-------------|------------|
| `brightness` | `Brightness.light` | `Brightness.dark` |
| `scaffoldBackgroundColor` | `Colors.white` | `#1C1C1E` (iOS-style dark) |
| `appBarTheme.backgroundColor` | `Colors.white` | `#2C2C2E` |
| `appBarTheme.foregroundColor` | `Colors.black` | `Colors.white` |
| `colorScheme.primary` | `#92A3FD` (app accent) | `#92A3FD` (same accent) |
| `colorScheme.surface` | `Colors.white` | `#2C2C2E` |

### Color Adaptations in `home.dart`
All hardcoded `Colors.black` and `Colors.white` references were replaced with theme-derived variables computed at the top of `build()`:

| Variable | Light Value | Dark Value | Used For |
|----------|-------------|------------|----------|
| `textColor` | `Colors.black` | `Colors.white` | All heading/body text |
| `subTextColor` | `#7B6F72` | `#A8A8A8` | Secondary/subtitle text |
| `cardColor` | `Colors.white` | `#2C2C2E` | Popular diet card backgrounds |
| `iconBgColor` | `#F7F8F8` | `#3A3A3C` | AppBar icon container backgrounds |
| `searchFillColor` | `Colors.white` | `#2C2C2E` | Search bar fill |

Category and diet card box colors use reduced alpha in dark mode (`0.15` instead of `0.3`) so they don't look washed out.

### `DarkModeSwitch` Changes (`dark_mode_switch.dart`)
Previously held its own local `isDarkMode` state that did nothing to the app. Now:
- Accepts `isDarkMode` (bool) and `onToggle` (callback) as **constructor parameters**
- The `Switch.onChanged` calls the parent's callback instead of local `setState`
- Still a StatefulWidget (required for assignment), but state is driven by parent

### `CalorieCounter` Changes (`calorie_counter.dart`)
Now reads `Theme.of(context).brightness` to adapt text colors and container background opacity for dark mode.

### `MyApp` Changes (`main.dart`)
- Converted from `StatelessWidget` → `StatefulWidget`
- Holds `bool isDarkMode` state and `toggleTheme(bool value)` method
- Defines both `theme:` (light) and `darkTheme:` (dark) on `MaterialApp`
- Passes `themeMode:` to `MaterialApp` based on current state
- Passes `isDarkMode` and `onThemeToggle` to `HomePage`

### `HomePage` Changes (`home.dart`)
- Now accepts `isDarkMode` and `onThemeToggle` as required constructor parameters
- Passes them through to `DarkModeSwitch` in the AppBar
- All methods (`_searchField`, `_categoriesSection`, `_dietSection`, `appBar`) now accept color parameters instead of using hardcoded values
- Removed explicit `backgroundColor: Colors.white` from Scaffold (now uses theme's `scaffoldBackgroundColor`)
- Removed explicit `backgroundColor: Colors.white` from AppBar (now uses theme's `appBarTheme`)

## Files Modified
| File | Change |
|------|--------|
| `lib/main.dart` | Converted `MyApp` to StatefulWidget; added light/dark ThemeData; passes state to HomePage |
| `lib/pages/home.dart` | Accepts theme props; all colors are now theme-aware; passes state to DarkModeSwitch |
| `lib/widgets/dark_mode_switch.dart` | Accepts `isDarkMode` and `onToggle` props from parent instead of local state |
| `lib/widgets/calorie_counter.dart` | Uses `Theme.of(context)` to adapt colors for dark mode |
| `CHANGES.md` | Updated with dark mode implementation details |

## Flutter Concepts Demonstrated
- **State lifting** — moving state up to a common ancestor (`MyApp`) so multiple widgets can share it
- **Callback props** — passing `ValueChanged<bool>` down the widget tree
- **ThemeData & ThemeMode** — Flutter's built-in theming system with `theme`, `darkTheme`, and `themeMode`
- **Theme.of(context)** — reading the current theme in descendant widgets
- **ColorScheme** — using `ColorScheme.light()` and `ColorScheme.dark()` for semantic colors

## Note on MyApp Widget Type Change
`MyApp` was converted from StatelessWidget to **StatefulWidget** to hold the theme state. This means the widget counts are now:
| Type | Widgets |
|------|---------|
| **Stateful** | `MyApp`, `HomePage`, `FavoriteButton`, `DarkModeSwitch`, `CalorieCounter` (5 total) |
| **Stateless** | (to be added separately) |
