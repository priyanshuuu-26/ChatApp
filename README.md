# 💬 Flutter & Node.js Real-Time Chat App

A complete **full-stack, one-on-one chat application** built with **Flutter** for the frontend and a **Node.js** backend.  
This project demonstrates **real-time, bidirectional communication** using WebSockets.

---

## 🌟 Features

- **User Identification:** A simple welcome screen for users to enter a username.  
- **Contact List:** A static list of users to initiate conversations with.  
- **Real-Time Messaging:** Instant message delivery and reception using WebSockets.  
- **Clean UI:** Simple and intuitive user interface for chatting.  

---

## 💻 Tech Stack & Architecture

### Frontend (Client)
- **Flutter:** Cross-platform mobile development.  
- **Riverpod:** Robust state management.  
- **socket_io_client:** WebSocket communication with the server.  

### Backend (Server)
- **Node.js:** JavaScript runtime for the server.  
- **Express.js:** Minimalist web framework.  
- **Socket.IO:** Real-time, event-based communication library.  

### 🔗 Architecture Overview

The **Flutter app (client)** establishes a **WebSocket connection** with the **Node.js server**.

1. When a user sends a message, the app emits a `sendMessage` event.  
2. The server identifies the recipient and emits a `receiveMessage` event to that user's client.  
3. The recipient's app receives and displays the message instantly.  

---

## 🚀 Getting Started

Follow these instructions to set up the project on your local machine.

### ✅ Prerequisites

Make sure you have installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)  
- [Node.js](https://nodejs.org/) (includes npm)  
- A code editor (e.g., VS Code)  
- Android Emulator or physical device  

---

## ⚙️ Backend Setup

1. **Clone the repository**
    ```bash
    git clone https://github.com/priyanshuuu-26/ChatApp.git
    ```

2. **Navigate to backend directory**
    ```bash
    cd ChatApp/chat_backend
    ```

3. **Install dependencies**
    ```bash
    npm install
    ```

4. **Start the server**
    ```bash
    node index.js
    ```
    You should see: `Server is running on port 3000`

---

## 📱 Frontend Setup

1. **Navigate to the frontend directory**
    ```bash
    cd ChatApp/chat_app
    ```

2. **Install Flutter dependencies and run**
    ```bash
    flutter pub get
    flutter run
    ```

---

## ⚠️ Important Change: Configure the Server IP Address

Before running the app, update the WebSocket connection string in:  
`lib/providers/socket_provider.dart`

```dart
final socketProvider = Provider<IO.Socket>((ref) {
  final socket = IO.io('http://YOUR_COMPUTER_IP_ADDRESS:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
  return socket;
});
```
Replace `YOUR_COMPUTER_IP_ADDRESS` with your local IP address (e.g., `192.168.1.10`).

---

## 🧪 How to Use

1. Run the backend server.
2. Launch the Flutter app on two devices (emulators or real devices).
3. Enter usernames (e.g., Alice and Bob).
4. Select a contact and start chatting.
5. Messages appear instantly across devices.

---

## 🌱 Future Improvements

- [ ] Database Integration (MongoDB) for users & chat history
- [ ] User Authentication (login/registration system)
- [ ] Dynamic Contacts via API
- [ ] Typing Indicators (“... is typing”)
- [ ] Online Status (active users)
- [ ] Group Chats

---
