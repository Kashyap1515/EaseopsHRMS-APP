class LanguageModel {
  LanguageModel({
    this.languageName,
    this.languageEnglishName,
    this.languageCode,
  });

  // Factory method to create a ChecklistLocationModel instance from a JSON map
  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      languageName: json['name'] as String? ?? '',
      languageEnglishName: json['english_name'] as String,
      languageCode: json['language_code'] as String,
    );
  }

  final String? languageName;
  final String? languageEnglishName;
  final String? languageCode;

  Map<String, dynamic> toJson() {
    return {
      'name': languageName,
      'english_name': languageEnglishName,
      'language_code': languageCode,
    };
  }
}
