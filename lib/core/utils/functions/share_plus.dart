import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

Future<void> share({String? text}) async {
  final box = Get.context!.findRenderObject() as RenderBox?;
  await SharePlus.instance.share(ShareParams(
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    text: text,
  ));
}
