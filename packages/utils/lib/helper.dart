bool isNumeric(String? num) {
  if (num == null) {
    return false;
  }

  return double.tryParse(num) != null;
}

bool isInt(String? num) {
  if (num == null) {
    return false;
  }

  return int.tryParse(num) != null;
}

String? checkInValidator(String? value) {
  if (value == null || value.isEmpty || !isNumeric(value)) {
    return 'Please enter a measurement';
  }
  return null;
}

String? optionalCheckInIntValidator(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }

  if (!isInt(value)) {
    return 'Please enter a valid number';
  }
  return null;
}