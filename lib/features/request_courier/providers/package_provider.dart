import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/request_courier/models/autocomplete_model.dart';
import 'package:ojembaa_mobile/features/request_courier/services/request_services.dart';
import 'package:ojembaa_mobile/utils/components/utility.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class PackageProvider extends StateNotifier<BaseNotifier<String>> {
  PackageProvider() : super(BaseNotifier());

  void createPackage(
      {required Map<String, dynamic> payload,
      Function(String)? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await RequestServices.createPackage(payload);
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

  void createDelivery(
      {required Map<String, dynamic> payload,
      required String pickupId,
      required String dropoffId,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final pickUpData = await RequestServices.placesDetails(pickupId);
    final dropOffData = await RequestServices.placesDetails(dropoffId);

    if (pickUpData.success is PlacesCordinates &&
        dropOffData.success is PlacesCordinates) {
      final distance = Utility.calculateDistance(
          pickUpData.success!.lat,
          pickUpData.success!.lng,
          dropOffData.success!.lat,
          pickUpData.success!.lng);

      payload["pickupLat"] = pickUpData.success!.lat;
      payload["pickupLog"] = pickUpData.success!.lng;
      payload["deliveryLat"] = dropOffData.success!.lat;
      payload["deliveryLog"] = pickUpData.success!.lng;
      payload["distance"] = distance;

      final data = await RequestServices.createDelivery(payload);
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
    } else {
      state = BaseNotifier.setError("An error ocurred");
    }
  }
}

final packageProvider =
    StateNotifierProvider<PackageProvider, BaseNotifier>((ref) {
  return PackageProvider();
});
