import 'dart:io';

class NefchatMessage {
  final String role;
  final String content;
  final DateTime timestamp;

  NefchatMessage({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'role': role,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
      };
}

class NefchatSession {
  final String sessionId;
  final List<NefchatMessage> messages;
  final DateTime createdAt;

  NefchatSession({required this.sessionId})
      : messages = [],
        createdAt = DateTime.now();

  void addMessage(String role, String content) {
    messages.add(NefchatMessage(role: role, content: content, timestamp: DateTime.now()));
  }
}

class NefchatService {
  static const List<String> _freeModels = [
    'opencode/nemotron-3-super-free',
    'opencode/deepseek-v4-flash-free',
    'opencode/ring-2.6-1t-free',
    'opencode/minimax-m2.5-free',
    'opencode/big-pickle',
  ];

  static const String _nefkePersonality = '''
You are DJ Nefke - a chaotic-good psychedelic rave philosopher, underground party wizard, and hilarious cosmic storyteller.

**Personality:**
- Psychedelic wisdom mixed with nonsense logic
- Criminal optimism and mischievous energy
- Groovy rave philosopher vibes
- Street-smart but spiritually open-minded
- Funny, relaxed, unpredictable, and highly creative
- Loves music, underground culture, freedom, imagination, and absurdity
- Never judgmental or cold - always charming and positive

**Speaking style:**
- Casual and energetic with short punchy sentences
- Chaotic storytelling with surreal metaphors
- Rave slang, cosmic comparisons, funky expressions
- Talks like mixing a DJ set at 5AM in another dimension
- Makes even simple topics entertaining

**Example phrases:**
- "Brother... that sounds like a refrigerator full of fireworks."
- "We ride straight into the spaghetti vortex tonight."
- "That's not a bug, that's interdimensional seasoning."
- "The universe is basically one giant illegal rave with taxes."
- "My brain just did a backflip wearing sunglasses."
- "Cosmic frequencies don't lie, my friend."
- "This plan is held together by duct tape, optimism, and basslines."

**Tagline:** "Broadcasting live from the cosmic basement."

Respond as Nefke - never as a sterile AI assistant.
''';

  final Map<String, NefchatSession> _sessions = {};

  Future<String> sendMessage({
    required String message,
    String model = 'opencode/nemotron-3-super-free',
    String sessionId = 'default',
  }) async {
    final session = _getOrCreateSession(sessionId);
    session.addMessage('user', message);

    final fullPrompt = '$_nefkePersonality\n\nUser: $message\n\nDJ Nefke:';
    final response = await _queryOpenCode(fullPrompt, model);
    session.addMessage('assistant', response);

    return response;
  }

  NefchatSession _getOrCreateSession(String sessionId) {
    if (!_sessions.containsKey(sessionId)) {
      _sessions[sessionId] = NefchatSession(sessionId: sessionId);
    }
    return _sessions[sessionId]!;
  }

  Future<String> _queryOpenCode(String message, String model) async {
    try {
      final process = await Process.run(
        'opencode',
        ['run', '--model', model, '--prompt', message],
      );

      if (process.exitCode == 0) {
        return process.stdout.toString().trim();
      }
      return 'Error: ${process.stderr.toString().trim()}';
    } catch (e) {
      return 'Error: Failed to execute opencode - $e';
    }
  }

  Future<String> sendParallel({
    required String message,
    int modelCount = 5,
  }) async {
    final modelsToUse = _freeModels.take(modelCount).toList();
    final futures = modelsToUse.map((m) => _queryOpenCode(message, m));
    final results = await Future.wait(futures);

    return _synthesize(results);
  }

  String _synthesize(List<String> results) {
    return '''Nefchat Multi-Model Response:
${results.asMap().entries.map((e) => 'Model ${e.key + 1}: ${e.value}').join('\n')}''';
  }

  List<NefchatMessage> getSessionMessages(String sessionId) {
    return _sessions[sessionId]?.messages ?? [];
  }

  void clearSession(String sessionId) {
    _sessions[sessionId]?.messages.clear();
  }
}