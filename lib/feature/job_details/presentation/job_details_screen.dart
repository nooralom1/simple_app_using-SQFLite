import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_app/constants/text_font_style.dart';
import 'package:simple_app/gen/assets.gen.dart';
import 'package:simple_app/gen/colors.gen.dart';
import 'package:simple_app/helpers/navigation_service.dart';
import 'package:simple_app/helpers/ui_helpers.dart';

class JobDetailsScreen extends StatefulWidget {
  final String thumnail;
  final String title;
  final String description;
  final String company;
  final String sellary;
  final String location;
  const JobDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.thumnail,
    required this.company,
    required this.sellary,
    required this.location,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            NavigationService.goBack;
          },
          child: Icon(Icons.arrow_back, color: AppColors.c000000),
        ),
        title: Text("Job Details", style: TextFontStyle.text18c000000w600inter),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ////////////////////------- Job Image/Thumnail ---------//////////////
            CachedNetworkImage(
              placeholder: (context, url) {
                return Image.asset(
                  Assets.images.loadingIcon.path,
                  width: double.infinity,
                  height: 298.h,
                  fit: BoxFit.fill,
                );
              },
              errorWidget: (context, url, error) {
                return Image.asset(
                  Assets.images.noImageAvailableIconVector.path,
                  width: double.infinity,
                  height: 298.h,
                  fit: BoxFit.fill,
                );
              },
              imageUrl: widget.thumnail,
              width: double.infinity,
              height: 298.h,
              fit: BoxFit.fill,
            ),

            UIHelper.verticalSpace(24.h),
            ////////////////////------- Job Overview ---------//////////////
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: const Color(0xFF222237),
                      fontSize: 20.sp,
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.10.h,
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                  Row(
                    children: [
                      Text(
                        "Company:",
                        style: TextStyle(
                          color: const Color(0xFF222237),
                          fontSize: 16.sp,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w600,
                          height: 1.10.h,
                        ),
                      ),
                      UIHelper.horizontalSpace(4.h),
                      Text(
                        widget.company,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w500,
                          height: 1.10.h,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(16.h),
                  Row(
                    children: [
                      Text(
                        "Salary:",
                        style: TextStyle(
                          color: const Color(0xFF222237),
                          fontSize: 16.sp,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w600,
                          height: 1.10.h,
                        ),
                      ),
                      UIHelper.horizontalSpace(4.h),
                      Text(
                        "${widget.sellary} \$",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w500,
                          height: 1.10.h,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(16.h),
                  Row(
                    children: [
                      Text(
                        "Location:",
                        style: TextStyle(
                          color: const Color(0xFF222237),
                          fontSize: 16.sp,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w600,
                          height: 1.10.h,
                        ),
                      ),
                      UIHelper.horizontalSpace(4.h),
                      Text(
                        widget.location,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w500,
                          height: 1.10.h,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(16.h),
                  ////////////////////------- Descriptions ---------//////////////
                  Text(
                    "Description:",
                    style: TextStyle(
                      color: const Color(0xFF222237),
                      fontSize: 16.sp,
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.10.h,
                    ),
                  ),
                  UIHelper.verticalSpace(6.h),
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: const Color(0xFF222237),
                      fontSize: 14.sp,
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.10.h,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                ],
              ),
            ),
            UIHelper.verticalSpace(32.h),
          ],
        ),
      ),
    );
  }
}
