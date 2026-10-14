import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'colors.dart';

void customLoader() => BotToast.showCustomLoading(
  toastBuilder: (cancelFunc) => Container(
    height: 75,
    width: 75,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: const SpinKitDualRing(
      color: AppColors.secondaryColor,
      size: 40, 
    ),
  ),
  crossPage: true,
  align: Alignment.center,
);
