import 'package:flutter/material.dart';
import 'package:app/screens/Feedback.dart';
import 'package:app/shared/theme.dart';
import 'package:app/widgets/videos.dart';

import 'feedbackscreen.dart';

class ExercisePopup extends StatelessWidget {
  final String imagePath;
  final String exerciseName;
  final String Workoutlevel;

  const ExercisePopup({
    Key? key,
    required this.imagePath,
    required this.exerciseName,
    required this.Workoutlevel,
  }) : super(key: key);

  // Function to show AlertDialog with instructions
  void _showInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AltDlgColor,
          title: Text(
            "Recording Instructions",
            style: TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
          content: Text(
            "Please set the camera away from you from 1 to 2 meters\n\nAll of your body should be clearly seen in the video.",
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Navigate back when background is tapped
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/Popup_BG.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Container(
                height: 400,
                width: 325,
                decoration: BoxDecoration(
                  color: Colors.grey[800]?.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          // Background image
                          Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          // Info icon
                          Positioned(
                            top: 10.0,
                            right: 10.0,
                            child: IconButton(
                              onPressed: () {
                                _showInstructions(context);
                              },
                              icon: Icon(Icons.info),
                              color: inverseiconColor,
                            ),
                          ),
                          Positioned(
                            bottom: 20.0,
                            left: 20.0,
                            child: Text(
                              exerciseName,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2.0,
                                    color: inversetextColor,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                            onPressed: () async {
                              String? recordedVideoURL = await recordVideo(
                                context,
                                exerciseName: exerciseName,
                              );
                              if (recordedVideoURL != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Feedbacks(videoURL: recordedVideoURL,Workoutlevel:Workoutlevel, exerciseName: exerciseName,),
                                  ),
                                );
                              }
                            },
                            icon: Icon(Icons.play_arrow),
                            label: Text("Live"),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  inversetextColor),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(buttonColor),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 98)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0))),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              String? uploadedVideoURL = await uploadVideo(
                                context,
                                exerciseName: exerciseName,
                              );
                              if (uploadedVideoURL != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Feedbacks(videoURL: uploadedVideoURL,Workoutlevel:Workoutlevel, exerciseName: exerciseName,),
                                  ),
                                );
                              }
                            },
                            label: Text("Upload"),
                            icon: Icon(Icons.video_library_outlined),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  inversetextColor),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(buttonColor),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 90)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0))),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(textColor),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
