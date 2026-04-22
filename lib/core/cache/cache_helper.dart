import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class CacheHelper {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );



  static Future<void> setValue(String key, dynamic value) async {
    if (value is bool) {
      await _storage.write(key: key, value: value.toString());
    } else if (value is String) {
      await _storage.write(key: key, value: value);
    } else if (value is int) {
      await _storage.write(key: key, value: value.toString());
    } else if (value is double) {
      await _storage.write(key: key, value: value.toString());
    } else if (value is List<String>) {
      await _storage.write(key: key, value: jsonEncode(value));
    }
  }

  static Future<dynamic> getValue(String key) async {
    final raw = await _storage.read(key: key);
    if (raw == null) return null;

    if (raw == 'true') return true;
    if (raw == 'false') return false;


    final intVal = int.tryParse(raw);
    if (intVal != null) return intVal;

    final doubleVal = double.tryParse(raw);
    if (doubleVal != null) return doubleVal;


    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) return List<String>.from(decoded);
    } catch (_) {}

    return raw;
  }

  static Future<void> removeValue(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}