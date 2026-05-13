import 'package:flutter/material.dart';
import 'package:nefkes_dj_web/services/nefchat_service.dart';

void main() {
  runApp(const NefkesApp());
}

class NefkesApp extends StatelessWidget {
  const NefkesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nefkes - DJ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A0520),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NefchatService _nefchat = NefchatService();
  final TextEditingController _controller = TextEditingController();
  String _response = '';
  bool _isTyping = false;

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() => _isTyping = true);

    final reply = await _nefchat.sendMessage(
      message: _controller.text,
      model: 'opencode/nemotron-3-super-free',
    );

    setState(() {
      _response = reply;
      _isTyping = false;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0520),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0520),
        title: const Text(
          'Nefkes DJ',
          style: TextStyle(fontFamily: 'Cinzel', fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/nefkes_avatar.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nefkes',
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'DJ & Music AI Assistant',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  if (_response.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A2E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _response,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (_isTyping)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 10),
                  Text('Nefchat is thinking...'),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Ask Nefchat about music...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFF1A1A2E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}