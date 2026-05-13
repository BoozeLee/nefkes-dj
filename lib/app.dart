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
      title: 'Nefkes DJ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF006E),
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

    final reply = await _nefchat.sendMessage(message: _controller.text);

    setState(() {
      _response = reply;
      _isTyping = false;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const LinearGradient(
        colors: [Color(0xFF0A0520), Color(0xFF1a0033)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(const Size(400, 800)),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0520),
        title: const Text(
          '🎧 NEFKE\'S COSMIC BASEMENT',
          style: TextStyle(fontFamily: 'Cinzel', fontSize: 20, color: Colors.pink),
        ),
        centerTitle: true,
        subtitle: const Text(
          'Broadcasting live from the psychedelic void...',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
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
                    child: Icon(Icons.music_note, size: 80, color: Colors.pink),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'DJ NEFKE',
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontSize: 32,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Chaotic Rave Philosopher',
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
                        border: Border.all(color: Colors.pink, width: 1),
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
                  CircularProgressIndicator(color: Colors.pink),
                  SizedBox(width: 10),
                  Text('Nefke is mixing psychotronic frequencies...', style: TextStyle(color: Colors.pink)),
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
                      hintText: 'Drop your vibe here...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFF1A1A2E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Colors.pink),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.pink,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.black),
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