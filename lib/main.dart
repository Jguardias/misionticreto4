import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reto4/controller/controladorGeneral.dart';
import 'package:reto4/screen/home.dart';

void main() {
  Get.put(controladorGeneral());
  runApp(const MyApp());
}

