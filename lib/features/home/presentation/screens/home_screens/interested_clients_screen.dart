import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/interested_clients_controller.dart';

class InterestedClientsScreen extends GetView<InterestedClientsController> {
  const InterestedClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فرص العقارات'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.opportunities.length,
        itemBuilder: (context, index) {
          return OpportunityCard(index: index);
        },
      )),
    );
  }
}

class OpportunityCard extends GetView<InterestedClientsController> {
  final int index;

  const OpportunityCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final opportunity = controller.opportunities[index];

      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with ID and follow button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    opportunity.id,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.toggleFollow(index),
                    icon: Icon(
                      opportunity.isFollowed
                          ? Icons.circle_outlined
                          : Icons.add_circle,
                      color: opportunity.isFollowed ? Colors.green : Colors.blue,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Property Information
              _buildInfoRow(
                icon: Icons.home,
                title: 'اسم العقار:',
                value: opportunity.propertyName,
              ),

              const SizedBox(height: 12),

              _buildInfoRow(
                icon: Icons.house,
                title: 'اسم القطعة العقارية:',
                value: opportunity.unitName,
              ),

              const SizedBox(height: 12),

              // Property Link
              InkWell(
                onTap: () => controller.openLink(opportunity.propertyLink),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.link, size: 20, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'رابط بيانات العقار',
                        style: TextStyle(
                          color: Colors.blue[700],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(height: 24),

              // Client Information
              _buildInfoRow(
                icon: Icons.verified_user,
                title: 'العميل:',
                value: opportunity.clientName,
              ),

              const SizedBox(height: 12),

              // Client Link
              InkWell(
                onTap: () => controller.openLink(opportunity.clientLink),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.link, size: 20, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'رابط بيانات العميل',
                        style: TextStyle(
                          color: Colors.blue[700],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Follow status indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: opportunity.isFollowed
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      opportunity.isFollowed
                          ? Icons.circle
                          : Icons.watch_later,
                      size: 16,
                      color: opportunity.isFollowed ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      opportunity.isFollowed ? 'قيد المتابعة' : 'يتطلب المتابعة',
                      style: TextStyle(
                        color: opportunity.isFollowed ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: '$title ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}