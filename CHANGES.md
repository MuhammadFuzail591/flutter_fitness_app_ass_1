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
| **Stateful** | `HomePage`, `FavoriteButton`, `DarkModeSwitch`, `CalorieCounter` (4 total) |
| **Stateless** | `MyApp` (1 — more Stateless widgets to be added separately) |
