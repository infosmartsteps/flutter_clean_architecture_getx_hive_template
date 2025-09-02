import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../domain/entities/property_entity.dart';
import '../property_information_widget.dart';

Widget propertyListView(List<PropertyEntity> properties,
    {void Function()? onPressed}) {
  return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(12)),
      separatorBuilder: (context, index) => Gap(responsiveHeight(20)),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        final property = properties[index];
        return propertyInformationWidget(property,onPressed);
      });
}

