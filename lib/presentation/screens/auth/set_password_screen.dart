import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/presentation/controllers/set_password_controller.dart';
import 'package:project_task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:project_task_manager/presentation/widget/background_widget.dart';
import 'package:project_task_manager/presentation/widget/snack_bar_message.dart';
import 'package:project_task_manager/presentation/widget/text_field_validator.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SetPasswordController _setPasswordController =
      Get.find<SetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Text(
                    "Set Password",
                    style: Get.theme.textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "Minimum length password 8 character with Letter and number combination",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (value) =>
                        TextFieldValidator.passwordValidator(value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      hintText: "Confirm Password",
                    ),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<SetPasswordController>(
                        builder: (setPasswordController) {
                      return Visibility(
                        visible: setPasswordController.inProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _resetPassword(_passwordController.text.trim());
                            }
                          },
                          child: const Text("Confirm"),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offUntil(
                              GetPageRoute(page: () => const SignInScreen()),
                              (route) => false);
                        },
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _resetPassword(String password) async {
    final result = await _setPasswordController.getPasswordController(password);

    if (result) {
      Get.offUntil(
          GetPageRoute(page: () => const SignInScreen()), (route) => false);
    } else {
      showSnackBarMessage(_setPasswordController.errorMessage);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }
}
