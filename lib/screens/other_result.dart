import 'package:flutter/material.dart';

import '../utility/main_style.dart';

double? distance;
double? averageVelocity;
double? flowrate;

class OtherResult extends StatefulWidget {
  final int? postgresids;
  final double? surfaceVelocitys;
 const OtherResult({Key? key, this.postgresids, this.surfaceVelocitys})
      : super(key: key);

  @override
  State<OtherResult> createState() => _OtherResultState();
}

class _OtherResultState extends State<OtherResult> {

  int? postgresIntid;
  String? urlVideo;
  double? surfaceVelocity;

  double getNumber(double input, {int precision = 2}) {
    return double.parse(
        '$input'.substring(0, '$input'.indexOf('.') + precision + 1));
  }

  @override
  void initState() {
    super.initState();
     postgresIntid = widget.postgresids;
    surfaceVelocity = widget.surfaceVelocitys;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/userService', (route) => false);
              },
              icon: const Icon(Icons.home))
        ],
        title: const Text('Display Output'),
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
                    fontSize: 30.0,
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
                      children: [
                        const Text(
                          'ความเร็วบนผิวน้ำ : ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0064b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        surfaceVelocity == null
                            ? MainStyle().showProgressBar()
                            : Text(
                                '${getNumber(surfaceVelocity!)} m/s',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xff0064b7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ความเร็วหน้าตัด : ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0064b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        averageVelocity == null
                            ? MainStyle().showProgressBar()
                            : Text(
                                '$averageVelocity m/s',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xff0064b7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'อัตราการไหล : ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0064b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        flowrate == null
                            ? MainStyle().showProgressBar()
                            : Text(
                                '$flowrate m^3/s',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xff0064b7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/userService', (route) => false);
                  },
                  child: const Text(
                    'กลับหน้าหลัก',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),

         
              ],
            ),
          ),
        ),
      ),
    );
  }
}