import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/gen/colors.gen.dart';

class BudgetEntity {
  final int? id;
  final int idCategory;
  final String? categoryName;
  final String? priceCategory;
  final String price;
  final bool? isNotice;
  final DateTime? dateTime;

  SvgPicture get iconAsset{
    if (idCategory == 1) {
      return Assets.images.icons.bagshopping
          .svg(width: 18.w, height: 18.h);
    } else if (idCategory == 2) {
      return Assets.images.icons.subscriptions
          .svg(width: 18.w, height: 18.h);
    } else if (idCategory == 3) {
      return Assets.images.icons.car
          .svg(width: 18.w, height: 18.h);
    } else if (idCategory == 5) {
      return Assets.images.icons.restaurant
          .svg(width: 18.w, height: 18.h);
    } else {
      return Assets.images.icons.transaction
          .svg(width: 18.w, height: 18.h);
    }
  }

  Color get circleCategory{
    if (idCategory == 1) {
      return ColorName.yellow;
    } else if (idCategory == 2) {
      return ColorName.purple;
    } else if (idCategory == 3) {
      return ColorName.blue;
    } else if (idCategory == 5) {
      return ColorName.red;
    } else {
      return ColorName.purple;
    }
  }

  Color get backgroundColor{
    if (idCategory == 1) {
      return ColorName.bacgroundYellow;
    } else if (idCategory == 2) {
      return ColorName.whitePurple;
    } else if (idCategory == 3) {
      return ColorName.bacgroundBlueIcon;
    } else if (idCategory == 5) {
      return ColorName.bacgroundRedIcon;
    } else {
      return ColorName.whitePurple;
    }
  }

  int get totalRemain {
    final remain = int.parse(price ?? "0") - int.parse(priceCategory ?? "0");
    if (remain < 0){
      return 0;
    } else {
      return remain;
    }
  }

  bool get exceedLimit {
    return (int.parse(priceCategory ?? "0") > int.parse(price ?? "0"));
  }

  double get totalPersentase{
    final total = ((int.parse(priceCategory ?? "0") / int.parse(price ?? "0")));
    if (total > 1.0) {
      return 1.0;
    } else {
      return total;
    }
  }

  double get textPersent{
    final total = ((int.parse(priceCategory ?? "0") / int.parse(price ?? "0")) * 100);
    if (total > 100){
      return 100;
    } else {
      return total.floorToDouble();
    }
  }

  BudgetEntity(
      {this.id,
        required this.idCategory,
      this.categoryName,
      this.priceCategory,
      required this.price,
      this.isNotice = false,
      required this.dateTime});

  BudgetEntity copyWith({
    int? id,
    int? idCategory,
    String? categoryName,
    String? priceCategory,
    String? price,
    bool? isNotice,
    DateTime? dateTime,
  }) {
    return BudgetEntity(
        id: id ?? this.id,
        idCategory: idCategory ?? this.idCategory,
        categoryName: categoryName ?? this.categoryName,
        priceCategory: priceCategory ?? this.priceCategory,
        price: price ?? this.price,
        isNotice: isNotice ?? this.isNotice,
        dateTime: dateTime ?? this.dateTime);
  }
}
