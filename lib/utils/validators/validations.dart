class UValidations {
  // Empty Text Validation
  static String? validationEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is requires';
    }
    return null;
  }

  // Email Validation
  static String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Regular Expression
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Invalid Email Address';
    }
    return null;
  }

  // Password Validation
  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // check password is 6 digits
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    // check for uppercase
    if (value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  // validation for Phone Number

  static String? phoneNumberValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required';
    }

    // Regular Expression
    final phoneNumber = RegExp(r'^\d{10}$');

    if (!phoneNumber.hasMatch(value)) {
      return 'Invalid Phone Number';
    }
    return null;
  }
}
