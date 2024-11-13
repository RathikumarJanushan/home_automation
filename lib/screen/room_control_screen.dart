import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_automation/constants/app_colors.dart';
import 'package:home_automation/model/smart_home_model.dart';
import 'package:home_automation/screen/widgets/device_switch.dart';
import 'package:home_automation/screen/widgets/glass_morphism.dart';

class RoomControlScreen extends StatefulWidget {
  const RoomControlScreen({super.key, required this.roomData});
  final SmartHomeModel roomData;

  @override
  State<RoomControlScreen> createState() => _RoomControlScreenState();
}

class _RoomControlScreenState extends State<RoomControlScreen> {
  @override
  Widget build(BuildContext context) {
    final SmartHomeModel roomData = this.widget.roomData;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(roomData.roomImage), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 183, 125, 47)
                              .withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomCard(size, roomData),
          ],
        ),
      ),
    );
  }

  Widget bottomCard(Size size, SmartHomeModel roomData) {
    return GlassMorphism(
      child: Container(
        width: double.infinity,
        height: size.height * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    roomData.roomName,
                    style: const TextStyle(
                      color: AppColor.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: AppColor.white.withOpacity(0.5),
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Devices',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: AppColor.white,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.22,
              child: ListView.builder(
                itemCount: roomData.devices!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final data = roomData.devices![index];
                  return DeviceSwitch(
                      data: data, controlId: 'Control ${index + 1}');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
