import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/presentation/setting_screen/model/language_choice_model.dart';
import 'package:easeops_hrms/presentation/setting_screen/model/location_choice_model.dart';
import 'package:easeops_hrms/presentation/setting_screen/repository/profile_repository.dart';

class SettingController extends GetxController {
  Rx<Status> statusLocationResult = Status.loading.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ApiResponse<List<ChecklistLocationModel>> locationsResultModel =
      ApiResponse.loading();
  ProfileRepository profileRepository = ProfileRepository();
  double latitude = 0;
  double longitude = 0;

  RxBool isFromLogin = false.obs;
  RxString currentLanguage = 'Change Language'.obs;
  RxString currentLocation = 'Change Location'.obs;

  final RxList<ChecklistLocationModel> displayedLocations =
      <ChecklistLocationModel>[].obs;
  final RxList<ChecklistLocationModel> filteredLocations =
      <ChecklistLocationModel>[].obs;
  final RxList<LanguageModel> filteredLanguage = <LanguageModel>[].obs;
  final Map<int, ChecklistLocationModel> filteredLocationsMap =
      <int, ChecklistLocationModel>{};
  final Map<int, int> filteredLocationIndices = <int, int>{};

  void filterLocations(String? query) {
    if (query!.isEmpty) {
      // If the query is empty, assign all locations to the filtered list
      filteredLocations.value = locationsResultModel.data ?? [];
      displayedLocations.value = filteredLocations;
      filteredLocationIndices.clear();

      for (var i = 0; i < filteredLocations.length; i++) {
        filteredLocationsMap[i] = filteredLocations[i];
        filteredLocationIndices[i] = i;
      }
    } else {
      // If there is a query, filter the locations based on the search query
      final filteredList = locationsResultModel.data
          ?.where(
            (location) => location.locationName
                .toLowerCase()
                .contains(query.toLowerCase()),
          )
          .toList();

      filteredLocations.value = filteredList ?? [];
      displayedLocations.value = filteredLocations;
      filteredLocationIndices.clear();
      for (var i = 0; i < filteredLocations.length; i++) {
        filteredLocationsMap[i] = filteredLocations[i];
        filteredLocationIndices[i] =
            locationsResultModel.data!.indexOf(filteredList![i]);
      }
    }
  }

  Future<void> _setLocationResponse(
    ApiResponse<List<ChecklistLocationModel>> response,
  ) async {
    locationsResultModel = response;
    if (response.status == Status.completed) {
      await loadCachedLocation();
      statusLocationResult.value = Status.completed;
    } else if (response.status == Status.error) {
      customSnackBar(
        title: 'Something went wrong..!!',
        message: response.message.toString(),
        alertType: AlertType.alertError,
      );
      statusLocationResult.value = Status.error;
    }
  }

  Future<void> fetchMyLocationRequest() async {
    await _setLocationResponse(ApiResponse.loading());
    await profileRepository
        .getChecklistLocations()
        .then(
          (value) => _setLocationResponse(ApiResponse.completed(value)),
        )
        .onError(
          (error, stackTrace) =>
              _setLocationResponse(ApiResponse.error(error.toString())),
        );
  }

  Future<void> fetchLanguageList() async {
    statusLocationResult.value = Status.loading;
    filteredLanguage.clear();
    for (final data in languageData) {
      filteredLanguage.add(LanguageModel.fromJson(data));
    }
    statusLocationResult.value = Status.completed;
  }

  Rx<ChecklistLocationModel> selectedLocation =
      Rx<ChecklistLocationModel>(ChecklistLocationModel());

  Rx<LanguageModel> selectedLanguage = Rx<LanguageModel>(LanguageModel());

  Future<void> setSelectedLocation(ChecklistLocationModel location) async {
    selectedLocation.value = location;
    await GetStorageHelper.setCurrentLocationData(jsonEncode(location));
  }

  Future<void> setSelectedLanguage(LanguageModel language) async {
    selectedLanguage.value = language;
    currentLanguage.value = language.languageName != null
        ? 'Select Language'
        : language.languageName ?? 'English';
    await GetStorageHelper.setCurrentLanguageData(jsonEncode(language));
  }

  Future<void> loadCachedLocation() async {
    final cachedLocation = GetStorageHelper.getCurrentLocationData();
    if (cachedLocation != null) {
      await setSelectedLocation(cachedLocation);
    } else {
      if (locationsResultModel.data != null &&
          locationsResultModel.data!.isNotEmpty) {
        await setSelectedLocation(locationsResultModel.data![0]);
      }
    }
  }

  Future<void> loadCachedLanguage() async {
    final cachedLanguage = GetStorageHelper.getCurrentLanguageData();
    if (cachedLanguage != null) {
      await setSelectedLanguage(cachedLanguage);
    } else {
      if (languageData.isNotEmpty) {
        await setSelectedLanguage(LanguageModel.fromJson(languageData[0]));
      }
    }
  }
}
