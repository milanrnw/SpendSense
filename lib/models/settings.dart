import 'dart:convert';

// Helper function to decode a JSON string into a SettingsModel object
SettingsModel settingsModelFromJson(String str) =>
    SettingsModel.fromJson(json.decode(str));

// Helper function to encode a SettingsModel object into a JSON string
String settingsModelToJson(SettingsModel data) => json.encode(data.toJson());

class SettingsModel {
  final String id; // Typically the same as the user's ID
  final bool notificationsEnabled;
  String? currency; // e.g., "USD", "INR", "EUR"
  String? language; // e.g., "en", "es"

  SettingsModel({
    required this.id,
    required this.notificationsEnabled,
    this.currency,
    this.language,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
    id: json["id"],
    notificationsEnabled: json["notificationsEnabled"],
    currency: json["currency"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "notificationsEnabled": notificationsEnabled,
    "currency": currency,
    "language": language,
  };

  SettingsModel copyWith({
    String? id,
    bool? notificationsEnabled,
    String? currency,
    String? language,
  }) {
    return SettingsModel(
      id: id ?? this.id,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      currency: currency ?? this.currency,
      language: language ?? this.language,
    );
  }
}
