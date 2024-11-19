class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final RegExp emailExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo requerido';
    }

    return null;
  }

  static String? requiredDropdown(Object? value) {
    if (value == null) {
      return 'Campo requerido';
    }

    return null;
  }
}
