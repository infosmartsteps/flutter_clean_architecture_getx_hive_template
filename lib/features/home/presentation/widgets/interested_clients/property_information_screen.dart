import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/interested_clients_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/widgets/app_button.dart';
import 'map_widget.dart';

//lib/features/home/presentation/widgets/interested_clients/property_information_screen.dart
class PropertyInformationScreen extends GetView<InterestedClientsController> {
  const PropertyInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final opportunity = controller.opportunities.isNotEmpty
        ? controller.opportunities[0]
        : null;
    return Scaffold(
        appBar: AppBar(
          title: Text('property_information'.tr),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          foregroundColor: Theme.of(context).appBarTheme.iconTheme?.color,
        ),
        body: opportunity == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(responsiveFont(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Property Header
                    _buildHeader(
                      context,
                      title: opportunity.propertyName,
                      subtitle: opportunity.unitName,
                      icon: Icons.business,
                    ),

                    SizedBox(height: responsiveHeight(24)),

                    // Property Details Card
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(responsiveFont(16)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(responsiveFont(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                              icon: Icons.confirmation_number,
                              title: 'property_id'.tr,
                              value: opportunity.id,
                            ),
                            SizedBox(height: responsiveHeight(12)),
                            _buildDetailRow(
                              icon: Icons.home_work,
                              title: 'property_name'.tr,
                              value: opportunity.propertyName,
                            ),
                            SizedBox(height: responsiveHeight(12)),
                            _buildDetailRow(
                              icon: Icons.meeting_room,
                              title: 'unit_name'.tr,
                              value: opportunity.unitName,
                            ),
                            SizedBox(height: responsiveHeight(12)),
                            _buildDetailRow(
                              icon: Icons.link,
                              title: 'property_link'.tr,
                              value: opportunity.propertyLink,
                              isLink: true,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: responsiveHeight(24)),

                    // Map Section
                    Text(
                      'property_location'.tr,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: responsiveHeight(12)),
                    Container(
                      height: responsiveHeight(200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(responsiveFont(12)),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(responsiveFont(12)),
                        child: MapWidget(),
                      ),
                    ),

                    SizedBox(height: responsiveHeight(24)),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            onPressed: () {
                              controller.openNativeMap(
                                  31.986040, 35.879221, "Googleplex", context);
                            },
                            icon: Icon(Icons.map_outlined,
                                size: responsiveFont(20),
                                color: Theme.of(context).colorScheme.onPrimary),
                            text: 'open_in_maps'.tr,
                          ),
                        ),
                        SizedBox(width: responsiveWidth(12)),
                        Expanded(
                          child: AppButton(
                            onPressed: () {
                              controller.shareProperty(opportunity, context);
                            },
                            icon: Icon(Icons.share,
                                size: responsiveFont(20),
                                color: Theme.of(context).colorScheme.onPrimary),
                            text: 'share'.tr,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
  }

  Widget _buildHeader(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsiveFont(12)),
      ),
      child: Padding(
        padding: EdgeInsets.all(responsiveFont(16)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(responsiveFont(12)),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  color: Theme.of(context).primaryColor,
                  size: responsiveFont(24)),
            ),
            SizedBox(width: responsiveWidth(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: responsiveHeight(4)),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
    bool isLink = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: responsiveFont(18), color: Colors.grey[600]),
        SizedBox(width: responsiveWidth(12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: responsiveFont(12),
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: responsiveHeight(4)),
              isLink
                  ? InkWell(
                      onTap: () => launchUrl(Uri.parse(value)),
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: responsiveFont(14),
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  : Text(
                      value,
                      style: TextStyle(
                        fontSize: responsiveFont(14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
