import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MoveMinuteApp());
}

class MoveMinuteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Move Minute',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MoveHomePage(),
    );
  }
}

class MoveHomePage extends StatefulWidget {
  @override
  _MoveHomePageState createState() => _MoveHomePageState();
}

class _MoveHomePageState extends State<MoveHomePage> {
  int _secondsLeft = 60;
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _secondsLeft = 60;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isRunning = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Well done! You've completed a Move Minute!")),
        );
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _secondsLeft = 60;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Move Minute Reminder')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isRunning ? '$_secondsLeft seconds left' : 'Tap to start your Move Minute',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isRunning ? _stopTimer : _startTimer,
              child: Text(_isRunning ? 'Stop' : 'Start Move Minute'),
            ),
          ],
        ),
      ),
    );
  }
}

