import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/request_courier/models/autocomplete_model.dart';
import 'package:ojembaa_mobile/features/request_courier/services/request_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class AutoCompleteProvider
    extends StateNotifier<BaseNotifier<List<AutocompleteModel>>> {
  AutoCompleteProvider() : super(BaseNotifier());

  void autoCompleteQuery(
      {required String query,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await RequestServices.autocompleteQuery(query);
    if (data.success is List<AutocompleteModel>) {
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

final autoCompleteProvider = StateNotifierProvider<AutoCompleteProvider,
    BaseNotifier<List<AutocompleteModel>>>((ref) {
  return AutoCompleteProvider();
});
