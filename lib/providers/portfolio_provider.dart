import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/data/models/contact.dart';

import '../data/models/config.dart';
import '../data/repo/portfolio_repo.dart';
import '../utils/app_router.dart';
import '../utils/app_router_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortfolioProvider extends ChangeNotifier {
  final PortfolioRepo _portfolioRepo = PortfolioRepo();

  Project? selectedProject;
  selectProject(Project project) {
    selectedProject = project;
    notifyListeners();
    AppRouter.ctx.push(AppRouterConst.projectDetail); // ✅ Push instead of go
  }

  removeSelectedProject() {
    selectedProject = null;
    notifyListeners();
  }

  Config? config;

  Future<void> getConfig() async {
    final response = await _portfolioRepo.getConfig();
    if (response.data != null) {
      config = response.data;
      notifyListeners();
      // ignore: use_build_context_synchronously
      AppRouter.ctx.go(AppRouterConst.homePage);
      print('config fetched');
    } else {
      print('error fetching config ${response.error?.message}');
    }
  }

  Future<void> getTConfig() async {
    final response = await _portfolioRepo.getConfig();
    if (response.data != null) {
      config = response.data;
      notifyListeners();
      // ignore: use_build_context_synchronously
      print('config fetched');
    } else {
      print('error fetching config ${response.error?.message}');
    }
  }

  /// 🔹 Validate user input & check submission limit before posting
  Future<String?> postMsg(String name, String email, String msg) async {
    /// **1️⃣ Validate input fields**
    String? error = _validateInput(name, email, msg);
    if (error != null) {
      return error; // Return error message
    }

    /// **2️⃣ Check submission limit**
    if (!await _canSubmit()) {
      return "You have reached the submission limit for today. Try again tomorrow.";
    }

    /// **3️⃣ Save message if allowed**
    Contact body = Contact(name: name, email: email, msg: msg);
    final response = await _portfolioRepo.saveMessage(body);

    if (response.data != null) {
      await _incrementSubmissionCount(); // ✅ Update submission count
      return null; // ✅ No error, message saved successfully
    } else {
      return 'Error saving contact: ${response.error?.message ?? "Unknown error"}';
    }
  }

  /// **Helper Function: Validate Input Fields**
  String? _validateInput(String name, String email, String msg) {
    if (name.isEmpty || name.length < 2) {
      return "Name must be at least 2 characters long.";
    }
    if (email.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return "Please enter a valid email address.";
    }
    if (msg.isEmpty || msg.length < 10) {
      return "Message must be at least 10 characters long.";
    }
    return null; // ✅ No validation errors
  }

  /// **Helper Function: Check if user can submit**
  Future<bool> _canSubmit() async {
    final prefs = await SharedPreferences.getInstance();
    String todayKey = _getTodayKey();
    int submissionCount = prefs.getInt(todayKey) ?? 0;
    return submissionCount < 2; // ✅ Allow only 2 submissions per day
  }

  /// **Helper Function: Increment submission count**
  Future<void> _incrementSubmissionCount() async {
    final prefs = await SharedPreferences.getInstance();
    String todayKey = _getTodayKey();
    int submissionCount = prefs.getInt(todayKey) ?? 0;
    await prefs.setInt(todayKey, submissionCount + 1);
  }

  /// **Helper Function: Generate today's key for SharedPreferences**
  String _getTodayKey() {
    DateTime now = DateTime.now();
    return "submissions_${now.year}_${now.month}_${now.day}";
  }
}
