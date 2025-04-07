List<String> ruleConversionOfRawDataStandard(
  Map<String, dynamic> rulesData,
) {
  final rulesToBeConvertedMap = rulesData['rules'] as Map<String, dynamic>;
  final rulesStandardListData = <String>[];
  final regex = RegExp(r'IF\(([^)]*)\)');

  rulesToBeConvertedMap.forEach((key, value) {
    final Match? match = regex.firstMatch(value as String);
    final contentInsideIF = match?.group(1) ?? ''; //
    final res = contentInsideIF.split(',');
    final valChoice = res[0].split('=');
    rulesStandardListData.add(valChoice[1].trim());
  });
  return rulesStandardListData;
}
