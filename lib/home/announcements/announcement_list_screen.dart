import 'package:flutter/material.dart';

class LegalAdviceChatScreen extends StatefulWidget {
  const LegalAdviceChatScreen({super.key});

  @override
  State<LegalAdviceChatScreen> createState() => _LegalAdviceChatScreenState();
}

class _LegalAdviceChatScreenState extends State<LegalAdviceChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages = [];

  // Bu erda faqatgina sun'iy intellekt uchun namuna javob keltirilgan
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'sender': 'user',
          'message': _controller.text,
        });

        // AI javobi (bu erda oddiy qo‘l bilan qo‘shilmoqda)
        _messages.add({
          'sender': 'ai',
          'message': 'Sizning muammoingizga javob: Muammo qonunlar bilan to‘g‘ri hal qilinadi.',
        });

        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Huquqiy Maslahatlar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return ListTile(
                  title: Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message['message']!,
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Muammoingizni kiriting...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
