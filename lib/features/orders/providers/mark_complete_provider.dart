import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/orders/services/orders_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class MarkCompleteProvider extends StateNotifier<BaseNotifier<String>> {
  MarkCompleteProvider() : super(BaseNotifier());

  void markComplete(
      {required String deliveryId,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await OrdersServices.markComplete(deliveryId);
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

final markCompleteProvider =
    StateNotifierProvider<MarkCompleteProvider, BaseNotifier<String>>((ref) {
  return MarkCompleteProvider();
});
