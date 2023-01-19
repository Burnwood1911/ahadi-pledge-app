import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/models/community.dart';
import 'package:ahadi_pledge/models/subscription.dart';
import 'package:ahadi_pledge/repos/community_repo.dart';
import 'package:ahadi_pledge/utils/snackbar.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  final communityRepository = getIt.get<CommunityRepository>();
  static CommunityController instance = Get.find<CommunityController>();
  RxBool isLoading = false.obs;
  RxList<CommunityElement> juimuiyas = RxList();
  RxList<SubscriptionElement> subscriptions = RxList();

  RxInt selectedJumuiyaId = RxInt(0);

  @override
  void onInit() async {
    super.onInit();
    await getJumuiyas();
    await getSubscriptions();
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

  Future<void> getSubscriptions() async {
    isLoading(true);
    final result = await communityRepository.getSubscriptions();

    result.when((subs) {
      subscriptions.value = subs.subscriptions;
    }, (error) => showAppSnackbar("Error", "Failed to load communities"));
    isLoading(false);
  }
}

final communityController = CommunityController.instance;
