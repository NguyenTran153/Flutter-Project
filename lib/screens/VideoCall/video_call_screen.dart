import "dart:async";

import "package:flutter/material.dart";

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key, required this.startTimestamp})
      : super(key: key);

  final int startTimestamp;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late Timer _timer;
  late Duration _currentTime;

  void _startTimer() {
    _currentTime = DateTime.fromMillisecondsSinceEpoch(widget.startTimestamp)
        .difference(DateTime.now());
    // _currentTime = Duration(
    //   days: difference.inDays,
    //   hours: difference.inHours,
    //   minutes: difference.inMinutes,
    //   seconds: difference.inSeconds,
    // );

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_currentTime.inSeconds == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _currentTime =
                DateTime.fromMillisecondsSinceEpoch(widget.startTimestamp)
                    .difference(DateTime.now());
          });
        }
      },
    );
  }

  String _convertWaitingTime() {
    final days = (_currentTime.inDays).toString().padLeft(2, '0');
    final hours = (_currentTime.inHours % (7)).toString().padLeft(2, '0');
    final minutes = (_currentTime.inMinutes % (24)).toString().padLeft(2, '0');
    final seconds = (_currentTime.inSeconds % (60)).toString().padLeft(2, '0');
    return '$days:$hours:$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Lesson is starting in\n${_convertWaitingTime()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.mic_rounded, color: Colors.white),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.video_call, color: Colors.white),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.comment, color: Colors.white),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.mobile_screen_share,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.front_hand, color: Colors.white),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.fullscreen_outlined,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.phone, color: Colors.red),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
