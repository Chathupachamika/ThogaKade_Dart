class Validators {
  static bool isValidVegetableName(String name) {
    return name.isNotEmpty && name.length > 2;
  }

  static bool isValidQuantity(double quantity) {
    return quantity > 0;
  }
}
