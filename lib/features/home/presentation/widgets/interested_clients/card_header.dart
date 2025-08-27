import 'package:flutter/material.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../domain/entities/opportunity_entity.dart';
import '../../controllers/interested_clients_controller.dart';

Widget cardHeader(
    {required BuildContext context,
    required InterestedClientsController controller,
    required int index,
    required OpportunityEntity opportunity}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(opportunity.id,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.primary)),
      IconButton(
        onPressed: () => controller.toggleFollow(index),
        icon: Icon(
          opportunity.isFollowed ? Icons.check_circle : Icons.add_circle,
          color: opportunity.isFollowed ? Colors.green : Colors.blue,
          size: responsiveFont(30),
        ),
      ),
    ],
  );
}
