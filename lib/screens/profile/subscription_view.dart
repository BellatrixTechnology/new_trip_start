import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_button.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/controllers/google_ads.controller.dart';
import 'package:new_trip_start/controllers/map_ctrl.dart';
import 'package:new_trip_start/screens/auth/auth.dart';
import 'package:new_trip_start/services/index.dart';

import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class SubscriptionStatus extends StatefulWidget {
  final bool isPremium;
  final int searchesLeft;
  final int totalVehicles;
  final int maxSearchesLeft;
  final String type;

  const SubscriptionStatus({
    super.key,
    this.isPremium = false,
    this.searchesLeft = 4,
    this.totalVehicles = 1,
    this.type = 'free',
    this.maxSearchesLeft = -1,
  });

  @override
  State<SubscriptionStatus> createState() => _SubscriptionStatusState();
}

class _SubscriptionStatusState extends State<SubscriptionStatus> {
  @override
  void initState() {
    super.initState();
    // Load the rewarded ad when the widget is first created
    Get.put(GoogleAdsController()).loadRewardedAd();
  }

  // Get max searches based on user type
  int get maxSearches {
    print(
        "${widget.type}  -> ${srvUser.user.config}  searchesLeft -> ${widget.searchesLeft}");
    if (widget.isPremium) return -1; // Unlimited
    if (widget.type == 'guest') {
      return srvUser.user.config!['global_guest_api_count'];
    }
    return srvUser.user.config != null
        ? srvUser.user.config!['global_api_count']
        : 2; // Free user
  }

  // Get max vehicles based on user type
  int get maxVehicles {
    if (widget.isPremium) return -1; // Multiple
    return 1; // Guest and Free users
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).cardColor,
                Theme.of(context).cardColor.withOpacity(0.9),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSubscriptionBadge(),
              const SizedBox(height: 20),
              if (!widget.isPremium) ...[
                _buildSearchProgress(context),
                const SizedBox(height: 20),
              ],
              _buildFeaturesGrid(),
              if (!widget.isPremium &&
                  (maxSearches - widget.searchesLeft > 0)) ...[
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: AppText(
                    onTap: () {
                      Get.find<GoogleAdsController>().showRewardedAd();
                    },
                    text: "watch_free_video_to_get_free_search".tr,
                    color: kPrimaryColor,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              _buildUpgradeButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _getBadgeColor(),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.isPremium) ...[
            const Icon(Icons.workspace_premium, size: 20, color: Colors.white),
            const SizedBox(width: 8),
          ],
          AppText(
            text: _getBadgeText(),
            color: widget.isPremium ? kBgLightColor : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Color _getBadgeColor() {
    if (widget.isPremium) return Colors.amber;
    if (widget.type == 'guest') return Colors.grey[200]!;
    return Colors.grey[300]!;
  }

  String _getBadgeText() {
    if (widget.isPremium) return 'Premium';
    if (widget.type == 'guest') return 'Guest';
    return 'free_plan'.tr;
  }

  Widget _buildSearchProgress(BuildContext context) {
    final maxSearchesForProgress = maxSearches == -1 ? 1 : maxSearches;
    var progressValue = maxSearches == -1
        ? 0.0
        : ((maxSearchesForProgress - widget.searchesLeft) /
            maxSearchesForProgress);
    if (progressValue < 0) progressValue = 1;
    print("progressValue $progressValue");

    Color progressColor;
    if (widget.searchesLeft <= 1) {
      progressColor = Colors.red;
    } else if (widget.searchesLeft <= maxSearchesForProgress ~/ 2) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.blue;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: widget.searchesLeft == 0
                  ? widget.type == 'guest'
                      ? 'guest_searches_used'.tr
                      : 'all_searches_used'.tr
                  : widget.type == 'guest'
                      ? 'guest_searches_used'.tr
                      : 'free_searches_used'.tr,
              color: widget.searchesLeft == 0 ? Colors.red : Colors.grey,
              fontSize: 14,
            ),
            AppText(
              text: maxSearches == -1
                  ? 'unlimited'.tr
                  : '${maxSearches - widget.searchesLeft}/$maxSearches',
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: widget.searchesLeft == 0 ? Colors.red : Colors.black87,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 8,
              width: MediaQuery.of(context).size.width * progressValue,
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    progressColor,
                    progressColor.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AppText(
          text: _getStatusMessage(widget.searchesLeft),
          color: progressColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  String _getStatusMessage(int searchesLeft) {
    if (widget.type == 'guest') {
      if (searchesLeft == 0) {
        return 'subs_status_msg_1'.tr;
      } else if (searchesLeft == 1) {
        return 'subs_status_msg_2'.tr;
      }
      return 'subs_status_msg_3'.tr;
    }

    if (searchesLeft == 0) {
      return 'subs_status_msg_4'.tr;
    } else if (searchesLeft <= 1) {
      return 'subs_status_msg_5'.tr;
    } else if (searchesLeft <= 3) {
      return 'subs_status_msg_6'.tr;
    }
    return 'subs_status_msg_7'.tr;
  }

  Widget _buildFeaturesGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildFeatureCard(
            icon: CustomSurffixIcon(svgIcon: "assets/icons/search.svg"),
            title: 'searches'.tr,
            value: widget.isPremium
                ? 'unlimited'.tr
                : '${maxSearches - widget.searchesLeft}/$maxSearches',
            iconColor: Colors.blue,
            iconBackgroundColor: Colors.blue.withValues(alpha: 0.1),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildFeatureCard(
            icon: CustomSurffixIcon(
              svgIcon: "assets/icons/car.svg",
            ),
            // icon: Icon(Icons.directions_car, color: const Color(0xFF4CAF50), size: 24),
            title: 'vehicles'.tr,
            value:
                widget.isPremium ? 'multiple'.tr : '${widget.totalVehicles}/1',
            iconColor: Colors.green,
            iconBackgroundColor: Colors.green.withValues(alpha: 0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required Widget icon,
    required String title,
    required String value,
    required Color iconColor,
    required Color iconBackgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: iconBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon(icon, color: iconColor, size: 24),
          icon,
          const SizedBox(height: 8),
          AppText(
            text: title,
            fontSize: 12,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 4),
          AppText(
            text: value,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradeButton() {
    if (widget.isPremium) return const SizedBox();
    return AppButton(
      text: '',
      appText: AppText(
        text: widget.type == 'guest'
            ? "login_signup".tr
            : "upgrade_to_premium".tr,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: kBgLightColor,
      ),
      height: 45,
      press: () async {
        if (widget.type == 'guest') {
          srvPageRoute.goNextWithGetx(const AuthScreen(isFromInnerApp: true));
        } else {
          PaywallResult resp =
              await RevenueCatUI.presentPaywall(displayCloseButton: true);
          if (resp == PaywallResult.purchased) {
            srvUser.user.isSubscribe = true;
            Get.find<MapController>().updateUser();
          }
        }
      },
      showLoader: false,
    );
  }
}
