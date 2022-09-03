import 'package:flutter/material.dart';

class HiiStationVideoSetting extends StatefulWidget {
  final int? postgresids;
  const HiiStationVideoSetting({Key? key, this.postgresids}) : super(key: key);

  @override
  State<HiiStationVideoSetting> createState() => _HiiStationVideoSettingState();
}

class _HiiStationVideoSettingState extends State<HiiStationVideoSetting> {
  int? postgresIntid;

  @override
  void initState() {
    super.initState();
    postgresIntid = widget.postgresids;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.swipe_left_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/userService', (route) => false);
            },
            icon: const Icon(Icons.home),
          ),
        ],
        title: const Text('Setting'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ผลลัพธ์การคำนวน',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xff0064b7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'ระยะทาง : ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0064b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('คำนวณค่าระยะทาง'),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'ความเร็วบนผิวน้ำ : ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0064b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'ความเร็วหน้าตัด : ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0064b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'อัตราการไหล : ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0064b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
