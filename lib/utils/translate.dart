import 'package:easeops_hrms/app_export.dart';
import 'package:translator/translator.dart';

Future<String> translateValue({required String text}) async {
  var title = text;
  final cachedLanguage = GetStorageHelper.getCurrentLanguageData();
  final languageCode =
      cachedLanguage == null ? 'en-In' : cachedLanguage.languageCode ?? 'en-In';
  try {
    final translator = GoogleTranslator();
    final translation = await translator.translate(text, to: languageCode);
    title = translation.text;
  } catch (e) {
    title = text;
  }
  return title;
}
