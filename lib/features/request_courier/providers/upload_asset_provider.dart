import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/request_courier/services/request_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class UploadAssetProvider extends StateNotifier<BaseNotifier> {
  UploadAssetProvider() : super(BaseNotifier());

  void uploadPicture(
      {required File file,
      Function(String)? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await RequestServices.uploadPicture(file);
    if (data.success is String) {
      state = BaseNotifier.setDone(data.success!);
      if (onSuccess != null) {
        onSuccess(data.success!);
      }
    } else {
      state = BaseNotifier.setError(data.error ?? "An error ocurred");
      if (onError != null) {
        onError(data.error ?? "An error ocurred");
      }
    }
  }
}

final uploadAssetProvider =
    StateNotifierProvider<UploadAssetProvider, BaseNotifier>((ref) {
  return UploadAssetProvider();
});
