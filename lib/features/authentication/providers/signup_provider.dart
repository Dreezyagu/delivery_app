import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/authentication/models/user_model.dart';
import 'package:ojembaa_mobile/features/authentication/services/auth_services.dart';
import 'package:ojembaa_mobile/utils/data_util/base_notifier.dart';

class SignUpProvider extends StateNotifier<BaseNotifier<UserModel>> {
  SignUpProvider() : super(BaseNotifier());

  String? errorMessage;
  UserModel? userModel;

  void signUp(
      {required String name,
      required String phone,
      required String email,
      required String password,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = BaseNotifier.setLoading();
    final data = await AuthServices.signUp(name, phone, email, password);
    if (data.success is UserModel) {
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
