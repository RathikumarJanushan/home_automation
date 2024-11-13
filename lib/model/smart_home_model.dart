import 'package:flutter/material.dart';

class SmartHomeModel {
  String roomName;
  String roomImage;
  String roomTemperature;
  int userAccess;
  bool roomStatus;
  List<DeviceInRoom>? devices;
  SmartHomeModel({
    required this.roomName,
    required this.roomImage,
    required this.roomTemperature,
    required this.userAccess,
    this.roomStatus = false,
    this.devices,
  });
}

class DeviceInRoom {
  String deviceName;
  IconData iconOn;
  IconData iconOff;
  bool deviceStatus;
  DeviceInRoom({
    required this.deviceName,
    required this.iconOn,
    required this.iconOff,
    this.deviceStatus = false,
  });
}

List<SmartHomeModel> smartHomeData = [
  SmartHomeModel(
    roomName: "Living Room",
    roomImage: "assets/images/living_room.jpg",
    roomTemperature: "25°",
    userAccess: 4,
    roomStatus: true,
    devices: [
      DeviceInRoom(
        deviceName: "Light",
        iconOn: Icons.lightbulb_rounded,
        iconOff: Icons.lightbulb_outline_rounded,
        deviceStatus: true,
      ),
      DeviceInRoom(
        deviceName: "Fan",
        iconOn: Icons.air,
        iconOff: Icons.mode_fan_off_outlined,
        deviceStatus: true,
      ),
      DeviceInRoom(
        deviceName: "Plug Point",
        iconOn: Icons.speaker_outlined,
        iconOff: Icons.volume_off_outlined,
        deviceStatus: false,
      ),
    ],
  ),
];
