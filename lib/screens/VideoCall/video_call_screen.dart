import "package:flutter/material.dart";


class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Lesson is starting in 1000s",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          const Row(
            children: [
              Expanded(child: Icon(Icons.mic_rounded, color: Colors.white,)),
              Expanded(child: Icon(Icons.video_call, color: Colors.white,)),
              Expanded(child: Icon(Icons.comment, color: Colors.white,)),
              Expanded(child: Icon(Icons.mobile_screen_share, color: Colors.white,)),
              Expanded(child: Icon(Icons.front_hand, color: Colors.white,)),
              Expanded(child: Icon(Icons.fullscreen_outlined, color: Colors.white,)),
              Expanded(child: Icon(Icons.phone, color: Colors.red,)),
            ],
          )
        ],
      ),
    );
  }
}
