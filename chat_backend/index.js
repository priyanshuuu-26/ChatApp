const express = require('express');
const http = require('http');
const { Server } = require("socket.io");

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "*",
    },
});

const userSocketMap = {};

io.on('connection', (socket) => {
    console.log('A user connected:', socket.id);

    const userId = socket.handshake.query.userId;
    if (userId) {
        console.log(`User ${userId} mapped to socket ${socket.id}`);
        userSocketMap[userId] = socket.id;
    }

    socket.on('sendMessage', (data) => {
        const { recipientId, message } = data;
        const recipientSocketId = userSocketMap[recipientId];

        console.log(`Message from ${userId} to ${recipientId}: ${message}`);

        if (recipientSocketId) {
            io.to(recipientSocketId).emit('receiveMessage', {
                senderId: userId,
                message: message,
            });
            console.log(`Message sent to ${recipientId}`);
        } else {
            console.log(`Recipient ${recipientId} is not online.`);
        }
    });

    socket.on('disconnect', () => {
        for (const [key, value] of Object.entries(userSocketMap)) {
            if (value === socket.id) {
                delete userSocketMap[key];
                break;
            }
        }
        console.log('User disconnected:', socket.id);
    });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});