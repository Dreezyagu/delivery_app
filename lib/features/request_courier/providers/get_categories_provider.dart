import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/request_courier/models/categories_model.dart';
import 'package:ojembaa_mobile/features/request_courier/services/request_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class GetCategories extends StateNotifier<BaseNotifier<List<CategoriesModel>>> {
  GetCategories() : super(BaseNotifier());

  Future<bool> fetchCategories(
      {int radius = 5,
      Function(List<CategoriesModel>)? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await RequestServices.fetchCategories();
    if (data.success is List<CategoriesModel>) {
      state = BaseNotifier.setDone<List<CategoriesModel>>(data.success!);
      if (onSuccess != null) {
        onSuccess(data.success!);
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

final getCategoriesProvider =
    StateNotifierProvider<GetCategories, BaseNotifier<List<CategoriesModel>>>(
        (ref) {
  return GetCategories();
});
