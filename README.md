# Torbaaz
 Food delivery app
# Torbaaz Menu Flutter App

## Table of Contents
1. [Project Overview](#project-overview)  
2. [Features](#features)  
3. [Screens](#screens)  
4. [Technology Stack](#technology-stack)  
5. [Prerequisites](#prerequisites)  
6. [Getting Started](#getting-started)  
7. [Environment Configuration](#environment-configuration)  
8. [Folder Structure](#folder-structure)  
9. [Usage](#usage)  
10. [Contributing](#contributing)  
11. [Future Improvements](#future-improvements)  
12. [License](#license)  
13. [Contact](#contact)  

---

## Project Overview

**Torbaaz Menu** is a Flutter-based mobile application that displays a restaurant’s food menu in an intuitive, visually appealing interface. Originally conceived as a full-stack solution, this Flutter version focuses on the front end, showcasing:

- A scrollable menu section with images, names, sizes and prices for each dish.
- A food details page that presents additional information (ingredients, nutrition, customisations).
- An “eTables” screen listing items without images, with size and price details, plus a search bar for live filtering.
- Feedback and “About” pages for user reviews, contact details and restaurant information.
- An AI-powered assistant widget to answer menu-related queries in real time (using the OpenAI API).

This README guides you through installing, configuring and running the Flutter application on your local machine or an emulator.

---

## Features

- **Menu Display**  
  - Grid or list view of all dishes, showing thumbnail images (where available), name, size options and price.  
  - Tappable cards that navigate to detailed food information.

- **Food Details Page**  
  - Comprehensive view of each dish: ingredients, nutritional facts, optional extras and customisation options.  
  - “Add to Cart” or “Order Now” buttons (UI only; no payment integration yet).

- **eTables Page**  
  - Tabular/list layout for food items without images.  
  - Displays item name, size options and price.  
  - Search bar for real-time filtering by keyword.

- **AI Assistant Chat Widget**  
  - Floating action button opening a chat panel.  
  - Users can ask questions like “Which dishes are vegetarian?” or “How much is the Club Sandwich?”  
  - Integration with OpenAI’s REST API to fetch responses.  
  - Scrollable chat history and simple text input.

- **Feedback Page**  
  - Form allowing users to submit feedback or reviews.  
  - Input fields: Name, Email, Rating (1–5 stars), and Comments.  
  - Saves feedback locally (no backend storage yet).

- **About Page**  
  - Static information about the restaurant (address, opening hours, contact details).  
  - Styled with brand colours and icons.

- **Responsive UI**  
  - Adaptive layouts for most common mobile screen sizes (phone and small tablet).  
  - Utilises Flutter’s `MediaQuery` and flexible widgets to adjust spacing and font sizes.

---

## Screens

1. **Splash / Launch Screen**  
   - Brief loading animation or logo before navigating to the Home (Menu) screen.

2. **Menu Screen**  
   - Displays a grid or list of dish cards with images, names and prices.  
   - Search bar at the top for filtering by keyword (dish name or category).

3. **Food Details Screen**  
   - Detailed information about a selected dish (ingredients, nutrition, customisation options).

4. **eTables Screen**  
   - Lists items without images in a table-like layout (name, size, price).  
   - Search bar for live filtering.

5. **AI Assistant Chat Screen**  
   - Floating chat button on all major screens.  
   - Opens a chat overlay where users type queries and receive AI-generated responses.

6. **Feedback Screen**  
   - Form for name, email, rating and comments.  
   - Submit button to save feedback locally.

7. **About Screen**  
   - Static page with restaurant details: address, opening hours, contact email/phone.

---

## Technology Stack

- **Flutter SDK** (>= 3.0.0)  
- **Dart** (>= 2.17.0)  
- **State Management**: `provider` (or `riverpod`) for simple state handling  
- **HTTP Client**: `http` package for REST API calls to OpenAI  
- **Environment Variables**: `flutter_dotenv` for storing API keys and configuration  
- **Local Storage**: `shared_preferences` (for saving feedback locally)  
- **UI & Icons**: Flutter’s built-in Material widgets, `google_fonts` for custom fonts  
- **Version Control**: Git (GitHub repository recommended)

---

## Prerequisites

Ensure the following are installed and configured on your system:

1. **Flutter SDK**  
   - Follow the official installation guide: [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)  
   - Verify installation by running:
     ```bash
     flutter doctor
     ```

2. **Android Studio** (or a preferred IDE)  
   - Install necessary SDKs and emulators if you plan to use an Android emulator.  
   - Xcode required if you intend to build for iOS (macOS only).

3. **Dart**  
   - Bundled with Flutter; no separate installation needed.

4. **Git**  
   - To clone the repository and manage version control.  
   - Download from [git-scm.com](https://git-scm.com).

---

## Getting Started

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/YourUsername/torbaaz-menu-flutter.git
   cd torbaaz-menu-flutter
