class Validators {
  static String? validatePhoneNumber(String? value) {
    const Pattern pattern = r'^\d{11}$';
    final regex = RegExp(pattern.toString());
    if (value!.isEmpty || !regex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    } else {
      return null;
    }
  }

    static String? validateCardNumber(String? value) {
    const Pattern pattern = r'^\d{16}$';
    final regex = RegExp(pattern.toString());
    if (value!.isEmpty || !regex.hasMatch(value)) {
      return 'Please enter a valid card number';
    } else {
      return null;
    }
  }

    static String? validateExpiryMonth(String? value) {
    const Pattern pattern = r'^\d{2}$';
    final regex = RegExp(pattern.toString());
    if (value!.isEmpty || !regex.hasMatch(value)) {
      return 'Please enter a valid expiry month';
    } else {
      return null;
    }
  }

    static String? validateExpiryYear(String? value) {
    const Pattern pattern = r'^\d{2}$';
    final regex = RegExp(pattern.toString());
    if (value!.isEmpty || !regex.hasMatch(value)) {
      return 'Please enter a valid expiry year';
    } else {
      return null;
    }
  }

    static String? validateCVV(String? value) {
    const Pattern pattern = r'^\d{3}$';
    final regex = RegExp(pattern.toString());
    if (value!.isEmpty || !regex.hasMatch(value)) {
      return 'Please enter a valid CVV';
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    const Pattern emailPatter =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(emailPatter.toString());
    if (value!.isEmpty || !regex.hasMatch(value)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value == null) return null;

    if (value.isEmpty) {
      return 'Enter password';
    }
    if (value.length < 6) {
      return 'Password must contain at least 6 characters';
    }
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if ((value == null && password == null) || value != password) {
      return "Passwords don't match";
    }
    return null;
  }

  static String? validateTextInput(String? value, String placeholder) {
    if (value == null || value.isEmpty) {
      return 'Enter $placeholder';
    }
    return null;
  }

  static String? validateFullName(String? name) {
    if (name == null || name.isEmpty) return 'Enter full name';

    List<String> splitNames = name.trim().split(' ');

    if (splitNames.length < 2 ||
        (splitNames.length >= 2 && (splitNames.any((name) => name.isEmpty)))) {
      return 'Enter Surname     First name';
    }

    return null;
  }
}
