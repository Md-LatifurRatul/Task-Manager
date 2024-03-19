class TextFieldValidator {
  static String? textValidator(String? value, String errorMessage) {
    if (value?.trim().isEmpty ?? true) {
      return errorMessage;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return "Enter your password";
    }
    if (value!.length <= 6) {
      return "Password should be more than 6 letters";
    }

    return null;
  }
}
