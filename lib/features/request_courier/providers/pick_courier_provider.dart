import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/request_courier/models/couriers_model.dart';
import 'package:ojembaa_mobile/features/request_courier/services/request_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class PickCourierProvider extends StateNotifier<BaseNotifier<String>> {
  PickCourierProvider() : super(BaseNotifier());

  void pickCourier(
      {required String deliveryId,
      required String courierId,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await RequestServices.pickCourier(deliveryId, courierId);
    if (data.success is List<CouriersModel>) {
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

final pickCourierProvider =
    StateNotifierProvider<PickCourierProvider, BaseNotifier<String>>((ref) {
  return PickCourierProvider();
});
