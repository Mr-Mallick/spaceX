import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacex/common/commom_loader.dart';
import 'package:spacex/common/photo_hero.dart';
import 'package:spacex/controllers/homepage_controller.dart';
import 'package:spacex/ui/rocket_info.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HomePageController controller = Get.put(HomePageController());

  @override
  void initState() {
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Homepage',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() => controller.isLoading.value
          ? const CommonLoader()
          : Container(
              color: Colors.black,
              margin: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: controller.rocketList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.rocketList[index].name
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        const TextSpan(
                                          text: "Country:",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        TextSpan(
                                          text: controller
                                              .rocketList[index].country
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        )
                                      ]),
                                    ),
                                    RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        const TextSpan(
                                          text: "Engine Count:",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        TextSpan(
                                          text: controller
                                              .rocketList[index].engines!.number
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightBlue[200]),
                                  onPressed: () {
                                    Get.to(() => RocketInfoScreen(
                                        id: controller.rocketList[index].id
                                            .toString()));
                                  },
                                  child: const Text(
                                    "View Details",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller
                                .rocketList[index].flickrImages!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => PhotoHero(
                                      photo: controller
                                          .rocketList[index].flickrImages![i]
                                          .toString(),
                                      onTap: () {
                                        Get.back();
                                      },
                                      width: Get.width));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Image.network(
                                    controller
                                        .rocketList[index].flickrImages![i]
                                        .toString(),
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )),
    );
  }
}
