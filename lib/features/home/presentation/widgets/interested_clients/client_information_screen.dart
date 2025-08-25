import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/interested_clients_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/utils/responsive_size_helper.dart';

//lib/features/home/presentation/widgets/interested_clients/client_information_screen.dart
class ClientInformationScreen extends GetView<InterestedClientsController> {
  const ClientInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final opportunity = controller.opportunities.isNotEmpty
        ? controller.opportunities[0]
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('client_information'.tr),
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
                  // Client Header
                  _buildHeader(
                    context,
                    title: opportunity.clientName,
                    subtitle: 'potential_client'.tr,
                    icon: Icons.person,
                  ),
                  SizedBox(height: responsiveHeight(24)),
                  // Client Details Card
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
                            icon: Icons.person_outline,
                            title: 'client_name'.tr,
                            value: opportunity.clientName,
                          ),
                          SizedBox(height: responsiveHeight(12)),
                          _buildDetailRow(
                            icon: Icons.phone,
                            title: 'phone_number'.tr,
                            value: '+966 55 123 4567',
                          ),
                          SizedBox(height: responsiveHeight(12)),
                          _buildDetailRow(
                            icon: Icons.email,
                            title: 'email'.tr,
                            value: 'client@example.com',
                          ),
                          SizedBox(height: responsiveHeight(12)),
                          _buildDetailRow(
                            icon: Icons.business,
                            title: 'company'.tr,
                            value: 'شركة التقنية المحدودة',
                          ),
                          SizedBox(height: responsiveHeight(12)),
                          _buildDetailRow(
                            icon: Icons.link,
                            title: 'client_link'.tr,
                            value: opportunity.clientLink,
                            isLink: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: responsiveHeight(24)),
                  // Client Location Section
                  Text(
                    'client_location'.tr,
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
                      child: _buildMapPreview(),
                    ),
                  ),
                  SizedBox(height: responsiveHeight(24)),
                  // Interaction History
                  Text(
                    'interaction_history'.tr,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: responsiveHeight(12)),
                  _buildInteractionHistory(),
                  SizedBox(height: responsiveHeight(24)),
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Call client
                            _callClient();
                          },
                          icon: Icon(Icons.phone, size: responsiveFont(20)),
                          label: Text('call'.tr),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: responsiveHeight(16)),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: responsiveWidth(12)),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Email client
                            _emailClient();
                          },
                          icon: Icon(Icons.email, size: responsiveFont(20)),
                          label: Text('email'.tr),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: responsiveHeight(16)),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
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
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: responsiveFont(10),
                left: responsiveFont(10),
                right: responsiveFont(10)),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: responsiveWidth(12),
                    vertical: responsiveHeight(6)),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(responsiveFont(16)),
                ),
                child: Text(
                  '${'hot_lead'.tr}🔥',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: responsiveFont(12),
                  ),
                ),
              ),
            ),
          ),
          Padding(
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
        ],
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

  Widget _buildMapPreview() {
    // This would be replaced with actual map implementation
    return Stack(
      children: [
        Container(
          color: Colors.blue[50],
          child: Center(
            child: Icon(Icons.map,
                size: responsiveFont(48), color: Colors.blue[300]),
          ),
        ),
        Positioned(
          top: responsiveHeight(16),
          right: responsiveWidth(16),
          child: Container(
            padding: EdgeInsets.all(responsiveFont(8)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(responsiveFont(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: responsiveFont(4),
                ),
              ],
            ),
            child: Icon(Icons.location_on,
                color: Colors.red, size: responsiveFont(24)),
          ),
        ),
      ],
    );
  }

  Widget _buildInteractionHistory() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsiveFont(12)),
      ),
      child: Padding(
        padding: EdgeInsets.all(responsiveFont(16)),
        child: Column(
          children: [
            _buildHistoryItem(
              icon: Icons.phone,
              title: 'outgoing_call'.tr,
              subtitle: 'duration_5min'.tr,
              time: '2_hours_ago'.tr,
              color: Colors.green,
            ),
            Divider(height: responsiveHeight(20)),
            _buildHistoryItem(
              icon: Icons.email,
              title: 'email_sent'.tr,
              subtitle: 'property_details'.tr,
              time: '1_day_ago'.tr,
              color: Colors.blue,
            ),
            Divider(height: responsiveHeight(20)),
            _buildHistoryItem(
              icon: Icons.notes,
              title: 'note_added'.tr,
              subtitle: 'interested_in_3bhk'.tr,
              time: '2_days_ago'.tr,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(responsiveFont(8)),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: responsiveFont(18), color: color),
        ),
        SizedBox(width: responsiveWidth(12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: responsiveFont(14),
                ),
              ),
              SizedBox(height: responsiveHeight(4)),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: responsiveFont(12),
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: responsiveFont(12),
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  void _callClient() {
    // Implementation for calling client
    Get.snackbar(
      'calling'.tr,
      'connecting_to_client'.tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _emailClient() {
    // Implementation for emailing client
    Get.snackbar(
      'emailing'.tr,
      'opening_email_client'.tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
