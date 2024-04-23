import 'package:flutter/material.dart';
import 'package:moticar/widgets/colors.dart';

import '../utils/agency_constants.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final passwordStrength = _calculatePasswordStrength(password);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 3, right: 3.0),
          child: LinearProgressIndicator(
            value: _getStrengthValue(passwordStrength),
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              _getStrengthColor(passwordStrength),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              _getStrengthText(passwordStrength),
              style: TextStyle(
                color: _getStrengthColor(passwordStrength),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  double _getStrengthValue(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 0.25;
      case PasswordStrength.normal:
        return 0.5;
      case PasswordStrength.good:
        return 0.75;
      case PasswordStrength.excellent:
        return 1.0;
    }
  }

  Color _getStrengthColor(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return Colors.red;
      case PasswordStrength.normal:
        return Colors.orange;
      case PasswordStrength.good:
        return Colors.green;
      case PasswordStrength.excellent:
        return AppColors.green;
    }
  }

  String _getStrengthText(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.normal:
        return 'Normal';
      case PasswordStrength.good:
        return 'Good';
      case PasswordStrength.excellent:
        return 'Excellent';
    }
  }

  PasswordStrength _calculatePasswordStrength(String password) {
    // You can implement your password strength logic here.
    // For simplicity, I'll just use the length for demonstration.
    final regExp = RegExp(passwordRegex);
    if (password.length < 4) {
      return PasswordStrength.weak;
    } else if (password.length < 8) {
      return PasswordStrength.normal;
    } else if (password.length < 12) {
      return PasswordStrength.good;
    }
    
     else {
      return PasswordStrength.excellent;
    }

     

     

  }
}

enum PasswordStrength { weak, normal, good, excellent }
