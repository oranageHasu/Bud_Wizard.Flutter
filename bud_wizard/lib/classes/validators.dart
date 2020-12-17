// Declare Regular Expression patterns here
RegExp emailRegEx = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
RegExp phoneRegEx = RegExp(r"^[0-9]{11}$");

// Validation Functions Go Below
bool validateEmail(String email) {
  return emailRegEx.hasMatch(email);
}

bool validatePhone(String phone) {
  return phoneRegEx.hasMatch(phone);
}
