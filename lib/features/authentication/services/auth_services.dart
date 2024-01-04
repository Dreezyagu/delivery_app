import 'package:dio/dio.dart';
import 'package:ojembaa_mobile/features/authentication/models/user_model.dart';
import 'package:ojembaa_mobile/utils/components/urls.dart';
import 'package:ojembaa_mobile/utils/data_util/error_model.dart';
import 'package:ojembaa_mobile/utils/helpers/http/http_helper.dart';

class AuthServices {
  static final baseUrl = OjembaaUrls.getUrl("baseUrl");
  static const signUpUrl = "auth/sign-up";
  static const signInUrl = "auth/sign-in";
  static const getDetailsUrl = "me";
  static const forgotPassUrl = "auth/reset-password";
  static const updatePassUrl = "auth/update-password";

  static final HttpHelper dio = HttpHelper();

  static Future<({UserModel? success, String? error})> signUp(
    String name,
    String phone,
    String email,
    String password,
  ) async {
    try {
      final response = await dio.post("$baseUrl$signUpUrl", data: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password
      });

      if (response.data["status"] == "success") {
        final data = UserModel.fromMap(response.data["data"]);
        return (success: data, error: null);
      } else {
        final error = ErrorModel.fromMap(response.data);
        return (success: null, error: error.message ?? "An error occured");
      }
    } on DioException catch (e) {
      ErrorModel? error;
      if (e.response != null) {
        error = ErrorModel.fromMap(e.response?.data);
      }
      return (success: null, error: error?.message ?? "An error occured");
    } catch (e) {
      return (success: null, error: "An error occured");
    }
  }

  static Future<({Map<String, dynamic>? success, String? error})> signIn(
    String email,
    String password,
  ) async {
    try {
      final response = await dio.post("$baseUrl$signInUrl",
          data: {"email": email, "password": password});

      if (response.data["status"] == "success") {
        return (
          success: response.data["data"] as Map<String, dynamic>,
          error: null
        );
      } else {
        final error = ErrorModel.fromMap(response.data);
        return (success: null, error: error.message ?? "An error occured");
      }
    } on DioException catch (e) {
      ErrorModel? error;
      if (e.response != null) {
        error = ErrorModel.fromMap(e.response?.data);
      }
      return (success: null, error: error?.message ?? "An error occured");
    } catch (e) {
      return (success: null, error: "An error occured");
    }
  }

  static Future<({UserModel? success, String? error})> getDetails() async {
    try {
      final response = await dio.get(
        "$baseUrl$getDetailsUrl",
      );

      if (response.data["status"] == "success") {
        final data = UserModel.fromMap(response.data["data"]);
        return (success: data, error: null);
      } else {
        final error = ErrorModel.fromMap(response.data);
        return (success: null, error: error.message ?? "An error occured");
      }
    } on DioException catch (e) {
      ErrorModel? error;
      if (e.response != null) {
        error = ErrorModel.fromMap(e.response?.data);
      }
      return (success: null, error: error?.message ?? "An error occured");
    } catch (e) {
      return (success: null, error: "An error occured");
    }
  }

  static Future<({String? success, String? error})> forgotPass(
      String email) async {
    try {
      final response =
          await dio.post("$baseUrl$forgotPassUrl", data: {"email": email});

      if (response.data["status"] == "success") {
        return (success: response.data["status"] as String, error: null);
      } else {
        final error = ErrorModel.fromMap(response.data);
        return (success: null, error: error.message ?? "An error occured");
      }
    } on DioException catch (e) {
      ErrorModel? error;
      if (e.response != null) {
        error = ErrorModel.fromMap(e.response?.data);
      }
      return (success: null, error: error?.message ?? "An error occured");
    } catch (e) {
      return (success: null, error: "An error occured");
    }
  }

  static Future<({String? success, String? error})> resetPass(
      Map<String, dynamic> payload) async {
    try {
      final response = await dio.post("$baseUrl$updatePassUrl", data: payload);

      if (response.data["status"] == "success") {
        return (success: response.data["status"] as String, error: null);
      } else {
        final error = ErrorModel.fromMap(response.data);
        return (success: null, error: error.message ?? "An error occured");
      }
    } on DioException catch (e) {
      ErrorModel? error;
      if (e.response != null) {
        error = ErrorModel.fromMap(e.response?.data);
      }
      return (success: null, error: error?.message ?? "An error occured");
    } catch (e) {
      return (success: null, error: "An error occured");
    }
  }
}
