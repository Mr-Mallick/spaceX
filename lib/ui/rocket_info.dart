// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:spacex/common/commom_loader.dart';
import 'package:spacex/common/image_carousel.dart';
import 'package:spacex/controllers/rocket_info_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class RocketInfoScreen extends StatefulWidget {
  final String id;
  const RocketInfoScreen({super.key, required this.id});

  @override
  State<RocketInfoScreen> createState() => _RocketInfoScreenState();
}

class _RocketInfoScreenState extends State<RocketInfoScreen> {
  RocketInfoController c = Get.put(RocketInfoController());

  @override
  void initState() {
    c.getData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Obx(
          () => Text(
            c.name.value,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Obx(
        () => c.isLoading.value
            ? CommonLoader()
            : Container(
                margin: EdgeInsets.all(20),
                child: ListView(
                  children: [
                    ImageCarouselWidget(l: c.images),
                    Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                    sbox(5),
                    Text(
                      c.desc.value,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                    sbox(5),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                          text: "Active Status: ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                        ),
                        TextSpan(
                          text: c.activeStatus.value,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        )
                      ]),
                    ),
                    sbox(5),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                          text: "Cost Per Launch: ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        TextSpan(
                          text: c.cpl.value,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        )
                      ]),
                    ),
                    sbox(5),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                          text: "Success: ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        TextSpan(
                          text: "${c.sucessPercentage.value} %",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        )
                      ]),
                    ),
                    sbox(5),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                          text: "Height In Meter: ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        TextSpan(
                          text: c.heightInM.value,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        )
                      ]),
                    ),
                    sbox(5),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                          text: "Height In Feet: ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        TextSpan(
                          text: c.heightInFeet.value,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        )
                      ]),
                    ),
                    sbox(5),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                          text: "Diameter In Meter: ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        TextSpan(
                          text: c.diameterInM.value,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        )
                      ]),
                    ),
                    sbox(5),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                          text: "Diameter In Feet: ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        TextSpan(
                          text: c.diameterInFeet.value,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        )
                      ]),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                    sbox(5),
                    ElevatedButton(
                        onPressed: () async {
                          var url = c.url.value;
                          if (!await launchUrl(
                            Uri.parse(url),
                            mode: LaunchMode.externalApplication,
                          )) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Text("Read More on Wiki")),
                    sbox(25),
                  ],
                ),
              ),
      ),
    );
  }

  Widget sbox(double h) {
    return SizedBox(
      height: h,
    );
  }
}
