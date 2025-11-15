# Valuify - Architecture Documentation

## 🏗️ Application Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         VALUIFY APP                          │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   UI Layer   │  │ State Layer  │  │ Data Layer   │      │
│  │  (Screens)   │◄─┤ (Providers)  │◄─┤  (Services)  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│         │                  │                  │              │
│         │                  │                  │              │
│         ▼                  ▼                  ▼              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Widgets    │  │    Models    │  │   Firebase   │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## 📊 Layer Breakdown

### 1. UI Layer (Screens & Widgets)

**Screens:**
- `login_screen.dart` - Authentication
- `register_screen.dart` - User registration
- `dashboard_screen.dart` - Main dashboard
- `transactions_screen.dart` - Transaction list
- `add_transaction_screen.dart` - Add/edit transactions
- `categories_screen.dart` - Category management
- `budgets_screen.dart` - Budget management
- `reports_screen.dart` - Reports & exports
- `settings_screen.dart` - App settings

**Widgets:**
- `balance_card.dart` - Animated balance display
- `transaction_item.dart` - Transaction list item
- `category_icon.dart` - Category icon component
- `chart_widgets.dart` - Chart components

### 2. State Management Layer (Riverpod Providers)

```
┌─────────────────────────────────────────────┐
│           Riverpod Providers                 │
├─────────────────────────────────────────────┤
│                                              │
│  authStateProvider                           │
│  ├─ Watches Firebase Auth state             │
│  └─ Provides current user                   │
│                                              │
│  transactionsProvider                        │
│  ├─ Streams transactions from Firestore     │
│  └─ Provides filtered transactions          │
│                                              │
│  categoriesProvider                          │
│  ├─ Streams categories from Firestore       │
│  └─ Provides expense/income categories      │
│                                              │
│  budgetsProvider                             │
│  ├─ Streams budgets from Firestore          │
│  └─ Calculates budget progress              │
│                                              │
│  themeProvider                               │
│  ├─ Manages theme mode (light/dark)         │
│  └─ Persists to SharedPreferences           │
│                                              │
└─────────────────────────────────────────────┘
```

### 3. Data Layer (Services)

```
┌─────────────────────────────────────────────┐
│              Services                        │
├─────────────────────────────────────────────┤
│                                              │
│  AuthService                                 │
│  ├─ signInWithEmail()                       │
│  ├─ registerWithEmail()                     │
│  ├─ signInWithGoogle()                      │
│  ├─ signOut()                               │
│  └─ resetPassword()                         │
│                                              │
│  FirestoreService                            │
│  ├─ getTransactions()                       │
│  ├─ addTransaction()                        │
│  ├─ updateTransaction()                     │
│  ├─ deleteTransaction()                     │
│  ├─ getCategories()                         │
│  ├─ addCategory()                           │
│  ├─ getBudgets()                            │
│  ├─ setBudget()                             │
│  └─ getSettings()                           │
│                                              │
│  StorageService                              │
│  ├─ uploadReceipt()                         │
│  └─ deleteReceipt()                         │
│                                              │
│  PdfService                                  │
│  └─ generateMonthlyReport()                 │
│                                              │
└─────────────────────────────────────────────┘
```

## 🔄 Data Flow

### Transaction Creation Flow

```
User Action (Add Transaction)
        │
        ▼
AddTransactionScreen
        │
        ▼
Form Validation
        │
        ▼
Upload Receipt (if any)
        │
        ▼
StorageService.uploadReceipt()
        │
        ▼
Get Receipt URL
        │
        ▼
Create TransactionModel
        │
        ▼
FirestoreService.addTransaction()
        │
        ▼
Firestore Database
        │
        ▼
transactionsProvider (Stream)
        │
        ▼
UI Updates Automatically
```

### Authentication Flow

```
User Login
    │
    ▼
LoginScreen
    │
    ├─ Email/Password ──► AuthService.signInWithEmail()
    │                              │
    └─ Google Sign-In ──► AuthService.signInWithGoogle()
                                   │
                                   ▼
                          Firebase Authentication
                                   │
                                   ▼
                          authStateProvider
                                   │
                                   ▼
                          AuthWrapper (main.dart)
                                   │
                    ┌──────────────┴──────────────┐
                    │                             │
                    ▼                             ▼
              User = null                    User exists
                    │                             │
                    ▼                             ▼
              LoginScreen                   MainScreen
```

## 🗄️ Database Schema

### Firestore Collections

```
users (collection)
│
├─ {userId} (document)
│   │
│   ├─ transactions (subcollection)
│   │   └─ {transactionId} (document)
│   │       ├─ userId: string
│   │       ├─ amount: number
│   │       ├─ type: string (income/expense)
│   │       ├─ categoryId: string
│   │       ├─ date: timestamp
│   │       ├─ merchant: string
│   │       ├─ notes: string
│   │       ├─ receiptUrl: string
│   │       └─ createdAt: timestamp
│   │
│   ├─ categories (subcollection)
│   │   └─ {categoryId} (document)
│   │       ├─ userId: string
│   │       ├─ name: string
│   │       ├─ icon: string
│   │       ├─ colorValue: number
│   │       ├─ type: string (income/expense)
│   │       └─ isDefault: boolean
│   │
│   ├─ budgets (subcollection)
│   │   └─ {budgetId} (document)
│   │       ├─ userId: string
│   │       ├─ categoryId: string
│   │       ├─ amount: number
│   │       ├─ month: number
│   │       ├─ year: number
│   │       └─ createdAt: timestamp
│   │
│   └─ settings (subcollection)
│       └─ preferences (document)
│           ├─ currency: string
│           ├─ currencySymbol: string
│           ├─ theme: string
│           └─ biometricEnabled: boolean
```

### Firebase Storage Structure

```
receipts/
└─ {userId}/
    ├─ {receiptId1}.jpg
    ├─ {receiptId2}.jpg
    └─ {receiptId3}.jpg
```

## 🔐 Security Architecture

### Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      // User can only access their own data
      allow read, write: if request.auth != null 
                         && request.auth.uid == userId;
      
      // All subcollections inherit this rule
      match /{document=**} {
        allow read, write: if request.auth != null 
                           && request.auth.uid == userId;
      }
    }
  }
}
```

### Storage Security Rules

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /receipts/{userId}/{allPaths=**} {
      // User can only access their own receipts
      allow read, write: if request.auth != null 
                         && request.auth.uid == userId;
    }
  }
}
```

## 🎯 Design Patterns Used

### 1. Repository Pattern
- Services act as repositories
- Abstract Firebase operations
- Single source of truth

### 2. Provider Pattern (Riverpod)
- Dependency injection
- State management
- Reactive programming

### 3. Model-View-ViewModel (MVVM)
- Models: Data structures
- Views: UI screens
- ViewModels: Providers

### 4. Factory Pattern
- Model.fromMap() constructors
- Object creation from Firestore data

### 5. Singleton Pattern
- Service instances
- Firebase instances

## 📱 Navigation Structure

```
App Start
    │
    ▼
AuthWrapper
    │
    ├─ Not Authenticated ──► LoginScreen
    │                            │
    │                            ├─ Register ──► RegisterScreen
    │                            │
    │                            └─ Login Success ──┐
    │                                               │
    └─ Authenticated ──────────────────────────────┘
                                                    │
                                                    ▼
                                              MainScreen
                                                    │
                    ┌───────────────────────────────┼───────────────────────────────┐
                    │               │               │               │               │
                    ▼               ▼               ▼               ▼               ▼
              Dashboard      Transactions     Categories        Budgets         Reports
                                    │
                                    ▼
                          AddTransactionScreen
```

## 🔄 State Management Flow

```
User Interaction
        │
        ▼
Widget (UI)
        │
        ▼
Provider (State)
        │
        ▼
Service (Business Logic)
        │
        ▼
Firebase (Backend)
        │
        ▼
Stream/Future
        │
        ▼
Provider Updates
        │
        ▼
Widget Rebuilds
        │
        ▼
UI Updates
```

## 🚀 Performance Optimizations

### 1. Lazy Loading
- Transactions loaded on demand
- Images cached with CachedNetworkImage

### 2. Stream Subscriptions
- Real-time updates with Firestore streams
- Automatic cleanup with Riverpod

### 3. Efficient Queries
- Indexed Firestore queries
- Filtered data at database level

### 4. State Optimization
- Riverpod's automatic caching
- Minimal rebuilds with select()

### 5. Image Optimization
- Compressed receipt uploads
- Cached network images

## 📊 Scalability Considerations

### Current Architecture Supports:
- ✅ Thousands of transactions per user
- ✅ Real-time sync across devices
- ✅ Offline-first with Firebase
- ✅ Horizontal scaling (Firebase)
- ✅ Multiple concurrent users

### Future Scaling Options:
- Cloud Functions for heavy processing
- Firestore composite indexes
- CDN for static assets
- Background sync workers
- Data pagination

## 🧪 Testing Strategy

### Unit Tests
- Model serialization/deserialization
- Helper functions
- Business logic

### Widget Tests
- Individual widget behavior
- User interactions
- State changes

### Integration Tests
- End-to-end flows
- Firebase integration
- Navigation flows

## 📝 Code Organization Principles

### 1. Separation of Concerns
- UI separate from business logic
- Services handle data operations
- Providers manage state

### 2. Single Responsibility
- Each file has one purpose
- Small, focused functions
- Clear naming conventions

### 3. DRY (Don't Repeat Yourself)
- Reusable widgets
- Shared utilities
- Common constants

### 4. SOLID Principles
- Single responsibility
- Open/closed principle
- Dependency inversion

## 🎨 UI Architecture

### Theme System
```
ThemeData
    │
    ├─ Light Theme
    │   ├─ Colors
    │   ├─ Typography
    │   └─ Component Themes
    │
    └─ Dark Theme
        ├─ Colors
        ├─ Typography
        └─ Component Themes
```

### Component Hierarchy
```
MaterialApp
    │
    └─ AuthWrapper
        │
        └─ MainScreen
            │
            ├─ NavigationBar
            │
            └─ Screen Content
                │
                ├─ Scaffold
                │   ├─ AppBar
                │   ├─ Body
                │   └─ FAB
                │
                └─ Custom Widgets
```

---

This architecture provides:
- ✅ Scalability
- ✅ Maintainability
- ✅ Testability
- ✅ Performance
- ✅ Security
- ✅ Clean code structure
