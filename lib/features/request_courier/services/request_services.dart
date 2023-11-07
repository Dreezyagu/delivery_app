import 'package:dio/dio.dart';
import 'package:ojembaa_mobile/features/request_courier/models/autocomplete_model.dart';
import 'package:ojembaa_mobile/utils/components/urls.dart';
import 'package:ojembaa_mobile/utils/data_util/error_model.dart';
import 'package:ojembaa_mobile/utils/helpers/http/http_helper.dart';

class RequestServices {
  static final baseUrl = OjembaaUrls.getUrl("baseUrl");
  static final placesAPIKey = OjembaaUrls.getUrl("placesAPIKey");
  static const signUpUrl = "auth/sign-up";
  static const signInUrl = "auth/sign-in";
  static const getDetailsUrl = "me";
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
}
