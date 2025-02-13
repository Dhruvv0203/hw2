// Andres Cuervo
// Dhruv Patel

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const HeartbeatApp());
}

class HeartbeatApp extends StatelessWidget {
  const HeartbeatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HeartbeatScreen(),
    );
  }
}

class HeartbeatScreen extends StatefulWidget {
  const HeartbeatScreen({super.key});

  @override
  _HeartbeatScreenState createState() => _HeartbeatScreenState();
}

class _HeartbeatScreenState extends State<HeartbeatScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;
  Duration _timeLeft = Duration.zero;
  
  List<String> messages = [
    "Happy Valentine's Day! 💘",
    "You make my heart skip a beat!",
    "Love is in the air 💖",
    "You're my favorite notification ❤️",
    "Be mine, Valentine! 💕"
  ];
  int currentMessageIndex = 0;
  bool _showMessage = true;

  @override
  void initState() {
    super.initState();

    // Heartbeat Animation Setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller);

    // Start Countdown Timer for Friday
    _startCountdown();

    // Cycle messages every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        currentMessageIndex = (currentMessageIndex + 1) % messages.length;
        _showMessage = !_showMessage; // Toggle fade effect
      });
    });
  }

  /// Start countdown to this **Friday**
  void _startCountdown() {
    DateTime now = DateTime.now();
    DateTime nextFriday = _getNextFriday(now);

    _timeLeft = nextFriday.difference(now);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft = nextFriday.difference(DateTime.now());
        if (_timeLeft.isNegative) {
          timer.cancel();
          _timeLeft = Duration.zero;
        }
      });
    });
  }

  /// Get the next **Friday** from today's date
  DateTime _getNextFriday(DateTime now) {
    int daysUntilFriday = (DateTime.friday - now.weekday) % 7;
    if (daysUntilFriday == 0) {
      daysUntilFriday = 7; // If today is already Friday, set to next Friday
    }
    return now.add(Duration(days: daysUntilFriday)).copyWith(hour: 0, minute: 0, second: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text("Heartbeat Animation 💓"),
        backgroundColor: Colors.pink,
      ),
      body: Stack(
        children: [
          // Floating Hearts Background
          ...List.generate(10, (index) => FloatingHeart()),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Valentine's Day Countdown Display
                Text(
                  "Time Until Valentine's Day 💝",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.redAccent),
                ),
                const SizedBox(height: 10),
                Text(
                  _formatCountdown(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Heartbeat Animation with Image
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentMessageIndex = (currentMessageIndex + 1) % messages.length;
                    });
                  },
                  child: ScaleTransition(
                    scale: _animation,
                    child: Image.asset(
                      "assets/images/heart.png",
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Fading Valentine's Message
                AnimatedOpacity(
                  opacity: _showMessage ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Text(
                    messages[currentMessageIndex],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Format countdown into **Days, Hours, Minutes, Seconds**
  String _formatCountdown() {
    int days = _timeLeft.inDays;
    int hours = _timeLeft.inHours % 24;
    int minutes = _timeLeft.inMinutes % 60;
    int seconds = _timeLeft.inSeconds % 60;

    return "$days Days, $hours Hours, $minutes Minutes, $seconds Seconds";
  }
}

// Floating Hearts Animation
class FloatingHeart extends StatelessWidget {
  final Random random = Random();

  FloatingHeart({super.key});

  @override
  Widget build(BuildContext context) {
    double leftPosition = random.nextDouble() * MediaQuery.of(context).size.width;
    int duration = 3 + random.nextInt(5); // Random duration between 3-8 sec

    return AnimatedPositioned(
      duration: Duration(seconds: duration),
      curve: Curves.easeInOut,
      top: -50,
      left: leftPosition,
      bottom: MediaQuery.of(context).size.height,
      child: Icon(
        Icons.favorite,
        color: Colors.pink.withOpacity(0.5),
        size: 30 + random.nextInt(20).toDouble(),
      ),
    );
  }
}
