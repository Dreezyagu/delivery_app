import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/request_courier/services/request_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class SetDeliverySpeedProvider extends StateNotifier<BaseNotifier<String>> {
  SetDeliverySpeedProvider() : super(BaseNotifier());

  void setDeliverySpeed(
      {required String deliveryId,
      required String mode,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await RequestServices.setDeliverySpeed(deliveryId, mode);
    if (data.success is String) {
      state = BaseNotifier.setDone<String>(data.success!);
      if (onSuccess != null) {
        onSuccess();
      }
    } else {
      state = BaseNotifier.setError(data.error ?? "An error ocurred");
      if (onError != null) {
        onError(data.error ?? "An error ocurred");
      }
    }
  }
}

final setDeliverySpeedProvider =
    StateNotifierProvider<SetDeliverySpeedProvider, BaseNotifier<String>>(
        (ref) {
  return SetDeliverySpeedProvider();
});
