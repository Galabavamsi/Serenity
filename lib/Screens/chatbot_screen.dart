import 'package:flutter/material.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];

  void _sendMessage() {
    String message = _controller.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        messages.add({'sender': 'user', 'message': message});
        _controller.clear();
      });

      // Simulate bot response after a slight delay
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          messages.add({'sender': 'bot', 'message': _generateBotResponse(message)});
        });
      });
    }
  }

  String _generateBotResponse(String message) {
    // Simple logic to generate a bot response based on the message
    if (message.toLowerCase().contains('hello') || message.toLowerCase().contains('hi')) {
      return "Hello! How can I assist you today?";
    } else if (message.toLowerCase().contains('stress')) {
      return "It seems like you're feeling stressed. Would you like some stress-relief tips?";
    } else if (message.toLowerCase().contains('mood')) {
      return "I can help you track your mood. Let's start with how you're feeling right now!";
    } else {
      return "I'm here to help you. Could you tell me more?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with Serenity Bot"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          // Chat history
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                bool isUserMessage = message['sender'] == 'user';

                return ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  title: Align(
                    alignment:
                    isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        message['message'] ?? '',
                        style: TextStyle(
                          color: isUserMessage ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Message input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}