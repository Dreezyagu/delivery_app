import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/orders/models/delivery_model.dart';
import 'package:ojembaa_mobile/features/orders/services/orders_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class GetOrdersProvider
    extends StateNotifier<BaseNotifier<List<DeliveryModel>>> {
  GetOrdersProvider() : super(BaseNotifier());

  void getOrders({VoidCallback? onSuccess, Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await OrdersServices.getOrders();
    if (data.success is List<DeliveryModel>) {
      data.success?.removeWhere((element) => element.courier == null);
      final datum = data.success?.reversed.toList();
      state = BaseNotifier.setDone<List<DeliveryModel>>(datum!);
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

final getOrdersProvider =
    StateNotifierProvider<GetOrdersProvider, BaseNotifier<List<DeliveryModel>>>(
        (ref) {
  return GetOrdersProvider();
});
