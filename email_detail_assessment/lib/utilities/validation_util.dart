class ValidationUtil {
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return "Email address is required";
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return "email address is not valid";
    }

    return null;
  }

  static String? validatePassword(String input) {
    if (input.isEmpty) {
      return "Password is required";
    }

    if (input.length < 8) {
      return "Password must be at least 8 characters long";
    }

    return null;
  }
}
