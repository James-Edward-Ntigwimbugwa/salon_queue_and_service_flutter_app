import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final bool showRetryButton;

  const ErrorDisplay({
    Key? key,
    required this.message,
    this.onRetry,
    this.showRetryButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64.0,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 16.0),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            if (showRetryButton && onRetry != null) ...[
              const SizedBox(height: 16.0),
              CustomButton(
                onPressed: onRetry!,
                text: 'Try Again',
                width: 120,
                height: 40,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ErrorSnackBar extends SnackBar {
  ErrorSnackBar({
    Key? key,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) : super(
          key: key,
          content: Row(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 24.0,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          duration: duration,
        );
}
