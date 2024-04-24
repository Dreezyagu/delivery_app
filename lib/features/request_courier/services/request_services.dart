import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ojembaa_mobile/features/request_courier/models/autocomplete_model.dart';
import 'package:ojembaa_mobile/features/request_courier/models/couriers_model.dart';
import 'package:ojembaa_mobile/features/request_courier/models/pricing_model.dart';
import 'package:ojembaa_mobile/utils/components/urls.dart';
import 'package:ojembaa_mobile/utils/data_util/error_model.dart';
import 'package:ojembaa_mobile/utils/helpers/http/http_helper.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class RequestServices {
  static final baseUrl = OjembaaUrls.getUrl("baseUrl");
  static final placesAPIKey = OjembaaUrls.getUrl("placesAPIKey");
  static const createPackageUrl = "packages";
  static const createDeliveryUrl = "deliveries";

  static const uploadAssetUrl = "assets/upload";
  static const autocompleteUrl =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?location=9.0820,8.6753&region=ng";

  static const placesUrl =
      "https://maps.googleapis.com/maps/api/place/details/json?";

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

  static Future<({PlacesCordinates? success, String? error})> placesDetails(
      String placeId) async {
    try {
      final response =
          await Dio().get("${placesUrl}place_id=$placeId&key=$placesAPIKey");
      if (response.statusCode == 200 && response.data["result"] != null) {
        final data = PlacesCordinates.fromMap(
            response.data["result"]["geometry"]["location"]);

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
        return (success: response.data["data"]["id"] as String, error: null);
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
        try {
          error = ErrorModel.fromMap(e.response?.data);
        } catch (e) {
          return (success: null, error: "File too large");
        }
      }
      return (success: null, error: error?.message ?? "An error occured");
    } catch (e) {
      return (success: null, error: "An error occured");
    }
  }

  static Future<({String? success, String? error})> createDelivery(
      Map<String, dynamic> payload) async {
    try {
      final response =
          await dio.post("$baseUrl$createDeliveryUrl", data: payload);

      if (response.data["status"] == "success") {
        return (success: response.data["data"] as String, error: null);
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

  static Future<({List<CouriersModel>? success, String? error})> findCouriers(
      String deliveryId, int radius) async {
    try {
      final response = await dio
          .get("${baseUrl}deliveries/$deliveryId/find-couriers?radius=$radius");

      if (response.data["status"] == "success") {
        final data = (response.data["data"] as List)
            .map(
              (e) => CouriersModel.fromMap(e),
            )
            .toList();
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

  static Future<({String? success, String? error})> pickCourier(
      String deliveryId, String courierId) async {
    try {
      final response = await dio.post(
          "${baseUrl}deliveries/$deliveryId/pick-courier",
          data: {"courierId": courierId});

      if (response.data["status"] == "success") {
        return (success: response.data["status"].toString(), error: null);
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

  static Future<({String? success, String? error})> setDeliverySpeed(
      String deliveryId, String mode) async {
    try {
      final response = await dio.patch(
          "${baseUrl}deliveries/$deliveryId/set-mode",
          body: {"mode": mode});

      if (response.data["status"] == "success") {
        return (success: response.data["status"].toString(), error: null);
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

  static Future<({PricingModel? success, String? error})> getPricing(
      String deliveryId) async {
    try {
      final response =
          await dio.get("${baseUrl}deliveries/$deliveryId/pricing-summary");

      if (response.data["status"] == "success") {
        final data = PricingModel.fromMap(response.data["data"]);
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
}
