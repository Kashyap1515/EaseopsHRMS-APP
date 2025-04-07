import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/setting_screen/model/location_choice_model.dart';

class ProfileRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<List<ChecklistLocationModel>> getChecklistLocations() async {
    try {
      final response = await _apiService.getResponse(
        ApiEndPoints.checklistLocation,
      );
      if (response != null && response is List<dynamic>) {
        final data = response;
        final locations = data
            .map(
              (json) =>
                  ChecklistLocationModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();

        return locations;
      } else {
        return [];
      }
    } catch (error) {
      throw ApiException('Error during API request: $error');
    }
  }
}
