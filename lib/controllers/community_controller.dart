import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/models/community.dart';
import 'package:ahadi_pledge/repos/community_repo.dart';
import 'package:ahadi_pledge/utils/snackbar.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  final communityRepository = getIt.get<CommunityRepository>();
  static CommunityController instance = Get.find<CommunityController>();
  RxBool isLoading = false.obs;
  RxList<CommunityElement> juimuiyas = RxList();
  RxInt selectedJumuiyaId = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    await getJumuiyas();
  }

  Future<void> getJumuiyas() async {
    isLoading(true);
    final result = await communityRepository.getJumuiyas();

    result.when((community) {
      juimuiyas.value = community.communities;
      selectedJumuiyaId.value = juimuiyas[0].id;
    }, (error) => showAppSnackbar("Error", "Failed to load communities"));
    isLoading(false);
  }
}

final communityController = CommunityController.instance;
