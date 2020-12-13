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

bool validateMailgunPrivateKey(String privateKey) {
  bool retval = false;

  if (privateKey.isNotEmpty &&
      privateKey.length == 36 &&
      privateKey.startsWith('key-')) {
    retval = true;
  }

  return retval;
}

bool validateMailgunPublicKey(String publicKey) {
  bool retval = false;

  if (publicKey.isNotEmpty &&
      publicKey.length == 39 &&
      publicKey.startsWith('pubkey-')) {
    retval = true;
  }

  return retval;
}
