<p align="center">
 <img src="./img/logo.png" width="300"> 
</p>

---

# 🍹 Riverpod Learning Flutter – Cocktail App

**A Flutter app to explore cocktails with real-time search and category filtering.**

This **Riverpod Learning Flutter App** was created to **deepen my understanding of Riverpod** and Flutter state management.  
It allows users to browse cocktails by category or alcohol content and view detailed information about each cocktail. The app fetches data in real-time from **TheCocktailDB API**.

---

## 🍸 Key Features

- [x] **Cocktail Search** – Real-time search suggestions while typing.  
- [x] **Category Overview** – Browse all cocktail categories.  
- [x] **Detail View** – View ingredients, measurements, glass type, and instructions.  
- [x] **Alcohol Filter** – Filter cocktails by alcoholic or non-alcoholic.  
- [x] **Glassmorphic UI / Blur Effect** – Stylish blurred background behind text.  
- [x] **Error Handling** – API errors are displayed via dialogs.  
- [x] **Modern UI** – Horizontal lists, GridViews, and responsive layouts.  

---

## 📱 Screenshots

<p align="center">
 <img src="./img/cocktail_list.png" width="200"> 
 <img src="./img/cocktail_detail.png" width="200"> 
 <img src="./img/cocktail_search.png" width="200"> 
</p>

---

## 🔧 Technical Overview

- **Flutter** – Cross-platform UI for Android & iOS  
- **Riverpod** – State management and API handling  
- **TheCocktailDB API** – Real-time cocktail data source  

### 📁 Project Structure

**• Models:**  
- `Cocktail`, `Category` → Represent the data structures from the API.

**• Providers (State Management):**  
- `cocktailListProvider` → Handles loading, filtering, and searching cocktails.  
- `categoryListProvider` → Loads all cocktail categories.  
- `cocktailDetailProvider` → Provides detailed information for individual cocktails.

**• Screens / Views:**  
- `CocktailHomeScreen` → Home screen with search and categories.  
- `CocktailListScreen` → Shows cocktails by category.  
- `CocktailDetailScreen` → Detailed view with ingredients, glass type, and instructions.

**• Services:**  
- `CocktailDbApi` → API wrapper for HTTP requests to TheCocktailDB.  

---

## ☁️ API Integration

The app uses **TheCocktailDB API** to:

- Fetch cocktails by **Alcoholic** or **Non-Alcoholic** filter.  
- Explore cocktails by **Category**.  
- Load **detailed information** for a selected cocktail, including ingredients, measures, glass type, and instructions.  
- Provide **real-time search suggestions** as the user types.  

### API Endpoints Overview

| Feature | Endpoint | Example |
|---------|----------|---------|
| Fetch cocktails by alcohol type | `/filter.php?a=Alcoholic` or `/filter.php?a=Non_Alcoholic` | `https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic` |
| Fetch categories | `/list.php?c=list` | `https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list` |
| Fetch cocktails by category | `/filter.php?c=<category>` | `https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail` |
| Fetch cocktail details | `/lookup.php?i=<id>` | `https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=11007` |
| Search cocktails by name | `/search.php?s=<query>` | `https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita` |

> Note: This app was created to **practice and deepen understanding of Riverpod** in Flutter using real-world API integration.

---

## 🧪 Error Handling

- API errors are displayed as **AlertDialog** pop-ups in the UI.  
- Errors can be reset via the StateNotifier to avoid repeated dialogs.  

---

## 🚀 Future Enhancements

- [ ] Favorites feature for cocktails  
- [ ] Offline caching of cocktail data  
- [ ] Push notifications for new cocktails  
- [ ] Advanced filtering (e.g., by ingredients or glass type)  

---

## 🧩 Packages & Frameworks

| Technology | Description |
|-------------|--------------|
| **Flutter** | UI framework for Android & iOS |
| **Riverpod** | State management solution |
| **HTTP** | Handles API requests |
| **Logger** | Debugging and error logging |
| **Skeletonizer** | Loading animations for UI elements |
| **ClipRRect & BackdropFilter** | Glassmorphic / blur effects for UI |

---

### 🏗️ Architecture Overview

| Folder / File | Description |
|----------------|--------------|
| 📂 `models/` | Data structures (Cocktail, Category) |
| 📂 `providers/` | StateNotifier logic and state management |
| 📂 `screens/` | UI screens (Home, List, Detail) |
| 📂 `services/` | API wrapper and HTTP logic |
| 📄 `main.dart` | App entry point |

---

## ❤️ Conclusion

The **Riverpod Learning Flutter App** is a practical learning project to **enhance my understanding of Riverpod and Flutter**.  
It demonstrates:

- Real-time API data fetching  
- State management with Riverpod  
- UI design using GridView, Lists, and blur effects  
- Error handling with user-friendly dialogs  

This project serves as a learning tool and a foundation for building more complex Flutter apps.
