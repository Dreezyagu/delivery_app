import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/request_courier/models/couriers_model.dart';
import 'package:ojembaa_mobile/features/request_courier/services/request_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class FindCouriersProvider
    extends StateNotifier<BaseNotifier<List<CouriersModel>>> {
  FindCouriersProvider() : super(BaseNotifier());

  void findCouriers(
      {required String deliveryId,
      int radius = 3,
      Function(List<CouriersModel>)? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await RequestServices.findCouriers(deliveryId, radius);
    if (data.success is List<CouriersModel>) {
      state = BaseNotifier.setDone<List<CouriersModel>>(data.success!);
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

final findCouriersProvider = StateNotifierProvider<FindCouriersProvider,
    BaseNotifier<List<CouriersModel>>>((ref) {
  return FindCouriersProvider();
});
