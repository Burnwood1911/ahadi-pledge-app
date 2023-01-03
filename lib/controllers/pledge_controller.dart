import 'package:ahadi_pledge/api/pledge_form.dart';
import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/models/pledge.dart';
import 'package:ahadi_pledge/models/pledge_purposes.dart';
import 'package:ahadi_pledge/models/pledge_types.dart';
import 'package:ahadi_pledge/repos/pledge_repo.dart';
import 'package:get/get.dart';

class PledgeController extends GetxController {
  final pledgeRepository = getIt.get<PledgeRepository>();
  RxBool isLoading = false.obs;
  RxList<PledgeElement> pledges = RxList();
  RxList<TypePledge> pledgetypes = RxList();
  RxList<PurposePledge> pledgepurposes = RxList();

  @override
  void onInit() async {
    super.onInit();
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

  Future<void> getJumuiyas() async {
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
    isLoading(false);
  }

  int totalPledgeAmount() {
    if (pledges.isNotEmpty) {
      return pledges
          .map((element) => int.parse(element.amount!))
          .reduce((value, element) => value + element);
    } else {
      return 0;
    }
  }
}
