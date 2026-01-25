import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/common/widgets/appbar.dart';
import 'package:mobileapp/common/widgets/profile_banner.dart';
import 'package:mobileapp/common/widgets/text_input.dart';
import 'package:mobileapp/lang/translation_service_key.dart';
import 'package:mobileapp/utils/app_text.dart';
import 'package:mobileapp/utils/app_util.dart';
import 'package:mobileapp/utils/app_util_constants.dart';
import '../controller/profile_controller.dart';

class EditPersonOfContactScreen extends StatefulWidget {
  const EditPersonOfContactScreen({super.key});

  @override
  State<EditPersonOfContactScreen> createState() =>
      _EditPersonOfContactScreenState();
}

class _EditPersonOfContactScreenState extends State<EditPersonOfContactScreen> {
  final ProfileController controller = Get.find();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupListeners();
  }

  void _initializeControllers() {
    controller.mUserNameController.value.text = controller.pocFirstName.value;
    controller.mEmailController.value.text = controller.pocEmailId.value;
    controller.mPhoneNoController.value.text = controller.pocPhoneNumber.value;

    // Initialize child controllers
    controller.mChild1Controller.value.text = controller.child1.value;
    controller.mChild2Controller.value.text = controller.child2.value;
    controller.mChild3Controller.value.text = controller.child3.value;
    controller.mChild4Controller.value.text = controller.child4.value;

    controller.setValidator();
  }

  void _setupListeners() {
    // Add listeners to update the observable values when text changes
    controller.mChild1Controller.value.addListener(() {
      // This ensures the controller text is synced
    });
    controller.mChild2Controller.value.addListener(() {
      // This ensures the controller text is synced
    });
    controller.mChild3Controller.value.addListener(() {
      // This ensures the controller text is synced
    });
    controller.mChild4Controller.value.addListener(() {
      // This ensures the controller text is synced
    });
  }

  // Validation methods
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return namerequired;
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < 2) {
      return nameMustBe;
    }

    if (trimmedValue.length > 50) {
      return namelong;
    }

    // Check if it contains only letters and spaces
    if (!RegExp(
      AppUtilConstants.patternStringAndSpace,
    ).hasMatch(trimmedValue)) {
      return letterspace;
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return sEmailErrorValid;
    }

    final trimmedValue = value.trim();

    // Basic email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(trimmedValue)) {
      return sEmailErrorValid;
    }

    if (trimmedValue.length < 5) {
      return 'Email is too short';
    }

    if (trimmedValue.length > 254) {
      return 'Email is too long';
    }

    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return sPhoneNumberError;
    }

    final trimmedValue = value.trim();

    // Check if it contains only numbers
    if (!RegExp(AppUtilConstants.patternOnlyNumber).hasMatch(trimmedValue)) {
      return 'Phone number can only contain numbers';
    }

    if (trimmedValue.length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    if (trimmedValue.length > 11) {
      return 'Phone number cannot exceed 11 digits';
    }

    return null;
  }

  void _validateAndUpdate() {
    bool hasErrors = false;

    // Validate name
    final nameError = _validateName(controller.mUserNameController.value.text);
    if (nameError != null) {
      controller.userNameValidator.value = true;
      hasErrors = true;
    } else {
      controller.userNameValidator.value = false;
    }

    // Validate email
    final emailError = _validateEmail(controller.mEmailController.value.text);
    if (emailError != null) {
      controller.emailValidator.value = true;
      controller.seEmailValidator.value = emailError;
      hasErrors = true;
    } else {
      controller.emailValidator.value = false;
      controller.seEmailValidator.value = '';
    }

    // Validate phone number
    final phoneError = _validatePhoneNumber(
      controller.mPhoneNoController.value.text,
    );
    if (phoneError != null) {
      controller.phoneNumberValidator.value = true;
      controller.sePhoneNumberValidator.value = phoneError;
      hasErrors = true;
    } else {
      controller.phoneNumberValidator.value = false;
      controller.sePhoneNumberValidator.value = '';
    }

    if (!hasErrors) {
      // Update child values with current text (including empty strings)
      controller.child1.value = controller.mChild1Controller.value.text.trim();
      controller.child2.value = controller.mChild2Controller.value.text.trim();
      controller.child3.value = controller.mChild3Controller.value.text.trim();
      controller.child4.value = controller.mChild4Controller.value.text.trim();

      controller.isPersonOfContactCheck();
    } else {
      Get.snackbar(
        'Validation Error',
        'Please correct the errors in the form',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.r),
        borderRadius: 12.r,
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => AppUtils.hideKeyboard(Get.context!),
        child: Container(
          width: 1.sw,
          height: 1.sh,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.cAppColors,
                Colors.grey.shade100,
                Colors.grey.shade100,
                AppColors.cAppColors,
              ],
            ),
          ),
          child: Column(
            children: [
              const CustomAppBar(title: 'Edit Family Information'),
              SizedBox(height: 20.h),
              _buildProfileHeader(),
              SizedBox(height: 20.h),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _formContent(),
                        SizedBox(height: 30.h),
                        _updateButton(),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildProfileHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 100.w),
      child: CompactBannerCard(
        bannerUrl: '',
        height: 90,
        borderRadius: 16,
        imagePadding: 4,
        imageHeightRatio: 1.7,
        showDecorationCircles: true, // Circles will stay inside border
      ),
    );
  }
  Widget _formContent() {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Spouse Details'),
            SizedBox(height: 16.h),

            /// Name
            _buildInputField(
              label: 'Name',
              controller: controller.mUserNameController.value,
              errorText: controller.userNameValidator.isTrue
                  ? _validateName(controller.mUserNameController.value.text)
                  : null,
              icon: Icons.person_outline,
              hint: sUserNameHint.tr,
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(AppUtilConstants.patternStringAndSpace),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            /// Email
            _buildInputField(
              label: 'Email',
              controller: controller.mEmailController.value,
              errorText: controller.emailValidator.isTrue
                  ? controller.seEmailValidator.value
                  : null,
              icon: Icons.email_outlined,
              hint: sEmailHint.tr,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.h),

            /// Phone Number
            _buildInputField(
              label: 'Phone Number',
              controller: controller.mPhoneNoController.value,
              errorText: controller.phoneNumberValidator.isTrue
                  ? controller.sePhoneNumberValidator.value
                  : null,
              icon: Icons.phone_outlined,
              hint: sPhoneNumberHint.tr,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(AppUtilConstants.patternOnlyNumber),
                ),
              ],
              maxLength: 11,
            ),

            SizedBox(height: 30.h),
            _buildSectionTitle('Children Details'),
            SizedBox(height: 16.h),

            _buildInputField(
              label: 'Child One (Name / Age)',
              controller: controller.mChild1Controller.value,
              errorText: null,
              icon: Icons.child_care_outlined,
              hint: 'e.g., Alex / 10',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20.h),
            _buildInputField(
              label: 'Child Two (Name / Age)',
              controller: controller.mChild2Controller.value,
              errorText: null,
              icon: Icons.child_care_outlined,
              hint: 'e.g., Sammy / 12',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20.h),
            _buildInputField(
              label: 'Child Three (Name / Age)',
              controller: controller.mChild3Controller.value,
              errorText: null,
              icon: Icons.child_care_outlined,
              hint: 'e.g., John / 8',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20.h),

            /// Child 4
            _buildInputField(
              label: 'Child Four (Name / Age)',
              controller: controller.mChild4Controller.value,
              errorText: null,
              icon: Icons.child_care_outlined,
              hint: 'e.g., Maria / 15',
              keyboardType: TextInputType.text,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: AppColors.cAppColors,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: getTextSemiBold(size: 16.sp, colors: Colors.grey.shade800),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    required TextInputType keyboardType,
    String? errorText,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // NO WRAPPER CONTAINER - Let TextInputWidget handle its own styling
        TextInputWidget(
          placeHolder: label,
          controller: controller,
          errorText: null, // Handle error outside
          textInputType: keyboardType,
          hintText: hint,
          showFloatingLabel: true,
          prefixIcon: icon,
          onFilteringTextInputFormatter: inputFormatters,
          maxCharLength: maxLength,
          borderColor: errorText != null
              ? AppColors.error.withValues(alpha: 0.5)
              : null, // Show red border on error
        ),
        if (errorText != null) ...[
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Row(
              children: [
                Icon(Icons.error_outline, size: 14.sp, color: AppColors.error),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    errorText,
                    style: getTextMedium(size: 12.sp, colors: AppColors.error),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _updateButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cAppColors,
          elevation: 2,
          shadowColor: AppColors.cAppColors.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        onPressed: _validateAndUpdate,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 8.w),
            Text(
              "Update Profile",
              style: getTextSemiBold(colors: Colors.white, size: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
