import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/request_courier/services/request_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class PackageProvider extends StateNotifier<BaseNotifier<String>> {
  PackageProvider() : super(BaseNotifier());

  void createPackage(
      {required Map<String, dynamic> payload,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await RequestServices.createPackage(payload);
    if (data.success is String) {
      state = BaseNotifier.setDone(data.success!);
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

final packageProvider =
    StateNotifierProvider<PackageProvider, BaseNotifier>((ref) {
  return PackageProvider();
});
