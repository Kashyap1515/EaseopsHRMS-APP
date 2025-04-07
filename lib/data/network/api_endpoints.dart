import 'package:easeops_hrms/utils/flavor_config.dart';

class ApiEndPoints {
  static String baseApi = FlavorConfig.instance.values.baseUrl;
  static const String login = 'api/v1/creds/login';
  static const String accountUsers = 'api/v1/users';
  static const String locations = 'api/v1/user/my-locations-assessments';
  static const String apiPwdResetLink = 'api/v1/passwords/generate-reset-link';
  static const String getMyProfile = 'api/v1/users/my-profile';
  static const String getDevice = 'api/v1/device';
  static const String getSummary = 'api/v1/audits';
  static const String getAssessmentCategory = 'api/v1/assessments/categories';
  static const String getAssessCatAudit = 'api/v1/audits';
  static const String getSectionStandard = 'api/v1/audit-sections';
  static const String getAuditStandard = 'api/v1/audit-standards';
  static const String getAction = 'api/v1/actions';
  static const String getActionForAccount = '/api/v1/action/for/account';
  static const String apiProcessTypes = 'api/v1/process-types';
  static const String getComment = 'api/v1/comments';
  static const String getImageUrl = 'api/v1/images';
  static const String checklistLocation = 'api/v1/checklist-audits/locations';
  static const String getChecklistAuditsSummary =
      'api/v1/checklist-audits/locations';
  static const String apiToDoAdhocChecklist = 'api/v1/checklists/adhoc';
  static const String apiToDoAdhocCompletedChecklist =
      'api/v1/checklists/adhoc-completed';
  static const String baseChecklist = 'api/v1/checklists';
  static const String baseFormChecklist = 'api/v1/checklists/forms';
  static const String baseFormPastChecklist = 'api/v1/checklist-audits/forms';
  static const String baseFormPastTasksChecklist =
      'api/v1/checklist-audits/tasks/forms';
  static const String createChecklistAudit = 'api/v1/checklist-audits';
  static const String checklistSection = 'api/v1/checklists/sections';
  static const String checklistAuditTask = 'api/v1/checklist-audits/tasks';
  static const String syncAudit = 'api/v1/checklist-audits/offline';
  static const String syncFormAudit =
      'api/v1/checklist-audits/tasks/forms/tasks';
  static const String syncSectionAudit =
      'api/v1/checklist-audits/sections/offline';
  static const String syncTaskAudit = 'api/v1/checklist-audits/tasks/offline';
  static const String syncSectionTaskAudit =
      'api/v1/checklist-audits/tasks/sections-with-tasks';
  static const String apiIssues = 'api/v1/issues';
  static const String apiTodayChecklist = 'api/v1/checklists/active-info';
  static const String apiChecklistAudit =
      'api/v1/reports/checklists/locations/checklist-audits';
  static const String apiUpcomingChecklist = 'api/v1/checklists/upcoming';
  static const String apiCompletedChecklist = 'api/v1/checklists/completed';
  static const String apiAttendance =
      'api/v1/attendance-management/attendances';
  static const String apiAttendanceProcess =
      'api/v1/attendance-management/attendances/process';
  static const String apiShifts = 'api/v1/attendance-management/shifts';
  static const String apiLocationSectionTaskDetail =
      'api/v1/checklist-audits/tasks';
  static const String apiAttendanceUserData =
      'api/v1/attendance-management/reports/users';
  static const String apiAssetManageAsset =
      'api/v1/asset-management/assets/single';
  static const String apiLmsFolder = 'api/v1/lms/folders';
  static const String apiLmsFiles = 'api/v1/lms/files';
  static const String apiLmsLog = 'api/v1/lms/logs';
  static const String apiSupportedVersion = 'api/v1/supported_app_version';

  static const String exApiImage = 'images';
  static const String exApiSectionTaskFlat = 'section-task-flat';
  static const String exApiContent = 'content';
  static const String exApiSetDp = 'set-dp';
}
