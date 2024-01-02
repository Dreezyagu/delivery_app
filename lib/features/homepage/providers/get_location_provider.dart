import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ojembaa_mobile/features/homepage/services/home_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class GetLocationProvider extends StateNotifier<BaseNotifier<Placemark>> {
  GetLocationProvider() : super(BaseNotifier<Placemark>());

  void getCurrentLocation(
      {Function(Placemark)? onSuccess, Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await HomeServices.getCurrentLocation();
    if (data.success is Placemark) {
      state = BaseNotifier.setDone<Placemark>(data.success!);
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

final getLocationProvider =
    StateNotifierProvider<GetLocationProvider, BaseNotifier<Placemark>>((ref) {
  return GetLocationProvider();
});
