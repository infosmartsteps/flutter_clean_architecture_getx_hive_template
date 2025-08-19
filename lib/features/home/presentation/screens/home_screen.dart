import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_build_body.dart';
import '../widgets/home_build_drawer.dart';

//lib/features/home/presentation/screens/home_screen.dart
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      drawer: homeBuildDrawer(context, controller),
      body: homeBuildBody(context),
    );
  }
}