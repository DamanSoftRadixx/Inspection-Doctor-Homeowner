import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/model/network_model/property_list_response_model.dart';

class PropertyCard extends StatelessWidget {
  final PropertyListData property;
  void Function()? onTap;
  PropertyCard({
    Key? key,
    required this.property,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
        padding:
            EdgeInsets.only(left: 20.w, top: 15.h, right: 20.w, bottom: 14.h),
        decoration: decorationHome(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppTextWidget(
                    style: CustomTextTheme.heading3(
                        color: lightColorPalette.black),
                    text: property.propertyName ?? "",
                  ),
                ),
                Row(
                  children: [
                    property.latestUpdate == true
                        ? AssetWidget(
                            asset: Asset(
                              type: AssetType.svg,
                              path: ImageResource.updateIcon,
                            ),
                          ).paddingOnly(right: 10.w)
                        : const SizedBox(),
                    AssetWidget(
                      color: lightColorPalette.black,
                      asset: Asset(
                        type: AssetType.svg,
                        path: ImageResource.forwordArrow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                AssetWidget(
                  color: lightColorPalette.black,
                  asset: Asset(
                    type: AssetType.svg,
                    path: ImageResource.pinLocation,
                  ),
                ).paddingOnly(right: 5.w),
                Expanded(
                  child: AppTextWidget(
                    style: CustomTextTheme.normalText(
                        color: lightColorPalette.grey),
                    text: getAddressFormat(property),
                  ),
                ),
              ],
            ).paddingOnly(top: 12.h, bottom: 12.h),
            Divider(
              color: lightColorPalette.grey,
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AssetWidget(
                      color: lightColorPalette.black,
                      asset: Asset(
                        type: AssetType.svg,
                        path: ImageResource.hashLogo,
                      ),
                    ).paddingOnly(right: 5.w),
                    AppTextWidget(
                      style: CustomTextTheme.normalText(
                          color: lightColorPalette.grey),
                      text: property.lotNumber ?? "",
                    ),
                    AssetWidget(
                      color: lightColorPalette.black,
                      asset: Asset(
                        type: AssetType.svg,
                        path: ImageResource.hashLogo,
                      ),
                    ).paddingOnly(right: 5.w, left: 20.w),
                    AppTextWidget(
                      style: CustomTextTheme.normalText(
                          color: lightColorPalette.grey),
                      text: property.blockNumber ?? "",
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // AppTextWidget(
                    //   style: CustomTextTheme.normalText(
                    //       color: lightColorPalette.black),
                    //   text: '\u2022 ',
                    // ),
                    // AppTextWidget(
                    //   style: CustomTextTheme.normalText(
                    //       color: lightColorPalette.black),
                    //   text: "Scheduled",
                    // ),
                  ],
                ),
              ],
            ).paddingOnly(top: 12.h)
          ],
        ),
      ),
    );
  }
}
