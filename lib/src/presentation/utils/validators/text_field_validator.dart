import 'package:get/get.dart';

abstract class TextFieldValidator {
  static String? checkIfEmpty(String value) {
    if (value.isEmpty) return "Campo obrigatório";

    return null;
  }

  static String? checkMinChar(String value, {int minChar = 6}) {
    final checkEmpty = checkIfEmpty(value);

    if (checkEmpty != null) return checkIfEmpty(value);

    if (value.length < minChar) {
      return "Deve conter pelo menos $minChar caracteres";
    }

    return null;
  }

  static String? validateName(String name) {
    final checkEmpty = checkIfEmpty(name);
    final minChar = checkMinChar(name);
    final regex = RegExp(r'^[A-Za-zÀ-ÖØ-öø-ÿ\s]+$');
    if (checkEmpty != null) return checkIfEmpty(name);
    if (minChar != null) return checkMinChar(name);
    if (!regex.hasMatch(name)) return "O nome só pode conter letras e espaços";
    return null;
  }

  static String? checkLenght(String value, {required int length}) {
    if (value.isEmpty) return null;
    if (value.length != length) {
      return "Deve conter $length caracteres";
    }

    return null;
  }

  static String? checkEmail(String value) {
    final checkEmpty = checkIfEmpty(value);

    if (checkEmpty != null) return checkIfEmpty(value);

    final isValidEmail = GetUtils.isEmail(value);

    if (!isValidEmail) return "E-mail inválido";

    return null;
  }

  static String? checkPassword(String value) {
    final checkEmpty = checkIfEmpty(value);

    if (checkEmpty != null) return checkIfEmpty(value);

    final checkMinLenght = checkMinChar(value);

    if (checkMinLenght != null) return checkMinChar(value);

    return null;
  }

  static String? checkCpf(String value) {
    final checkEmpty = checkIfEmpty(value);

    if (checkEmpty != null) return checkIfEmpty(value);

    final isValidCpf = GetUtils.isCpf(value);

    if (!isValidCpf) return "CPF inválido";

    return null;
  }

  static String? checkPhone(String value) {
    final checkEmpty = checkIfEmpty(value);

    if (checkEmpty != null) return checkIfEmpty(value);

    final isPhoneNumberValid = GetUtils.isPhoneNumber(value);

    if (!isPhoneNumberValid) return "Número de telefone inválido";

    return null;
  }
}
