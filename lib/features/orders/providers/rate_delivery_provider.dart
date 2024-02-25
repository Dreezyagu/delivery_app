import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/orders/services/orders_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class RateDeliveryProvider extends StateNotifier<BaseNotifier<String>> {
  RateDeliveryProvider() : super(BaseNotifier());

  void rateDelivery(
      {required String deliveryId,
      required String feedback,
      required int rating,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data =
        await OrdersServices.rateDelivery(deliveryId, feedback, rating);
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

final rateDeliveryProvider =
    StateNotifierProvider<RateDeliveryProvider, BaseNotifier<String>>((ref) {
  return RateDeliveryProvider();
});
