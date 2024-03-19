import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_task_manager/data/models/user_data.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';
import 'package:project_task_manager/presentation/controllers/auth_controller.dart';
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
  XFile? _imagePicked;
  bool _profileUpdateInProgress = false;

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
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 24),
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
                    child: Visibility(
                      visible: _profileUpdateInProgress == false,
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
                    ),
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
    return GestureDetector(
      onTap: () {
        imagePickFromGallery();
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
                _imagePicked?.name ?? '',
                maxLines: 1,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> imagePickFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    _imagePicked = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  Future<void> _updateProfile() async {
    String? photo;
    _profileUpdateInProgress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "email": _emailController.text,
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _moblieNumberController.text.trim(),
    };

    if (_passwordInputController.text.isNotEmpty) {
      inputParams["password"] = _passwordInputController.text;
    }

    if (_imagePicked != null) {
      List<int> bytes = File(_imagePicked!.path).readAsBytesSync();
      String photo = base64Encode(bytes);
      inputParams["photo"] = photo;
    }
    final response =
        await NetworkCaller.postRequest(Urls.updateProfileUrl, inputParams);

    _profileUpdateInProgress = false;

    if (response.isSucess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
          email: _emailController.text,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          mobile: _moblieNumberController.text.trim(),
          photo: photo,
        );

        await AuthController.saveUserData(userData);
      }
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MainBottomNavScreen()),
            (route) => false);
      }
    } else {
      if (!mounted) {
        return;
      }
      setState(() {});
      showSnackBarMessage(context, 'Update Profile failed! Try again');
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
