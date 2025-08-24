import 'package:get/get.dart';

class InterestedClientsController extends GetxController {
  final RxList<Opportunity> opportunities = <Opportunity>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data
    opportunities.assignAll([
      Opportunity(
        id: "OP-2023-00125",
        propertyName: "برج الإمارات",
        unitName: "شقة 305 - الطابق الثالث",
        propertyLink: "https://example.com/property/123",
        clientName: "أحمد محمد السعدي",
        clientLink: "https://example.com/client/456",
      ),
      Opportunity(
        id: "OP-2023-00126",
        propertyName: "مجمع الرياض السكني",
        unitName: "فيلا 12 - قطعة 7",
        propertyLink: "https://example.com/property/124",
        clientName: "سارة عبدالله الفهد",
        clientLink: "https://example.com/client/457",
        isFollowed: true,
      ),
      Opportunity(
        id: "OP-2023-00127",
        propertyName: "مشروع النخيل",
        unitName: "متجر 45 - الطابق الأرضي",
        propertyLink: "https://example.com/property/125",
        clientName: "شركة التقنية المحدودة",
        clientLink: "https://example.com/client/458",
      ),
    ]);
  }

  void toggleFollow(int index) {
    final updatedOpportunity = opportunities[index].copyWith(
      isFollowed: !opportunities[index].isFollowed,
    );
    opportunities[index] = updatedOpportunity;

    Get.snackbar(
      updatedOpportunity.isFollowed
          ? 'تم تأكيد متابعة الفرصة'
          : 'تم إلغاء متابعة الفرصة',
      '',
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
    );

    // Here you would typically make API call to update the backend
  }

  void openLink(String url) {
    Get.snackbar(
      'سيتم فتح الرابط: $url',
      '',
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

class Opportunity {
  final String id;
  final String propertyName;
  final String unitName;
  final String propertyLink;
  final String clientName;
  final String clientLink;
  final bool isFollowed;

  Opportunity({
    required this.id,
    required this.propertyName,
    required this.unitName,
    required this.propertyLink,
    required this.clientName,
    required this.clientLink,
    this.isFollowed = false,
  });

  Opportunity copyWith({
    String? id,
    String? propertyName,
    String? unitName,
    String? propertyLink,
    String? clientName,
    String? clientLink,
    bool? isFollowed,
  }) {
    return Opportunity(
      id: id ?? this.id,
      propertyName: propertyName ?? this.propertyName,
      unitName: unitName ?? this.unitName,
      propertyLink: propertyLink ?? this.propertyLink,
      clientName: clientName ?? this.clientName,
      clientLink: clientLink ?? this.clientLink,
      isFollowed: isFollowed ?? this.isFollowed,
    );
  }
}
