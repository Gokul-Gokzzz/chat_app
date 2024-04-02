// import 'package:auth/view/auth_screen/auth_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class WelcomeScreen extends StatefulWidget {
//   @override
//   _WelcomeScreenState createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<WelcomeScreen> {
//   late VideoPlayerController _controller;
//   bool _isVideoPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset('assets/your_video.mp4')
//       ..initialize().then((_) {
//         setState(() {
//           _controller.play();
//           _isVideoPlaying = true;
//         });
//       });
//     _controller.setLooping(true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           _isVideoPlaying
//               ? SizedBox.expand(
//                   child: FittedBox(
//                     fit: BoxFit.cover,
//                     child: SizedBox(
//                       width: _controller.value.size.width,
//                       height: _controller.value.size.height,
//                       child: VideoPlayer(_controller),
//                     ),
//                   ),
//                 )
//               : Container(),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   "Welcome",
//                   style: TextStyle(
//                     fontSize: 32.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => AuthPage()));
//                   },
//                   child: Text("Let's Start"),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }

import 'package:auth/view/auth_screen/auth_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/img_753409_2024_03_27_06_30_29.png',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 173, 62, 2),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AuthPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: "Let's ",
                          ),
                          TextSpan(
                            text: "Start",
                            style: TextStyle(
                              color: Colors.blue, // Change color here
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
