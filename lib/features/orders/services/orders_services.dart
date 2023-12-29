import 'package:dio/dio.dart';
import 'package:ojembaa_mobile/features/orders/models/delivery_model.dart';
import 'package:ojembaa_mobile/utils/components/urls.dart';
import 'package:ojembaa_mobile/utils/data_util/error_model.dart';
import 'package:ojembaa_mobile/utils/helpers/http/http_helper.dart';

class OrdersServices {
  static final baseUrl = OjembaaUrls.getUrl("baseUrl");
  static final HttpHelper dio = HttpHelper();

  static Future<({List<DeliveryModel>? success, String? error})>
      getOrders() async {
    try {
      final response = await dio.get("${baseUrl}deliveries");

      if (response.statusCode == 200) {
        final data = (response.data["data"] as List)
            .map(
              (e) => DeliveryModel.fromMap(e),
            )
            .toList();
        final reversedData = data.reversed.toList();
        return (success: reversedData, error: null);
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
