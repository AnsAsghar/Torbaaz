# 🍽️ Torbaaz - AI-Powered Smart Food Delivery App

[![Flutter](https://img.shields.io/badge/Flutter-3.32.0-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.8.0-blue.svg)](https://dart.dev/)
[![OpenAI](https://img.shields.io/badge/OpenAI-GPT--4-green.svg)](https://openai.com/)
[![Supabase](https://img.shields.io/badge/Supabase-Backend-blue.svg)](https://supabase.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Torbaaz** is a revolutionary AI-powered food delivery application built with Flutter, featuring an advanced **OpenAI GPT-4 Assistant** with thread-based conversations, comprehensive restaurant management, and intelligent food recommendations. The app seamlessly connects food lovers with premium restaurants in Jahanian, Pakistan, using cutting-edge artificial intelligence.

## 🌟 Key Features

### 🤖 **Advanced OpenAI GPT-4 Integration**
- **Thread-Based Conversations**: Maintains conversation context using OpenAI Assistant API with unique thread IDs
- **GPT-4 Powered Intelligence**: Leverages OpenAI's most advanced language model for natural food conversations
- **Persistent Chat Memory**: Each user session maintains conversation history through OpenAI threads
- **Real-time API Integration**: Direct integration with OpenAI API for instant, intelligent responses
- **Custom Food Knowledge Base**: AI assistant trained on 300+ local food items and restaurant data
- **Multi-turn Conversations**: Supports complex, contextual food discovery conversations

### 🏪 **Restaurant Management**
- **6 Premium Partner Restaurants**: Curated selection of top-rated local establishments
- **Real-time Menu Updates**: Dynamic menu management with live pricing
- **Restaurant Profiles**: Detailed information including ratings, contact details, and specialties
- **Multi-category Support**: Pizza, Burgers, BBQ, Chinese, Desserts, and more

### 📱 **User Experience**
- **Intuitive Navigation**: Clean, modern UI with bottom navigation
- **Visual Menu Display**: High-quality food images and detailed descriptions
- **Deal Discovery**: Special offers and combo deals section
- **Feedback System**: User reviews and rating system
- **Admin Dashboard**: Comprehensive content management system

### 🔧 **Technical Excellence**
- **Supabase Integration**: Real-time database with Row Level Security (RLS)
- **Offline-First Architecture**: Using Brick ORM for local data persistence
- **State Management**: Provider pattern for efficient state handling
- **Custom Animations**: Lottie animations for enhanced user experience

## 📱 App Screenshots

### 🏠 Main App Interface
<div align="center">
  <img src="Screenshot(4).png" alt="App Home Screen" width="300"/>
  <br/>
  <em>Main menu interface with restaurant categories and navigation</em>
</div>

<div align="center">
  <img src="Screenshot(5).png" alt="Food Deals Page" width="300"/>
  <br/>
  <em>Special deals and combo offers section</em>
</div>

<div align="center">
  <img src="Screenshot(6).png" alt="Restaurant Details" width="300"/>
  <br/>
  <em>Detailed restaurant information with ratings and contact details</em>
</div>

### 🤖 AI Assistant Integration (OpenAI GPT-4)
<div align="center">
  <img src="Screenshot(7).png" alt="AI Assistant Chat Interface" width="300"/>
  <br/>
  <em>OpenAI GPT-4 powered AI assistant with thread-based conversations</em>
</div>

<div align="center">
  <img src="Screenshot(8).png" alt="AI Food Recommendations" width="300"/>
  <br/>
  <em>Intelligent food recommendations using OpenAI API</em>
</div>

### 🍽️ Menu & Food Management
<div align="center">
  <img src="Screenshot(9).png" alt="Eatables Menu" width="300"/>
  <br/>
  <em>Comprehensive food menu with AI-powered search capabilities</em>
</div>

<div align="center">
  <img src="Screenshot(10).png" alt="Food Items Display" width="300"/>
  <br/>
  <em>Visual food items with detailed descriptions</em>
</div>

<div align="center">
  <img src="Screenshot(11).png" alt="Admin Dashboard" width="300"/>
  <br/>
  <em>Admin content management system with AI data uploads</em>
</div>

## 🤖 OpenAI GPT-4 Assistant Integration

### Advanced AI-Powered Food Discovery
The Torbaaz AI Assistant leverages **OpenAI's GPT-4 model** with sophisticated thread management for intelligent food conversations:

#### **🔗 OpenAI API Integration Architecture**
```dart
// Core OpenAI Integration Components
class OpenAIService {
  static const String apiKey = 'YOUR_OPENAI_API_KEY';
  static const String assistantId = 'asst_XXXXXXXXXXXXXXXXX';

  // Thread Management for Persistent Conversations
  Future<String> createThread() async {
    // Creates unique thread ID for each user session
    // Maintains conversation context across multiple queries
  }

  // GPT-4 Powered Food Assistant
  Future<String> sendMessage(String threadId, String message) async {
    // Sends user query to OpenAI Assistant API
    // Returns intelligent, contextual food recommendations
  }
}
```

#### **🧠 Thread-Based Conversation Management**
- **Unique Thread IDs**: Each user session gets a persistent OpenAI thread
- **Conversation Memory**: GPT-4 remembers previous queries and preferences
- **Context Preservation**: Multi-turn conversations with intelligent follow-ups
- **Session Persistence**: Thread IDs stored locally for continued conversations

#### **🍽️ AI-Powered Food Intelligence**
```javascript
// Example AI Assistant Conversations
User: "Show me all pizza options"
AI: "I found 15 pizza varieties across 3 restaurants. Here are the top options:
     🍕 Crust Bros: Peri Peri Pizza (Rs. 899), Chicken Supreme (Rs. 1299)
     🍕 Pizza Slice: Margherita (Rs. 649), Pepperoni (Rs. 799)"

User: "What about vegetarian options under 800?"
AI: "Based on your budget, here are vegetarian pizzas under Rs. 800:
     🥬 Pizza Slice: Margherita (Rs. 649) - Fresh tomatoes & mozzarella
     🌶️ Crust Bros: Veggie Delight (Rs. 749) - Bell peppers, olives, onions"
```

#### **⚡ Real-Time OpenAI Features**
- **GPT-4 Model**: Latest OpenAI language model for superior understanding
- **Assistant API**: Dedicated OpenAI Assistant with custom instructions
- **Function Calling**: AI can trigger app functions (search, filter, recommendations)
- **Streaming Responses**: Real-time message streaming for better UX
- **Error Handling**: Robust fallback mechanisms for API failures

#### **🎯 Custom Training & Knowledge Base**
- **Restaurant Data Integration**: AI trained on all 6 partner restaurants
- **Menu Knowledge**: 300+ food items with prices, descriptions, and categories
- **Local Context**: Understanding of Pakistani food culture and preferences
- **Dynamic Updates**: AI knowledge base updates with new menu items

## 🏗️ Technical Architecture

### **Frontend (Flutter) with OpenAI Integration**
```yaml
dependencies:
  flutter: sdk
  # AI & OpenAI Integration
  http: ^1.1.0                # OpenAI API calls
  flutter_dotenv: ^5.1.0      # Environment variables for API keys
  shared_preferences: ^2.2.2  # Thread ID persistence

  # Backend & Database
  supabase_flutter: ^2.8.4    # Real-time database
  brick_offline_first_with_supabase: ^1.0.0  # Offline-first architecture

  # State Management & UI
  provider: ^6.1.1            # State management
  google_fonts: ^5.1.0        # Typography
  lottie: ^3.1.0             # Animations
  cached_network_image: ^3.2.3 # Image optimization
```

### **OpenAI Integration Layer**
```dart
// Environment Configuration
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
OPENAI_ASSISTANT_ID=asst_xxxxxxxxxxxxxxxxxxxxxxxx
OPENAI_MODEL=gpt-4-1106-preview

// Core AI Service Architecture
class AIAssistantService {
  // Thread Management
  static String? currentThreadId;

  // OpenAI API Integration
  static const String baseUrl = 'https://api.openai.com/v1';
  static const String assistantsEndpoint = '/assistants';
  static const String threadsEndpoint = '/threads';
  static const String messagesEndpoint = '/messages';
  static const String runsEndpoint = '/runs';
}
```

### **Backend (Supabase)**
- **Real-time Database**: PostgreSQL with real-time subscriptions
- **Row Level Security**: Secure data access with admin-only write permissions
- **Authentication**: Secure admin authentication system
- **Storage**: Image and file storage for restaurant assets

### **Data Architecture**
```sql
-- Core Database Tables
restaurants          # Restaurant information and ratings
menu_categories      # Food category organization
food_items          # Individual menu items with pricing
deals               # Special offers and combos
ai_txt_uploads      # AI training data and responses
admins              # Admin user management
```

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: 3.32.0 or higher
- **Dart SDK**: 3.8.0 or higher
- **Android Studio**: Latest version with Android SDK
- **Supabase Account**: For backend services

### Installation

1. **Clone the Repository**
```bash
git clone https://github.com/AnsAsghar/Torbaaz.git
cd Torbaaz
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Environment Setup**
Create a `.env` file in the root directory:
```env
# OpenAI Configuration (Required for AI Assistant)
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
OPENAI_ASSISTANT_ID=asst_xxxxxxxxxxxxxxxxxxxxxxxx
OPENAI_MODEL=gpt-4-1106-preview

# Supabase Configuration
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

**🔑 Getting OpenAI API Keys:**
1. Visit [OpenAI Platform](https://platform.openai.com/)
2. Create an account and navigate to API Keys
3. Generate a new API key for your project
4. Create an OpenAI Assistant in the Playground
5. Copy the Assistant ID from the Assistant settings

4. **Run the Application**
```bash
# For development
flutter run

# For release build
flutter build apk --release
```

### Configuration

#### **Supabase Setup**
1. Create a new Supabase project
2. Set up the database schema using the provided SQL scripts
3. Configure Row Level Security (RLS) policies
4. Add your Supabase credentials to the `.env` file

#### **OpenAI Assistant Setup**
1. **Create OpenAI Assistant**: Use the OpenAI Playground to create a custom assistant
2. **Configure Instructions**: Set up the assistant with food-specific knowledge
3. **Enable Function Calling**: Configure the assistant to interact with app functions
4. **Test Integration**: Verify API connectivity and thread management

#### **Admin Access**
- **Email**: ansasghar777@gmail.com
- **Password**: AnsAsghar777
- **Role**: Super Admin with full content management access

## 🧠 AI Assistant Implementation Details

### **Thread Management System**
```dart
class ThreadManager {
  static const String _threadKey = 'openai_thread_id';

  // Create or retrieve existing thread
  static Future<String> getOrCreateThread() async {
    final prefs = await SharedPreferences.getInstance();
    String? threadId = prefs.getString(_threadKey);

    if (threadId == null) {
      threadId = await OpenAIService.createThread();
      await prefs.setString(_threadKey, threadId);
    }

    return threadId;
  }

  // Clear thread for new conversation
  static Future<void> clearThread() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_threadKey);
  }
}
```

### **OpenAI API Integration Flow**
1. **User Input**: User types a food-related query
2. **Thread Retrieval**: App gets or creates OpenAI thread ID
3. **Message Creation**: Send user message to OpenAI thread
4. **Assistant Run**: Trigger OpenAI assistant to process the message
5. **Response Polling**: Poll for assistant response completion
6. **Display Response**: Show AI response in chat interface
7. **Context Preservation**: Thread maintains conversation history

### **AI Assistant Capabilities**
- **Food Search**: "Show me all pizza options under 1000 rupees"
- **Restaurant Queries**: "What's the rating of Crust Bros Jahanian?"
- **Deal Discovery**: "Find me the best family deals available"
- **Nutritional Info**: "Which restaurants have vegetarian options?"
- **Price Comparisons**: "Compare burger prices across all restaurants"
- **Location Services**: "Show me restaurants near my location"

## 🏪 Partner Restaurants

### **Featured Establishments**

#### 🍕 **Crust Bros Jahanian**
- **Rating**: ⭐ 4.5/5
- **Specialties**: Gourmet Pizzas, Italian Cuisine
- **Popular Items**: Peri Peri Pizza, Chicken Supreme, Cheese Lovers

#### 🍔 **Meet N Eat**
- **Rating**: ⭐ 4.3/5
- **Specialties**: Burgers, Steaks, Grilled Items
- **Popular Items**: Zinger Burgers, Mushroom Steak, BBQ Wings

#### 🍛 **Khana Khazana Tandoor**
- **Rating**: ⭐ 4.7/5
- **Specialties**: Traditional Pakistani Cuisine, Tandoor Items
- **Popular Items**: Biryani, Karahi, Naan Varieties

#### 🍗 **Miran Jee Food Club (MFC)**
- **Rating**: ⭐ 4.2/5
- **Specialties**: Fried Chicken, Fast Food
- **Popular Items**: Crispy Chicken, Loaded Fries, Wings

#### 🍕 **Pizza Slice**
- **Rating**: ⭐ 4.1/5
- **Specialties**: Quick Pizza, Casual Dining
- **Popular Items**: Margherita, Pepperoni, Garlic Bread

#### 🥘 **Eatway Restaurant**
- **Rating**: ⭐ 4.4/5
- **Specialties**: Multi-cuisine, Family Dining
- **Popular Items**: Chinese Rice, Pasta, Desserts

## 📁 Project Structure

```
torbaaz/
├── lib/
│   ├── brick/                 # Brick ORM configuration
│   ├── data/                  # Data models and repositories
│   ├── models/                # Data models
│   ├── pages/                 # UI screens
│   │   ├── ai_assistant_page.dart
│   │   ├── admin_dashboard_page.dart
│   │   ├── food_deals_page.dart
│   │   ├── menu_page.dart
│   │   └── ...
│   ├── providers/             # State management
│   ├── services/              # Business logic services
│   ├── theme/                 # App theming
│   ├── utils/                 # Utility functions
│   ├── widgets/               # Reusable UI components
│   └── main.dart              # App entry point
├── assets/
│   ├── images/                # Restaurant and food images
│   ├── fonts/                 # Custom fonts (Poppins)
│   └── splash.json            # Lottie animation
├── android/                   # Android-specific configuration
├── ios/                       # iOS-specific configuration
└── web/                       # Web-specific configuration
```

## 🔧 Development Features

### **State Management**
- **Provider Pattern**: Efficient state management across the app
- **Local Storage**: Shared preferences for user settings
- **Offline Support**: Brick ORM for offline-first architecture

### **UI/UX Design**
- **Material Design 3**: Modern Flutter design system
- **Custom Typography**: Poppins font family throughout
- **Responsive Layout**: Optimized for various screen sizes
- **Dark Theme Support**: Elegant black and orange color scheme

### **Performance Optimization**
- **Image Caching**: Cached network images for faster loading
- **Lazy Loading**: Efficient data loading strategies
- **Memory Management**: Optimized widget lifecycle management

## 🤝 Contributing

We welcome contributions to make Torbaaz even better! Here's how you can help:

### **Getting Started**
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### **Development Guidelines**
- Follow Flutter/Dart coding standards
- Write meaningful commit messages
- Add comments for complex logic
- Test your changes thoroughly
- Update documentation as needed

### **Areas for Contribution**
- 🤖 AI Assistant improvements
- 🎨 UI/UX enhancements
- 🔧 Performance optimizations
- 📱 New features and functionality
- 🐛 Bug fixes and improvements

## 📞 Contact & Support

### **Developer Information**
- **Name**: Anas Asghar
- **Email**: ansasghar777@gmail.com
- **GitHub**: [@AnsAsghar](https://github.com/AnsAsghar)
- **LinkedIn**: [Anas Asghar](https://linkedin.com/in/ansasghar)

### **Project Links**
- **Repository**: [https://github.com/AnsAsghar/Torbaaz](https://github.com/AnsAsghar/Torbaaz)
- **Issues**: [Report bugs or request features](https://github.com/AnsAsghar/Torbaaz/issues)
- **Discussions**: [Join the community](https://github.com/AnsAsghar/Torbaaz/discussions)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team**: For the amazing cross-platform framework
- **Supabase**: For providing excellent backend-as-a-service
- **Restaurant Partners**: For trusting us with their digital presence
- **Community**: For feedback and continuous support

---

**Made with ❤️ in Pakistan** | **Connecting Food Lovers with Great Restaurants**

*Torbaaz - Where Technology Meets Taste* 🍽️✨
