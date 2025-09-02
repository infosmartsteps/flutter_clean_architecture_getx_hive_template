import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/features/home/domain/entities/client_entity.dart';
import '../client_information_widget.dart';


Widget clientsListView(List<ClientEntity> clients) {
  return ListView.separated(
    separatorBuilder: (context, index) => Gap(responsiveHeight(10)),
    itemCount: clients.length,
    itemBuilder: (context, index) {
      final client = clients[index];
      return clientInformationWidget(client);
    },
  );
}