import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';
import 'package:new_trip_start/constants.dart';
import 'package:new_trip_start/controllers/tab_ctrl.dart';
import 'package:new_trip_start/modals/bottom_modal.dart';
import 'package:new_trip_start/models/vehicle.model.dart';

class VechicleItem extends StatelessWidget {
  const VechicleItem({super.key, required this.vehicle});
  final Vehicle vehicle;
  @override
  Widget build(BuildContext context) {
    BottomTabController btmTabCtrl = Get.find();
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: kBgLightColor,
          boxShadow: boxShadow(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12)),
              child: const Center(
                child: CustomSurffixIcon(
                    size: 27,
                    // color: Color(0xFF),
                    svgIcon: 'assets/icons/tab-selected-vehicles.svg'),
              ),
            ),
            const CustomSpacer(spaceValue: 5),
            // Flexible(
            //   fit: FlexFit.loose,
            //   flex: 3,
            //   child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '${vehicle.regNum!.toUpperCase()} - ',
                        style: const TextStyle(
                            fontFamily: 'Avenir',
                            // fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: kBlackColor),
                      ),
                      TextSpan(
                        text: vehicle.vehBrand,
                        style: const TextStyle(
                          color: kTextColor,
                          fontFamily: 'Avenir',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(
                      color: const Color(0xFFDDFFE2),
                      borderRadius: BorderRadius.circular(50)),
                  child: AppText(
                    text:
                        '${double.parse(vehicle.vehFuelCmp!) / 10} Liter per 10 km',
                    fontSize: 12,
                    color: const Color(0xFF387C37),
                  ),
                )
              ],
            ),
            // ),
            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    AppBottomModal().confirmBottomSheet(context, () {
                      btmTabCtrl.deleteVehicle(vehicle.docId!, context);
                    });
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 240, 231),
                        borderRadius: BorderRadius.circular(7)),
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.delete,
                        size: 15,
                        color: Color(0xFFDA4C4C),
                      ),
                    ),
                  ),
                ),
                const CustomSpacer(spaceValue: 4),
                GestureDetector(
                  onTap: () {
                    AppBottomModal()
                        .addVehicleModal(context, () {}, true, vehicle);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(7)),
                    child: const Center(
                      child: Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
