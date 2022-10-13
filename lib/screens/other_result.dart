import 'package:flutter/material.dart';

import '../utility/main_style.dart';

// double? distance;
// double? averageVelocity;
// double? flowrate;

class OtherResult extends StatefulWidget {
  final int? postgresids;
  final double? surfaceVelocitys;
  final double? averageVelocitys;
  final double? flowrates;
  final double? aValues;
  const OtherResult({
    Key? key,
    this.postgresids,
    this.surfaceVelocitys,
    this.averageVelocitys,
    this.flowrates,
    this.aValues,
  }) : super(key: key);

  @override
  State<OtherResult> createState() => _OtherResultState();
}

class _OtherResultState extends State<OtherResult> {
  int? postgresIntid;
  String? urlVideo;
  double? surfaceVelocity;
  double? averageVelocity;
  double? flowrate;

  double getNumber(double input, {int precision = 2}) {
    return double.parse(
        '$input'.substring(0, '$input'.indexOf('.') + precision + 1));
  }

  double? aValue;

  @override
  void initState() {
    super.initState();
    postgresIntid = widget.postgresids;
    surfaceVelocity = widget.surfaceVelocitys;
    averageVelocity = widget.averageVelocitys;
    flowrate = widget.flowrates;
    aValue = widget.aValues;
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
                        surfaceVelocity == null || surfaceVelocity == 0.0
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
                        averageVelocity == null || averageVelocity == 0.0
                            ? MainStyle().showProgressBar()
                            : Text(
                                '${getNumber(averageVelocity!)} m/s',
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
                        flowrate == null || flowrate == 0.0
                            ? MainStyle().showProgressBar()
                            : Text(
                                '${getNumber(flowrate!)} cms',
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
