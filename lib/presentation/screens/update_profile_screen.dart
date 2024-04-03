import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/presentation/controllers/auth_controller.dart';
import 'package:project_task_manager/presentation/controllers/image_picker_controller.dart';
import 'package:project_task_manager/presentation/controllers/profile_update_controller.dart';
import 'package:project_task_manager/presentation/controllers/update_task_controller.dart';
import 'package:project_task_manager/presentation/screens/main_bottom_nav_screen.dart';
import 'package:project_task_manager/presentation/widget/background_widget.dart';
import 'package:project_task_manager/presentation/widget/profile_app_bar.dart';
import 'package:project_task_manager/presentation/widget/snack_bar_message.dart';
import 'package:project_task_manager/presentation/widget/text_field_validator.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _moblieNumberController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePickerController _imagePickerController =
      Get.find<ImagePickerController>();
  final ProfileUpdateController _profileUpdateController =
      Get.find<ProfileUpdateController>();
  final UpdateTaskController updateTaskController =
      Get.find<UpdateTaskController>();

  @override
  void initState() {
    super.initState();
    _emailController.text = AuthController.userData?.email ?? '';
    _firstNameController.text = AuthController.userData?.firstName ?? '';
    _lastNameController.text = AuthController.userData?.lastName ?? '';
    _moblieNumberController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar,
      body: BackGroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 48),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  Text(
                    'Update Profile',
                    style:
                        Get.theme.textTheme.titleLarge?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  imageSelectTapped(),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    validator: (value) => TextFieldValidator.textValidator(
                        value, 'First Name should not be empty'),
                    decoration: const InputDecoration(
                      hintText: "First name",
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    validator: (value) => TextFieldValidator.textValidator(
                        value, 'Last Name should not be empty'),
                    decoration: const InputDecoration(
                      hintText: "Last name",
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    validator: (value) => TextFieldValidator.textValidator(
                        value, 'Mobile number should not be empty'),
                    controller: _moblieNumberController,
                    decoration: const InputDecoration(
                      hintText: "Moblie",
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _passwordInputController,
                    decoration: const InputDecoration(
                      hintText: "Password(Optional)",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<ProfileUpdateController>(
                        builder: (profileUpdateController) {
                      return Visibility(
                        visible: profileUpdateController.inProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _updateProfile();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageSelectTapped() {
    return GetBuilder<ImagePickerController>(builder: (imagePickerController) {
      return GestureDetector(
        onTap: () async {
          await imagePickerController.getImagePickedFromGallery();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                ),
                child: const Text(
                  'Photo',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  imagePickerController.pickedImage?.name ?? '',
                  maxLines: 1,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _updateProfile() async {
    final result = await _profileUpdateController.getUpdateProfileController(
      _emailController.text,
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
      _moblieNumberController.text.trim(),
      _passwordInputController.text,
      _imagePickerController.pickedImage,
    );

    if (result) {
      Get.offUntil(
          GetPageRoute(
            page: () => const MainBottomNavScreen(),
          ),
          (route) => false);
    } else {
      showSnackBarMessage(_profileUpdateController.errorMessage);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _moblieNumberController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }
}
