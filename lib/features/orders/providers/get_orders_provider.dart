import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/orders/models/delivery_model.dart';
import 'package:ojembaa_mobile/features/orders/services/orders_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class GetOrdersProvider
    extends StateNotifier<BaseNotifier<List<DeliveryModel>>> {
  GetOrdersProvider() : super(BaseNotifier());

  Future<bool> getOrders(
      {VoidCallback? onSuccess, Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await OrdersServices.getOrders();
    if (data.success is List<DeliveryModel>) {
      data.success?.removeWhere((element) => element.courier == null);
      state = BaseNotifier.setDone<List<DeliveryModel>>(data.success!);
      if (onSuccess != null) {
        onSuccess();
      }
      return true;
    } else {
      state = BaseNotifier.setError(data.error ?? "An error ocurred");
      if (onError != null) {
        onError(data.error ?? "An error ocurred");
      }
      return false;
    }
  }
}

final getOrdersProvider =
    StateNotifierProvider<GetOrdersProvider, BaseNotifier<List<DeliveryModel>>>(
        (ref) {
  return GetOrdersProvider();
});
