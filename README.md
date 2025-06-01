
# Torbaaz Menu Flutter App

## Table of Contents

1. [Project Overview](#project-overview)  
2. [Key Features](#key-features)  
3. [Screenshots / UI Gallery](#screenshots--ui-gallery)  
   - [Main Menu Screen](#main-menu-screen)  
   - [Food Deals Screen](#food-deals-screen)  
   - [Restaurant Details Screen](#restaurant-details-screen)  
   - [eTables (List of Items) Screen](#etables-list-of-items-screen)  
   - [Feedback Screen](#feedback-screen)  
   - [Jarvis AI Assistant Screen](#jarvis-ai-assistant-screen)  
   - [About Screen](#about-screen)  
4. [Technology Stack](#technology-stack)  
5. [Prerequisites](#prerequisites)  
6. [Getting Started](#getting-started)  
   - [Cloning the Repository](#cloning-the-repository)  
   - [Installing Dependencies](#installing-dependencies)  
   - [Environment Configuration](#environment-configuration)  
   - [Launching the App](#launching-the-app)  
7. [Folder Structure](#folder-structure)  
8. [AI Assistant (Jarvis) Details](#ai-assistant-jarvis-details)  
9. [Usage Guide](#usage-guide)  
10. [Contributing](#contributing)  
11. [Future Improvements](#future-improvements)  
12. [License](#license)  
13. [Contact](#contact)  

---

## Project Overview

**Torbaaz Menu** is a Flutter-based mobile application that provides an intuitive, visually appealing interface for browsing and interacting with local restaurant menus. In this version, particular emphasis has been placed on integrating an AI-powered assistant—**Jarvis**—to answer users’ menu-related queries in real time.

Key highlights:

- **Cross-platform Flutter UI** that adapts seamlessly to different mobile screen sizes.  
- **Menu Browsing** with images, categories, search bar and deal highlights.  
- **Food Deals** page showcasing special offers from local restaurants.  
- **Restaurant Details** page with contact information and “View on Map” functionality.  
- **eTables** page listing items (without images) with live search filtering.  
- **Feedback** page for users to share their experiences and connect on Instagram.  
- **About** page detailing the app’s creator and contact channels.  
- **Jarvis AI Assistant** integration—powered by OpenAI’s API—to answer questions like “Which pizza options are available?” or “Show me shawarma deals.”

---

## Key Features

1. **Main Menu Display**  
   - Scrollable grid of restaurant menus (with thumbnail images, names, ratings and locations).  
   - Category tabs (e.g., “All”, “Fast Food”, “Desi Food”) for quick filtering.

2. **Food Deals**  
   - Separate tab showcasing current “Deals & Offers” from local vendors.  
   - “Order Now” buttons for each deal card (UI only; order integration can be added later).

3. **Restaurant Details**  
   - Detailed view of a selected restaurant: logo/banner, rating, description, address, contact number.  
   - “View on Map” button opens the device’s map application at the restaurant’s location.

4. **eTables (List of Items)**  
   - Simple card layout listing food items (name, restaurant, price).  
   - Live search bar at the top for filtering by keywords.  
   - “Favourite” (heart) icon for saving preferred items (UI only; persistence can be added).

5. **Feedback**  
   - Stylised feedback form encouraging users to share their experience.  
   - Prominent “Open Instagram Page” button linking to the Torbaaz Instagram profile.  
   - Visually rich, gradient-based design matching the brand.

6. **AI Assistant (Jarvis)**  
   - Floating chat widget accessible from any tab.  
   - Pre-populated welcome message and example prompts.  
   - Sends user queries to OpenAI API and displays responses conversationally.  
   - Can answer questions about food categories, restaurant details, deals & pricing, and more.

7. **About**  
   - Profile section with Torbaaz logo.  
   - Contact email link and “Follow us on Instagram” button.  
   - Brief description about the developer and purpose of the app.

---

## Screenshots / UI Gallery

Below is a visual showcase of the Torbaaz Menu Flutter App. Each screenshot highlights a core section of the application’s UI.

> **Note:** These images are stored in `assets/images/`. Make sure to add them to your `pubspec.yaml` as described in [Getting Started](#getting-started).

### Main Menu Screen

![Main Menu Screen](assets/images/screenshot_main_menu.png)  
<small>“Hello, Customer!” heading with “Menus of All Restaurants”, category tabs and scrolling menu cards.</small>

### Food Deals Screen

![Food Deals Screen](assets/images/screenshot_food_deals.png)  
<small>“Food Deals” page showing special offers from “EatWay” with “Order Now” buttons.</small>

## Screenshots / UI Gallery

Below is a visual showcase of the Torbaaz Menu Flutter App. Each screenshot highlights a core section of the application’s UI. The filenames below must match exactly as they appear in `assets/images/`.

> **Note:** Ensure that all of these PNG files are stored in `assets/images/` and declared in your `pubspec.yaml` under `flutter.assets:` (including spaces and parentheses exactly as shown).

### Main Menu Screen

![Main Menu Screen](assets/images/Screenshot (4).png)  
<small>“Hello, Customer!” heading with “Menus of All Restaurants”, category tabs, and scrolling menu cards.</small>

### Food Deals Screen

![Food Deals Screen](assets/images/Screenshot (5).png)  
<small>“Food Deals” page showing special offers from “EatWay” with “Order Now” buttons.</small>

### Restaurant Details Screen

![Restaurant Details Screen](assets/images/Screenshot (6).png)  
<small>Detailed view of “Crust Bros Jahania”: banner image, description, address, phone number, and “View on Map” button.</small>

### eTables (List of Items) Screen

![eTables List of Items Screen](assets/images/Screenshot (7).png)  
<small>“eTables” shows a searchable list of items (e.g., Burger Rs.399, Pizza Rs.649) with a heart icon to favourite.</small>

### Feedback Screen

![Feedback Screen](assets/images/Screenshot (8).png)  
<small>Vibrant feedback page prompting users to “Tell us about your experience with Torbaaz!” and “Open Instagram Page”.</small>

### Jarvis AI Assistant Screen

![Jarvis AI Assistant Screen](assets/images/Screenshot (9).png)  
<small>Jarvis welcome screen with example prompts (food categories, restaurant info, deals & prices).</small>

### About Screen

![About Screen](assets/images/Screenshot (10).png)  
<small>“About Us” section with Torbaaz logo, contact email, Instagram button, and developer description.</small>

---
## Technology Stack

- **Flutter SDK** (>= 3.0.0)  
- **Dart** (>= 2.17.0)  
- **State Management**: `provider` package for simple dependency injection and state updates  
- **HTTP Client**: `http` package for REST API calls to OpenAI  
- **Environment Variables**: `flutter_dotenv` for safely storing API keys  
- **Local Storage**: `shared_preferences` (used for persisting small UI states, e.g., favourites)  
- **UI & Fonts**: Material Design, `google_fonts` for custom typography  
- **Version Control**: Git (GitHub repository)  

---

## Prerequisites

Before running the app locally, ensure you have the following installed on your development machine:

1. **Flutter SDK**  
   - Follow the official Flutter install guide: [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)  
   - Run `flutter doctor` to confirm installation and required dependencies.

2. **Android Studio** (or your preferred IDE)  
   - Install Android SDK components and set up an Android emulator, or connect a physical device.  
   - If building for iOS, you’ll need Xcode on macOS.

3. **Dart**  
   - Bundled with Flutter; no separate installation needed.

4. **Git**  
   - Required for cloning this repository and managing version control.  
   - Download from [git-scm.com](https://git-scm.com).

---

## Getting Started

Follow these steps to clone the repository, configure environment variables, and launch the Torbaaz Menu Flutter App on your device or emulator.

### Cloning the Repository

```bash
git clone https://github.com/YourUsername/torbaaz-menu-flutter.git
cd torbaaz-menu-flutter
````

### Installing Dependencies

Retrieve and install all Flutter dependencies:

```bash
flutter pub get
```

### Environment Configuration

1. Rename `.env.example` to `.env` in the project root.

2. Open `.env` and add your OpenAI API key:

   ```env
   OPENAI_API_KEY=sk-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   ```

3. Ensure `.env` is listed in `.gitignore` to avoid committing secrets.

### Launching the App

1. **Start an Emulator or Connect a Device**

   * Android emulator:

     ```bash
     flutter emulators --launch <emulator_id>
     flutter run
     ```
   * Physical Android/iOS device:

     ```bash
     flutter devices
     flutter run
     ```

2. **Run in Debug Mode (Web Preview)**
   You can also preview on Chrome (Flutter Web) for quick UI checks:

   ```bash
   flutter run -d chrome
   ```

> The app will launch and default to the **Main Menu** screen. Navigate between bottom-navigation tabs to explore all features.

---

## Folder Structure

Below is the high-level folder structure of this Flutter project. This organisation helps separate concerns and makes the codebase easier to navigate.

```
torbaaz-menu-flutter/
├── android/                    # Android native/gradle files
├── ios/                        # iOS native/Xcode files
├── lib/                        # Main Dart source code
│   ├── main.dart               # Application entry point
│   ├── app.dart                # Defines MaterialApp, routes and theme
│   ├── models/                 # Data models (e.g., Dish, Restaurant, Feedback, ChatMessage)
│   ├── providers/              # Provider classes for state management
│   ├── services/               # API and business logic (OpenAIService, RestaurantService)
│   ├── pages/                  # All screen widgets
│   │   ├── main_screen.dart    # BottomNavigation scaffold
│   │   ├── menu_page.dart      # Menu (Home) page
│   │   ├── food_deals_page.dart# Food Deals page
│   │   ├── restaurant_page.dart# Restaurant Details page
│   │   ├── etables_page.dart   # eTables (list of items) page
│   │   ├── feedback_page.dart  # Feedback page
│   │   ├── ai_assistant_page.dart # Jarvis AI Assistant page
│   │   ├── about_page.dart     # About page
│   │   └── admin_page.dart     # Admin placeholder/page (future use)
│   ├── widgets/                # Reusable UI components (DishCard, SearchBar, ChatBubble, etc.)
│   ├── utils/                  # Utility functions and constants
│   └── theme/                  # App theme, colours and text styles
├── assets/                     # Static assets
│   ├── images/                 # UI screenshots and menu item thumbnails
│   │   ├── screenshot_main_menu.png
│   │   ├── screenshot_food_deals.png
│   │   ├── screenshot_restaurant_details.png
│   │   ├── screenshot_etables_list.png
│   │   ├── screenshot_feedback.png
│   │   ├── screenshot_ai_assistant.png
│   │   └── screenshot_about.png
│   └── fonts/                  # Custom font files for `google_fonts`
├── test/                       # Unit & widget tests (TBD)
├── pubspec.yaml                # Flutter configuration & dependencies
├── .env.example                # Example environment variables
├── .gitignore                  # Files/folders to be ignored by Git
└── README.md                   # This README file
```

---

## AI Assistant (Jarvis) Details

The **Jarvis AI Assistant** is integrated to enhance user experience by providing real-time, conversational answers to menu-related queries:

1. **Integration**

   * The `ai_assistant_page.dart` widget uses the `http` package to send user input to the OpenAI REST endpoint.
   * API key is read from environment variables via `flutter_dotenv`.

2. **Example Prompts**
   Jarvis is pre-configured with example questions that illustrate its capabilities:

   * **Food Categories**

     * “Show me all pizza options”
     * “What burgers do you have?”
     * “Tell me about shawarma deals”
     * “List all wraps”

   * **Restaurant Info**

     * “Tell me about Meet N Eat”
     * “Show Pizza Slice menu”
     * “What’s special at MFC?”
     * “Show Crust Bros contact”

   * **Deals & Prices**

     * “Family deals available”
     * “Best deals under 1000”

3. **UI Behaviour**

   * Tapping the bottom navigation’s **AI Assistant** icon opens Jarvis in a full-screen chat overlay.
   * A welcome message explains Jarvis’s functionality and example prompts.
   * Users type their own questions; messages are sent to OpenAI’s `/chat/completions` endpoint.
   * Responses appear as chat bubbles with Jarvis’s avatar/logo.

4. **Extensibility**

   * You can fine-tune Jarvis’s prompt in `services/openai_service.dart` to focus on local menu data or add more structured instructions.
   * Optionally, fetch menu metadata from a backend (e.g., Supabase) and feed it to the model as part of the system prompt for even more accurate answers.

---

## Usage Guide

1. **Navigating the Bottom Bar**

   * **Menu**: Default home screen showing a carousel of restaurants and category filters.
   * **Food Deals**: Browse current, limited-time offers; “Order Now” buttons (UI only).
   * **Restaurants**: See individual restaurants and tap to view details (address, phone number, map).
   * **eTables**: Lists all available food items in a searchable card layout.
   * **Feedback**: Share your thoughts and connect on Instagram.
   * **AI Assistant**: Tap the Jarvis Chat icon to open the chat overlay.
   * **About**: Learn about the app, developer and contact channels.

2. **Searching & Filtering**

   * Use the search bar on the **Menu** or **eTables** pages to filter restaurants or food items in real time by name, category or price range.

3. **Viewing Details**

   * Tap any restaurant card in **Menu** or **Food Deals** to open the **Restaurant Details** page.
   * On **eTables**, tap the heart icon to “favourite” an item (UI highlight only).

4. **Interacting with Jarvis**

   * From any tab, tap the **AI Assistant** icon in the bottom bar.
   * Read Jarvis’s welcome message and sample prompts.
   * Type your own question (e.g., “Which paneer dishes do you have under 600?”) and press send.
   * Jarvis will fetch a response from OpenAI’s API and display it in the chat area.
   * Scroll the conversation as needed or clear chat using the clear button (if implemented).

5. **Submitting Feedback**

   * Head to the **Feedback** page via bottom navigation.
   * Tap **Open Instagram Page** to view Torbaaz’s Instagram profile in the device’s browser or Instagram app.
   * The “Tell us about your experience” header invites users to engage; future versions may include a form for direct feedback submission.

---

## Contributing

We welcome contributions to make Torbaaz Menu Flutter App even better! If you’d like to help, please follow these steps:

1. **Fork the Repository**
   Click “Fork” on GitHub to create your own copy of this project.

2. **Create a New Branch**

   ```bash
   git checkout -b feature/YourFeatureName
   ```

3. **Make Your Changes**

   * Add UI improvements, bug fixes or new features (e.g., backend integration for orders).
   * Update `README.md` or add new documentation as needed.

4. **Test Locally**

   ```bash
   flutter pub get
   flutter run
   ```

5. **Commit & Push**

   ```bash
   git add .
   git commit -m "Add <description of feature or fix>"
   git push origin feature/YourFeatureName
   ```

6. **Open a Pull Request**
   On GitHub, open a PR comparing your branch with the `main` branch. Provide a clear description of your changes.

> Please adhere to existing code style, write clear commit messages, and ensure any new dependencies are added to `pubspec.yaml`.

---

## Future Improvements

1. **Backend Integration & Persistence**

   * Connect menu data to a cloud database (e.g., Supabase, Firebase Firestore) for dynamic updates.
   * Persist user favourites, feedback submissions and chat history.

2. **Ordering & Payments**

   * Add a shopping cart flow and integrate payment gateway (Stripe, PayPal).
   * Generate order summaries and send confirmations via email or SMS.

3. **Offline Caching**

   * Cache menu and restaurant data locally so users can browse even without an internet connection.
   * Synchronise changes when connectivity is restored.

4. **Jarvis Customisation**

   * Fine-tune Jarvis’s system prompt with local menu metadata (pull real data from the backend).
   * Add voice recognition / speech-to-text for hands-free querying.

5. **User Authentication & Profile**

   * Implement user signup/login (email/password or social login) using Firebase Auth or Supabase Auth.
   * Allow users to save preferences, order history and profile details.

6. **Automated Testing & CI/CD**

   * Write unit tests for `services/` and widget tests for key UI components.
   * Configure a GitHub Actions workflow to run tests on every PR.

7. **Enhanced Accessibility**

   * Ensure proper colour contrast, screen-reader labels and large-print support for visually impaired users.

---

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). You are free to use, modify, and distribute this code with appropriate attribution.

---

## Contact

**Developer / Maintainer**:
Anas Asghar (`@AnsAsghar`)
Email: `ansasghar777@gmail.com`
GitHub: [https://github.com/AnsAsghar](https://github.com/AnsAsghar)

Feel free to open an issue or send a pull request if you encounter any bugs, have feature suggestions, or wish to contribute improvements.

```
```
