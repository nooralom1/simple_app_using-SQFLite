// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_app/constants/text_font_style.dart';
import 'package:simple_app/feature/jobs/widget/job_container.dart';
import 'package:simple_app/helpers/all_routes.dart';
import 'package:simple_app/helpers/database_helper.dart';
import 'package:simple_app/helpers/navigation_service.dart';
import 'package:simple_app/networks/api_access.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  Map<int, bool> appliedJobs = {};

  @override
  void initState() {
    super.initState();
    getJobListRXOBJ.getJobListRX();
  }

  void _applyJob(
    int id,
    String title,
    String companyName,
    String salary,
    String location,
  ) async {
    final jobData = {
      'id': id,
      'title': title,
      'companyName': companyName,
      'salary': salary,
      'location': location,
      'isApplied': 1,
    };

    await _databaseHelper.saveJob(jobData);
    await _databaseHelper.markJobAsApplied(id);

    setState(() {
      appliedJobs[id] = true;
    });
  }

  Future<bool> _checkIfApplied(int jobId) async {
    bool isApplied = await _databaseHelper.isJobApplied(jobId);
    return isApplied;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs", style: TextFontStyle.text18c000000w600inter),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: getJobListRXOBJ.dataFetcher,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.hasData) {
            final data = snapshot.data?.products;
            return ListView.builder(
              itemCount: data?.length,
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                final products = data?[index];
                final jobId = products?.id ?? 0;

                bool isApplied = appliedJobs[jobId] ?? false;

                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: JobContainer(
                    title: products?.title ?? "",
                    companyName: products?.brand ?? "",
                    salary: "${products?.price}\$",
                    location: products?.sku ?? "",
                    isApplied: isApplied,
                    viewDetailsTap: () {
                      NavigationService.navigateToWithArgs(Routes.jobDetails, {
                        "title": products?.title ?? "",
                        "description": products?.description ?? "",
                        "thumnail": products?.thumbnail ?? "",
                        "company": products?.brand ?? "",
                        "sellary": "${products?.price}",
                        "location": products?.sku ?? "",
                      });
                    },
                    applyOnTap: () {
                      if (!isApplied) {
                        _applyJob(
                          jobId,
                          products?.title ?? "",
                          products?.brand ?? "",
                          "${products?.price}",
                          products?.sku ?? "",
                        );
                      }
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No Data Available"));
          }
        },
      ),
    );
  }
}
