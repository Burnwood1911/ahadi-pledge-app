import 'package:ahadi_pledge/api/pledge_form.dart';
import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/models/pledge.dart';
import 'package:ahadi_pledge/models/pledge_purposes.dart';
import 'package:ahadi_pledge/models/pledge_types.dart';
import 'package:ahadi_pledge/repos/pledge_repo.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:ahadi_pledge/utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

class PledgeController extends GetxController {
  final pledgeRepository = getIt.get<PledgeRepository>();
  RxBool isLoading = false.obs;
  RxList<PledgeElement> pledges = RxList();
  RxList<TypePledge> pledgetypes = RxList();
  RxList<PurposePledge> pledgepurposes = RxList();

  TextEditingController reminderDate = TextEditingController();

  @override
  void onReady() async {
    super.onReady();
    await getPledges();
    await getPledgeTypes();
    await getPledgePurposes();
  }

  Future<void> getPledges() async {
    isLoading(true);
    final result = await pledgeRepository.getPledges();
    pledges.value = result.pledges!;
    isLoading(false);
  }

  Future<void> getPledgeTypes() async {
    isLoading(true);
    final result = await pledgeRepository.getPledgeTypes();
    pledgetypes.value = result.types!;
    isLoading(false);
  }

  Future<void> getPledgePurposes() async {
    isLoading(true);
    final result = await pledgeRepository.getPledgePurposes();
    pledgepurposes.value = result.purposes!;
    isLoading(false);
  }

  Future<void> createPledge(PledgeForm form) async {
    isLoading(true);
    final result = await pledgeRepository.createPledge(form);
    if (result == true) {
      Get.back();
    }
    getPledges();
    isLoading(false);
  }

  Future<void> setReminder(int id, String date) async {
    isLoading(true);
    final result = await pledgeRepository.setReminder(id, date);
    reminderDate.text = "";
    if (result == true) {
      Get.back();
      showAppSnackbar(
          LocaleKeys.success_text.tr(), LocaleKeys.reminder_set_text.tr());
    }
    isLoading(false);
  }

  int totalPledgeAmount() {
    if (pledges.isNotEmpty) {
      var kapp = pledges
          .map((element) => int.parse(element.amount))
          .reduce((value, element) => value + element);

      return kapp;
    } else {
      return 0;
    }
  }
}
