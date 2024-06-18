enum DonationField {
  food,
  water,
  clothes,
  firewood,
  babyhood,
  eggs,
  electricity,
  rice,
  corn,
  medicalSupplies,
  schoolSupplies,
  bread,
  milk;

  String get title {
    switch (this) {
      case DonationField.food:
        return 'Food';
      case DonationField.water:
        return 'Water';
      case DonationField.clothes:
        return 'Clothes';
      case DonationField.firewood:
        return 'Firewood';
      case DonationField.babyhood:
        return 'Babyhood';
      case DonationField.eggs:
        return 'Eggs';
      case DonationField.electricity:
        return 'Electricity';
      case DonationField.rice:
        return 'Rice';
      case DonationField.corn:
        return 'Corn';
      case DonationField.medicalSupplies:
        return 'Medical Supplies';
      case DonationField.schoolSupplies:
        return 'School Supplies';
      case DonationField.bread:
        return 'Bread';
      case DonationField.milk:
        return 'Milk';
    }
  }
}

class Donation {}
