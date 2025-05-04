import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestCameraPermission(BuildContext context) async {
    var status = await Permission.camera.status;

    if (status.isGranted) {
      log('Camera permission granted');
      return true;
    }

    if (status.isDenied) {
      PermissionStatus newStatus = await Permission.camera.request();

      if (newStatus.isGranted) {
        log('Camera permission granted after request');
        return true;
      } else if (newStatus.isPermanentlyDenied) {
        if (context.mounted) {
          _showSettingsDialog(context, "Camera permission permanently denied.");
        }
      } else {
        if (context.mounted) {
          _showInfoDialog(context, "Camera permission denied.");
        }
      }

      return false;
    }

    if (status.isPermanentlyDenied) {
      if (context.mounted) {
        _showSettingsDialog(context, "Camera permission permanently denied.");
        return false;
      }
    }

    if (status.isRestricted) {
      if (context.mounted) {
        _showInfoDialog(context, "Camera access is restricted on this device.");
        return false;
      }
    }

    if (status.isLimited) {
      if (context.mounted) {
        _showInfoDialog(context, "Camera access is limited.");
        return false;
      }
    }

    return false;
  }

  void _showSettingsDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog.adaptive(
        title: const Text("Permission Required"),
        content: Text("$message\nPlease enable it from Settings."),
        actions: [
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text("Open Settings"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Permission Info"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
