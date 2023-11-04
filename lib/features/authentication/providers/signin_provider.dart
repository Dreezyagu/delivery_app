import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/authentication/models/user_model.dart';
import 'package:ojembaa_mobile/features/authentication/services/auth_services.dart';
import 'package:ojembaa_mobile/utils/data_util/state_enum.dart';
import 'package:ojembaa_mobile/utils/helpers/storage/storage_helper.dart';
import 'package:ojembaa_mobile/utils/helpers/storage/storage_keys.dart';

class SignInProvider extends StateNotifier<StateEnum> {
  SignInProvider() : super(StateEnum.initial);

  UserModel? userModel;

  void signIn(
      {required String email,
      required String password,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = StateEnum.loading;
    final data = await AuthServices.signIn(email, password);
    if (data?.success is Map<String, dynamic>) {
      StorageHelper.setString(
          StorageKeys.accessToken, data?.success?["accessToken"]);
      StorageHelper.setString(
          StorageKeys.refreshToken, data?.success?["refreshToken"]);

      final data2 = await AuthServices.getDetails();

      if (data2?.success is UserModel) {
        userModel = data2?.success;
        state = StateEnum.success;
        if (onSuccess != null) {
          onSuccess();
        }
      } else {
        state = StateEnum.error;
        if (onError != null) {
          onError(data2?.error ?? "An error ocurred");
        }
      }
    } else {
      state = StateEnum.error;
      if (onError != null) {
        onError(data?.error ?? "An error ocurred");
      }
    }
  }
}
