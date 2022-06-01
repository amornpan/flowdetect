import 'package:flowdetect/stages/admin_service.dart';
import 'package:flowdetect/stages/authen.dart';
import 'package:flowdetect/stages/newaccount.dart';
import 'package:flowdetect/stages/user_service.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> map = {
  '/authen':(BuildContext context)=>const Authen(),
  '/newAccount':(BuildContext context) => const NewAccount(),
  '/adminService':(BuildContext context) => const AdminService(),
  '/userService':(BuildContext context) => const UserService(),
};
