import "package:flutter/material.dart";
import "package:flutter_project/screens/VideoCall/videoCallItems/camera_screen.dart";
import "package:flutter_project/utils/colors.dart";

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Lesson is starting in 1000s",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: primaryColor),
              ),
            ),
          ),
          Row(
            children: const [
              Expanded(child: Icon(Icons.mic_rounded, color: primaryColor,)),
              Expanded(child: Icon(Icons.video_call, color: primaryColor,)),
              Expanded(child: Icon(Icons.comment, color: primaryColor,)),
              Expanded(child: Icon(Icons.mobile_screen_share, color: primaryColor,)),
              Expanded(child: Icon(Icons.front_hand, color: primaryColor,)),
              Expanded(child: Icon(Icons.fullscreen_outlined, color: primaryColor,)),
              Expanded(child: Icon(Icons.phone, color: dangerColor,)),
            ],
          )
        ],
      ),
    );
  }
}
