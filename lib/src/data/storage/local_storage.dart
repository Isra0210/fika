import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:collection';

class LocalStorage {
  SharedPreferences? _prefs;

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> init() async {
    await _initPrefs();
  }

  Map<String, dynamic>? getItem(String key) {
    if (_prefs == null) return null;
    final value = _prefs!.getString(key);

    if (value == null) return null;

    try {
      final decoded = json.decode(value);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      } else {
        return null;
      }
    } catch (e) {
      Get.log('Erro ao decodificar JSON: $e');
      return null;
    }
  }

  Future<void> removeKey(String key) async {
    await _initPrefs();
    await _prefs?.remove(key);
  }

  Future<void> saveItem<T>(String key, T value) async {
    await _initPrefs();

    try {
      final jsonString = json.encode(value);
      final isSaved = await _prefs?.setString(key, jsonString);
      if (isSaved == null || !isSaved) {
        Get.log('Falha ao salvar a chave: $key');
      }
    } catch (e) {
      Get.log('Erro ao salvar o dado: $e');
    }
  }

  Future<List<String>> getKeys() async {
    await _initPrefs();
    if (_prefs == null) return [];
    final keys = SplayTreeSet<String>.from(_prefs!.getKeys());
    return keys.toList();
  }

  Future<void> saveBool(String key, bool value) async {
    await _initPrefs();
    await _prefs?.setBool(key, value);
  }

  bool? getBool(String key) {
    if (_prefs == null) return null;
    return _prefs!.getBool(key);
  }
}
