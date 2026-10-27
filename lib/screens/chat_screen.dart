import 'package:flutter/material.dart';

import '../models/item.dart';
import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  final Item item;

  const ChatScreen({super.key, required this.item});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return; // empty / whitespace-only does nothing

    setState(() {
      _messages.add(Message(text: text, isMine: true, sentAt: DateTime.now()));
    });
    _controller.clear();

    // Keep the new bubble in view at the bottom of the list.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
    // TODO: send to OpenRouter and add the seller's reply (Chat · HTTP)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danggeun · ${widget.item.title}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _bubble(_messages[index]),
            ),
          ),

          // Input bar pinned at the bottom
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(hintText: 'Message...'),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: _send,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(Message message) {
    const radius = Radius.circular(12);
    final mine = message.isMine;
    final time =
        '${message.sentAt.hour.toString().padLeft(2, '0')}:'
        '${message.sentAt.minute.toString().padLeft(2, '0')}';

    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: mine
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: mine
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[200],
                borderRadius: mine
                    ? const BorderRadius.only(
                        topLeft: radius,
                        bottomLeft: radius,
                        bottomRight: radius,
                      )
                    : const BorderRadius.only(
                        topRight: radius,
                        bottomLeft: radius,
                        bottomRight: radius,
                      ),
              ),
              child: Text(
                message.text,
                style: TextStyle(color: mine ? Colors.white : Colors.black),
              ),
            ),
            Text(
              time,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
