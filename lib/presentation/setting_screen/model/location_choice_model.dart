class ChecklistLocationModel {
  // Constructor for the ChecklistLocationModel
  ChecklistLocationModel({
    this.locationId = '',
    this.locationName = '',
    this.totalChecklists = 0,
    this.dueDate,
    this.lat,
    this.lon,
  });

  // Factory method to create a ChecklistLocationModel instance from a JSON map
  factory ChecklistLocationModel.fromJson(Map<String, dynamic> json) {
    return ChecklistLocationModel(
      locationId: json['location_id'] as String? ?? '',
      locationName: json['location_name'] as String,
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'] as String)
          : null,
      totalChecklists: json['total_checklists'] as int,
      lat: json['lat'] as String? ?? '0',
      lon: json['lon'] as String? ?? '0',
    );
  }

  // Unique identifier for the location
  final String locationId;

  // Name of the location
  final String locationName;
  final String? lat;
  final String? lon;

  // Due date for the checklists (can be null if not specified)
  final DateTime? dueDate;

  // Total number of checklists associated with the location
  final int totalChecklists;

  // Method to convert a ChecklistLocationModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'location_id': locationId,
      'lat': lat,
      'lon': lon,
      'location_name': locationName,
      'due_date': dueDate?.toIso8601String(),
      'total_checklists': totalChecklists,
    };
  }
}
