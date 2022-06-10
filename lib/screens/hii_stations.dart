import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HiiStations extends StatefulWidget {
  const HiiStations({Key? key}) : super(key: key);

  @override
  State<HiiStations> createState() => _HiiStationsState();
}

class _HiiStationsState extends State<HiiStations> {
  late double screenWidth;
  late double screenHigh;

  Future<void> getDataWLNortheastLasted(
    String user,
    String pass,
  ) async {
    String url = "https://wea.hii.or.th:3005/getDataWLNortheastLasted";
    var uri = Uri.parse(url);

    Map<dynamic, dynamic> body = {'user': user, 'password': pass};

    debugPrint("User " + user + " password " + pass + " " + body.toString());

    final response = await http.post(uri,
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      debugPrint(response.body.toString());
      //return Login.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  // Future<void> getHiiData(user, pass) async {
  //   String url = "https://wea.hii.or.th:3005/getDataWLNortheastLasted";
  //   var uri = Uri.parse(url);
  //   Response response = await post(uri);
  //   var result = json.decode(response.body);
  //   debugPrint('result = $result');
  // }

  // Future<void> getHiiData(user, pass) async {
  //   String url = "https://wea.hii.or.th:3005/getDataWLNortheastLasted";
  //   //var header = "Content-Type": "application/x-www-form-urlencoded";
  //   var uri = Uri.parse(url);
  //   //Response response = await post(uri, headers: Map<String> header);
  //   var result = json.decode(response.body);
  //   debugPrint('result = $result');
  // }

  @override
  void initState() {
    getDataWLNortheastLasted('WLNortheast', 'ce0301505244265d13b8d53eb63126e1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHigh = MediaQuery.of(context).size.height;

    //Method
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'สถานีโทรมาตรวัดระดับน้ำ สสน.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        //backgroundColor: Colors.transparent,
        backgroundColor: Colors.blue.shade500,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              color: Colors.blue.shade500,
              child: const ClipPath(),
              height: screenHigh,
              width: screenWidth,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Hii Stations"),
                  SizedBox(height: 10),
                  Text("Hii Stations"),
                  SizedBox(height: 10),
                  Text("Hii Stations"),
                  SizedBox(height: 30),
                  // ElevatedButton(
                  //   onPressed: () => {
                  //      getDataWLNortheastLasted("WLNortheast", "ce0301505244265d13b8d53eb63126e1");
                  //   },
                  //   child: Text('Click me'),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TOP
    final Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.2017986);
    path0.quadraticBezierTo(size.width * 0.0516667, size.height * 0.1122302,
        size.width * 0.2188889, size.height * 0.1003597);
    path0.cubicTo(
        size.width * 0.3405556,
        size.height * 0.0974820,
        size.width * 0.6283333,
        size.height * 0.1330935,
        size.width * 0.7777778,
        size.height * 0.1320144);
    path0.quadraticBezierTo(size.width * 0.9111111, size.height * 0.1301295,
        size.width, size.height * 0.0848921);
    path0.lineTo(size.width, 0);

    // Bottom
    // path0.moveTo(0, size.height * 1.0007194);
    // path0.lineTo(0, size.height * 0.8820144);
    // path0.quadraticBezierTo(size.width * 0.1937556, size.height * 0.9706906,
    //     size.width * 0.3361111, size.height * 0.9690647);
    // path0.cubicTo(
    //     size.width * 0.4723556,
    //     size.height * 0.9600719,
    //     size.width * 0.6323556,
    //     size.height * 0.9025180,
    //     size.width * 0.7922222,
    //     size.height * 0.9043165);
    // path0.quadraticBezierTo(size.width * 0.8812444, size.height * 0.9070216,
    //     size.width, size.height * 0.9420863);
    // path0.lineTo(size.width, size.height * 1.0021583);

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
