import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/authentication/models/user_model.dart';
import 'package:ojembaa_mobile/features/authentication/services/auth_services.dart';
import 'package:ojembaa_mobile/utils/data_util/state_enum.dart';

class SignUpProvider extends StateNotifier<StateEnum> {
  SignUpProvider() : super(StateEnum.initial);

  String? errorMessage;
  UserModel? userModel;

  void signUp(
      {required String name,
      required String phone,
      required String email,
      required String password,
      VoidCallback? onSuccess,
      Function(String)? onError}) async {
    state = StateEnum.loading;
    final data = await AuthServices.signUp(name, phone, email, password);
    if (data?.success is UserModel) {
      userModel = data?.success;
      state = StateEnum.success;
      if (onSuccess != null) {
        onSuccess();
      }
    } else {
      errorMessage = data?.error;
      state = StateEnum.error;
      if (onError != null) {
        onError(data?.error ?? "An error ocurred");
      }
    }
  }
}
