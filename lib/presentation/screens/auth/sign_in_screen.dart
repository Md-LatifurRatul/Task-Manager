import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/presentation/controllers/sign_in_controller.dart';
import 'package:project_task_manager/presentation/screens/auth/email_verification_screen.dart';
import 'package:project_task_manager/presentation/screens/auth/sign_up_screen.dart';
import 'package:project_task_manager/presentation/screens/main_bottom_nav_screen.dart';
import 'package:project_task_manager/presentation/widget/background_widget.dart';
import 'package:project_task_manager/presentation/widget/snack_bar_message.dart';
import 'package:project_task_manager/presentation/widget/text_field_validator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignInController _signInController = Get.find<SignInController>();

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
                    height: 160,
                  ),
                  Text(
                    "Get Started With",
                    style: Get.theme.textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                    validator: ((value) => TextFieldValidator.textValidator(
                        value, "Enter your email adress")),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                      validator: (value) =>
                          TextFieldValidator.passwordValidator(value)),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<SignInController>(
                      builder: (signInConroller) {
                        return Visibility(
                          visible: signInConroller.inProgres == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _signIn();
                              }
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => const EmailVerificationScreen());
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const SignUpScreen());
                        },
                        child: const Text('Sign up'),
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

  Future<void> _signIn() async {
    final result = await _signInController.signIn(
        _emailController.text.trim(), _passwordController.text);

    if (result) {
      Get.offUntil(GetPageRoute(page: () => const MainBottomNavScreen()),
          (route) => false);
    } else {
      showSnackBarMessage(_signInController.errorMessage);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
}
