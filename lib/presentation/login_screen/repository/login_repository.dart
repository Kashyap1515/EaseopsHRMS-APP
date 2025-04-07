import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/login_screen/models/device_model.dart';

class LoginRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> getLoginResponse(Map<String, dynamic> jsonBody) async {
    try {
      final dynamic response = await _apiService.postResponse(
        ApiEndPoints.login,
        jsonBody,
      );
      final jsonData = LoginModel.fromJson(response as Map<String, dynamic>);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getMyProfileRequest() async {
    try {
      final dynamic response = await _apiService.getResponse(
        ApiEndPoints.getMyProfile,
      );
      final jsonData =
          UserLoggedInProfile.fromJson(response as Map<String, dynamic>);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getDeviceRequest(Map<String, dynamic> jsonBody) async {
    try {
      final dynamic response =
          await _apiService.postResponse(ApiEndPoints.getDevice, jsonBody);
      final jsonData =
          DeviceInfoModel.fromJson(response as Map<String, dynamic>);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }
}
