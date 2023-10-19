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
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: CameraScreen(),
        )
      ],
    );
  }
}
