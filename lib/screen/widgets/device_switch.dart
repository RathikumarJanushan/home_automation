import 'package:flutter/material.dart';
import 'package:home_automation/constants/app_colors.dart';
import 'package:home_automation/model/smart_home_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceSwitch extends StatefulWidget {
  const DeviceSwitch({super.key, required this.data, required this.controlId});
  final DeviceInRoom data;
  final String
      controlId; // Pass the control ID (e.g., Control 1, Control 2, Control 3)

  @override
  State<DeviceSwitch> createState() => _DeviceSwitchState();
}

class _DeviceSwitchState extends State<DeviceSwitch> {
  final Duration _duration = Duration(milliseconds: 300);

  void _updateDeviceStateInFirestore(bool status) async {
    final controlId = widget.controlId;

    try {
      await FirebaseFirestore.instance
          .collection('esp')
          .doc(controlId)
          .update({'state': status});
    } catch (e) {
      print("Failed to update Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DeviceInRoom data = this.widget.data;

    return GestureDetector(
      onTap: () {
        setState(() {
          data.deviceStatus = !data.deviceStatus;
        });
        _updateDeviceStateInFirestore(data.deviceStatus); // Update Firestore
      },
      child: Container(
        width: size.width * 0.22,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColor.white.withOpacity(.3),
            borderRadius: BorderRadius.circular(60)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              top: !data.deviceStatus ? 0 : -size.height * 0.22 / 2,
              duration: _duration,
              child: Column(
                children: [
                  _deviceStatus(data),
                  _deviceName(size, data),
                ],
              ),
            ),
            AnimatedPositioned(
              bottom: data.deviceStatus ? 0 : -size.height * 0.22 / 2,
              duration: _duration,
              child: Column(
                children: [
                  _deviceName(size, data),
                  _deviceStatus(data),
                ],
              ),
            ),
            AnimatedPositioned(
              top: data.deviceStatus ? 0 : (size.height * 0.22 / 2) + 10,
              duration: _duration,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.black.withOpacity(.2),
                        blurRadius: 20,
                      ),
                    ]),
                child: Icon(
                  data.deviceStatus ? data.iconOn : data.iconOff,
                  color: AppColor.fgColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _deviceName(Size size, DeviceInRoom data) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: size.width * 0.22 - 16,
      child: Text(
        data.deviceName,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: const TextStyle(
          color: AppColor.white,
          overflow: TextOverflow.ellipsis,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.2,
        ),
      ),
    );
  }

  Padding _deviceStatus(DeviceInRoom data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        data.deviceStatus ? "On" : "Off",
        style: const TextStyle(
          color: AppColor.white,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
