class AuthValidator{

  String? validateCompanyName(String? value){
    if (value == null || value.isEmpty) {
      return 'Company name is required';
    }
    return null;
  }

  String? validateContactPersonName(String? value){
    if (value == null || value.isEmpty) {
      return 'Contact person name is required';
    }
    return null;
  }

  String? validateContactPersonPhoneNumber(String? value){
    final phoneRegex = RegExp(r'^\d{11}$');
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!phoneRegex.hasMatch(value)) {
      return 'Phone number is not valid';
    }
    return null;
  }

  String? validateEmail(String? value){
    final emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Email is not valid';
    }
    return null;
  }

  String? validateAddress(String? value){
    if (value == null || value.isEmpty) {
      return 'Company address is required';
    }
    return null;
  }

  String? validateLocation(String? value){
    if (value == null || value.isEmpty) {
      return 'Company name is required';
    }
    return null;
  }

  String? validatePassword(String? value){
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }


}