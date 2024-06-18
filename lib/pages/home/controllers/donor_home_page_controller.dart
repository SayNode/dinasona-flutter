import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/donation.dart';
import '../../../util/popup_manager.dart';

class DonorHomePageController extends GetxController {
  RxList<DonationField> selectedDonationFields = <DonationField>[].obs;
  RxList<Donation> recommendedDonations = <Donation>[].obs;

  @override
  Future<void> onInit() async {
    selectedDonationFields.addAll(DonationField.values.take(2));
    recommendedDonations.value = <Donation>[
      Donation(
        title: 'Nutritious food for my three young children',
        description:
            "Hello, I'm a single mother in Nairobi, doing my best to provide nourishing meals for my three young children.",
        beneficiaryPhotoUrl:
            'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/a8b67f4955123ecb6aeb3b65644a92dc8a9750ca',
        beneficiaryName: 'Fatima Ahmed',
        beneficiaryLocation: 'Nairobi, Kenya',
        amount: 5,
        donationFields: <DonationField>[DonationField.food],
        photoUrls: <String>[
          'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/7d383c408d1c4b9cddd4217f7e04db11358de07c',
        ],
      ),
      Donation(
        title: 'Funding for house construction',
        description:
            "As a father, my dream is to provide a secure home for my family. I'm reaching out for financial support to build a modest house.",
        beneficiaryPhotoUrl:
            'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/3d501811ca6d8baae4bf4d6308b4edb04e9c6d92',
        beneficiaryName: 'Rajesh Patel',
        beneficiaryLocation: 'Mumbai, India',
        amount: 10,
        donationFields: <DonationField>[DonationField.electricity],
        photoUrls: <String>[
          'https://www.figma.com/file/j6d1TixfKJ4qwp9UJgu2WR/image/7d383c408d1c4b9cddd4217f7e04db11358de07c',
        ],
      ),
    ];
    super.onInit();
  }

  Future<void> openExploreMore({Widget? child}) async {
    final List<DonationField>? temp =
        await PopupManager.openSelectDonationFieldsPopup(
      selectedDonationFields,
    );
    if (temp != null) {
      selectedDonationFields.value = temp;
    }
  }

  Future<void> seeAll(DonationField? field) async {}
}
