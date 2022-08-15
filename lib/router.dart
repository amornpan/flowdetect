import 'package:flowdetect/screens/hii_stations.dart';
import 'package:flowdetect/screens/hii_video_upload.dart';
import 'package:flowdetect/stages/other_river.dart';
import 'package:flowdetect/stages/admin_service.dart';
import 'package:flowdetect/stages/authen.dart';
import 'package:flowdetect/stages/newaccount.dart';
import 'package:flowdetect/stages/user_service.dart';
import 'package:flutter/material.dart';

import 'screens/hii_particle_select_size.dart';
import 'screens/hii_stations_map.dart';
import 'screens/hii_stations_select_site.dart';

final Map<String, WidgetBuilder> map = {
  '/authen':(BuildContext context)=>const Authen(),
  '/newAccount':(BuildContext context) => const NewAccount(),
  '/adminService':(BuildContext context) => const AdminService(),
  '/userService':(BuildContext context) => const UserService(),
  '/hiiStation': (BuildContext context) => const HiiStations(),
  '/otherRiver': (BuildContext context) => const OtherRiver(),
  '/hiiStatSelectSite': (BuildContext context) => const HiiStatSelectSite(),
  '/hiiStationMap': (BuildContext context) => const HiiStationMap(),
  '/particleSizeSelect': (BuildContext context) => const ParticleSizeSelect(),
  '/videoUpload': (BuildContext context) => const VideoUpload(),
};
