import 'package:ads_app/core/enums/operation_type_enum.dart';
import 'package:ads_app/core/enums/request_status_enum.dart';
import 'package:ads_app/shared_widgets/custom_loader.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final rxRequestStatus = RequestStatus.none.obs;
  void setRxRequestStatus(RequestStatus _value) =>
      rxRequestStatus.value = _value;

  final rxOperationType = OperationType.none.obs;
  void setRxOperationType(OperationType _value) =>
      rxOperationType.value = _value;

  bool get isLoading =>
      rxRequestStatus == RequestStatus.loading &&
      rxOperationType == OperationType.none;

  Future runFutureFunction({required Future function}) async {
    await function;
  }

  Future runFutureFunctionWithLoading({
    required Future function,
    OperationType type = OperationType.none,
  }) async {
    setRxRequestStatus(RequestStatus.loading);
    setRxOperationType(type);

    await function;
    setRxRequestStatus(RequestStatus.sucsess);
    setRxOperationType(OperationType.none);
  }

  Future runFutureFunctionWithFullLoading({
    required Future function,
    OperationType? operationType = OperationType.none,
  }) async {
    customLoader();
    await function;
    BotToast.closeAllLoading();
    
  }
}
