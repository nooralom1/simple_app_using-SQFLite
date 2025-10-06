// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_app/constants/text_font_style.dart';
import 'package:simple_app/feature/jobs/widget/job_container.dart';
import 'package:simple_app/helpers/database_helper.dart';

class SavedJobsScreen extends StatefulWidget {
  const SavedJobsScreen({super.key});

  @override
  _SavedJobsScreenState createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> savedJobs = [];

  @override
  void initState() {
    super.initState();
    _loadSavedJobs();
  }

  void _loadSavedJobs() async {
    final jobs = await _databaseHelper.getSavedJobs();
    setState(() {
      savedJobs = jobs;
    });
  }

  void _applyJob(int jobId) async {
    await _databaseHelper.markJobAsApplied(jobId);
    _loadSavedJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Jobs", style: TextFontStyle.text18c000000w600inter),
        centerTitle: true,
      ),
      body: savedJobs.isEmpty
          ? Center(
              child: Text(
                "You have no applied jobs yet",
                style: TextFontStyle.text18c000000w600inter.copyWith(
                  fontSize: 16.sp,
                ),
              ),
            )
          : ListView.builder(
              itemCount: savedJobs.length,
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                final job = savedJobs[index];
                final isApplied = job['isApplied'] == 1;

                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: JobContainer(
                    title: job['title'],
                    companyName: job['companyName'],
                    salary: "${job['salary']}\$",
                    location: job['location'],
                    isApplied: isApplied,
                    applyOnTap: () {
                      if (!isApplied) {
                        _applyJob(job['id']);
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
