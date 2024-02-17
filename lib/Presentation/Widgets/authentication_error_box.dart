import 'package:flutter/Material.dart';
import 'package:twseela_driver/Presentation/Resources/values_manager.dart';

class AuthenticationErrorBox extends StatelessWidget {
  final String message;
  const AuthenticationErrorBox({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.s10),
      decoration: BoxDecoration(
          color: Colors.red[AppSizes.s100.toInt()],
          borderRadius: BorderRadius.circular(AppSizes.s10),
          border: Border.all(color: Colors.red)),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
          const SizedBox(
            width: AppSizes.s8,
          ),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
