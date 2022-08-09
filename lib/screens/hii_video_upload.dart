import 'package:flutter/material.dart';

late String videoPath;
//List<Measurement> measurements = getInfo();

class Measurement {
  late final String user;
}

// Future<List<Measurement>> getInfo() async {
//   const data = [
//     {
//       "user": "amornpan@gmail.com",
//       "code": "MUN017",
//       "name": "เมืองอุบลราชธานี",
//       "lat": "15.3276864",
//       "lng": "104.6817984",
//       "left_bank": 114.758,
//       "right_bank": 118.692,
//       "ground_level": 105.73,
//       "date": "2021-09-12",
//       "time": "00:00:00",
//       "water": 110.94,
//       "video_path": "",
//       "surface_velocity": 0.0,
//     },
//     {
//       "user": "amornpan@gmail.com",
//       "code": "SKM001",
//       "name": "อากาศอำนวย",
//       "lat": "17.7775936",
//       "lng": "104.0150464",
//       "left_bank": 142.857,
//       "right_bank": 144.219,
//       "ground_level": 131.865,
//       "date": "2021-09-12",
//       "time": "00:00:00",
//       "water": 141.93,
//       "video_path": "",
//       "surface_velocity": 0.0,
//     }
//   ];
//   return null;
//   //return data.map(<Meaturement>(Meaturement.fromJson)).toList();
// }

class VideoUpload extends StatefulWidget {
  const VideoUpload({Key? key}) : super(key: key);

  @override
  State<VideoUpload> createState() => _VideoUploadState();
}

class _VideoUploadState extends State<VideoUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Upload')),
    );
  }
}
