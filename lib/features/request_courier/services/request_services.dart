import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ojembaa_mobile/features/request_courier/models/autocomplete_model.dart';
import 'package:ojembaa_mobile/utils/components/urls.dart';
import 'package:ojembaa_mobile/utils/data_util/error_model.dart';
import 'package:ojembaa_mobile/utils/helpers/http/http_helper.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class RequestServices {
  static final baseUrl = OjembaaUrls.getUrl("baseUrl");
  static final placesAPIKey = OjembaaUrls.getUrl("placesAPIKey");
  static const createPackageUrl = "packages";
  static const uploadAssetUrl = "assets/upload";
  static const autocompleteUrl =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?location=9.0820,8.6753&region=ng";

  static final HttpHelper dio = HttpHelper();

  static Future<({List<AutocompleteModel>? success, String? error})>
      autocompleteQuery(String query) async {
    try {
      final response =
          await Dio().get("$autocompleteUrl&key=$placesAPIKey&input=$query");
      if (response.statusCode == 200 && response.data["predictions"] != null) {
        final data = (response.data["predictions"] as List)
            .map((e) => AutocompleteModel.fromMap(e))
            .toList();
        return (success: data, error: null);
      } else {
        ErrorModel? error;
        if (response.data != null) {
          error = ErrorModel.fromMap(response.data);
        }
        return (
          success: null,
          error: error?.error_message ?? "An error occured"
        );
      }
    } on DioException catch (e) {
      ErrorModel? error;
      if (e.response != null) {
        error = ErrorModel.fromMap(e.response?.data);
      }
      return (success: null, error: error?.error_message ?? "An error occured");
    } catch (e) {
      return (success: null, error: "An error occured");
    }
  }

  static Future<({String? success, String? error})> createPackage(
      Map<String, dynamic> payload) async {
    try {
      final response =
          await dio.post("$baseUrl$createPackageUrl", data: payload);

      if (response.data["status"] == "success") {
        // final data = UserModel.fromMap(response.data["data"]);
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

  static Future<({String? success, String? error})> uploadPicture(
      File file) async {
    try {
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path,
            contentType:
                MediaType('image', extension(file.path).replaceFirst(".", "")))
      });

      final response = await dio.post(
        "$baseUrl$uploadAssetUrl",
        data: formData,
      );

      if (response.data["status"] == "success") {
        return (success: response.data["data"]["url"] as String, error: null);
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
