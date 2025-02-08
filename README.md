# ObjectBoxSwiftUIExample_iOS

A sample iOS app demonstrating **ObjectBox** integration with **SwiftUI**. This example showcases how to use ObjectBox for **local database storage**, **relationship handling**, and **live UI updates** in a SwiftUI app.

## 📌 Features
-  **ObjectBox as a Local Database** - Store and retrieve objects efficiently.  
-  **SwiftUI Integration** - Auto-updating UI with `@ObservedModel` and `@ObservedResults`.  
-  **Relations Handling** - Demonstrates **one-to-many** relationships (`Author → Books`).  
-  **Live Updates** - Changes in the database automatically reflect in the UI.  
-  **Safe Deletion Handling** - Prevents crashes when related objects are removed.  

---

## 📥 Installation

1. **Clone the repository:**  
   ```sh
   git clone https://github.com/chrisrohrer/ObjectBoxSwiftUIExample_iOS.git
   cd ObjectBoxSwiftUIExample_iOS
   ```

2. **Install dependencies using CocoaPods:**  
   ```sh
    pod install --repo-update
    Pods/ObjectBox/setup.rb
   ```

3. **Open the Xcode workspace:** (not .xcodeproj)
   ```sh
   open ObjectBoxSwiftUIExample_iOS.xcworkspace
   ```

4. **Run the app on a simulator or device.**

---

## 🛠 Remarks

### Sample Data
- The app loads some sample data on launch automatically.

### Creating Authors and Adding Books
- The app allows adding `Authors`, each with multiple `Books`.
- Books are linked to their respective authors using ObjectBox relationships.

### Deleting
- Can be done via swipe or Conext Menu (long press).

### Observing Changes with `@ObservedModel`
- ObjectBox entities are observed in SwiftUI using:
   ```swift
   @ObservedModel var author: Author
   ```
- This ensures that any **changes to the author** or **its books** are immediately persisted.

### Fetching Lists with `@ObservedResults`
- Fetch all books written by authors:
   ```swift
   @ObservedResults var books: [Book]
   ```
- Supports **sorting & filtering** to display only relevant data and updates on database changes.

---

## 📜 License
This project is licensed under the **MIT License**.

---
