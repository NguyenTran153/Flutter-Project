import "package:flutter/material.dart";
import "package:flutter_project/screens/VideoCall/videoCallItems/camera_screen.dart";

class VideoCallToolBox extends StatefulWidget {
  const VideoCallToolBox({Key? key}) : super(key: key);

  @override
  State<VideoCallToolBox> createState() => _VideoCallToolBoxState();
}

class _VideoCallToolBoxState extends State<VideoCallToolBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: CameraScreen(),
        ),
        Positioned(
          bottom: 16.0, // Adjust the position as needed
          left: 16.0, // Adjust the position as needed
          child: IconButton(
            icon: const Icon(Icons.videocam), // You can use any icon you prefer
            onPressed: () {
              // Handle video call actions here
            },
          ),
        ),
      ],
    );
  }
}
