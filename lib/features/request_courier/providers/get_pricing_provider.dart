import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/request_courier/models/pricing_model.dart';
import 'package:ojembaa_mobile/features/request_courier/services/request_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class GetPricingProvider extends StateNotifier<BaseNotifier<PricingModel>> {
  GetPricingProvider() : super(BaseNotifier());

  void getPricing(
      {required String deliveryId,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await RequestServices.getPricing(deliveryId);
    if (data.success is PricingModel) {
      state = BaseNotifier.setDone<PricingModel>(data.success!);
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

final getPricingProvider =
    StateNotifierProvider<GetPricingProvider, BaseNotifier<PricingModel>>(
        (ref) {
  return GetPricingProvider();
});
