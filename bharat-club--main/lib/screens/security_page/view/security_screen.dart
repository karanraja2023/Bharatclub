// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:mobileapp/app/routes_name.dart';
// import 'package:mobileapp/app_theme/theme/app_theme.dart';
// import 'package:mobileapp/screens/security_page/controller/security_controller.dart';

// class PinEntryOverlay extends StatefulWidget {
//   const PinEntryOverlay({Key? key}) : super(key: key);

//   @override
//   State<PinEntryOverlay> createState() => _PinEntryOverlayState();
// }

// class _PinEntryOverlayState extends State<PinEntryOverlay> {
//   final PinController pinController = Get.find<PinController>();

//   final List<TextEditingController> _controllers = List.generate(
//     4,
//     (_) => TextEditingController(),
//   );
//   final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

//   // For confirm PIN when setting new PIN
//   final List<TextEditingController> _confirmControllers = List.generate(
//     4,
//     (_) => TextEditingController(),
//   );
//   final List<FocusNode> _confirmFocusNodes = List.generate(
//     4,
//     (_) => FocusNode(),
//   );

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _focusNodes[0].requestFocus();
//     });
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     for (var node in _focusNodes) {
//       node.dispose();
//     }
//     for (var controller in _confirmControllers) {
//       controller.dispose();
//     }
//     for (var node in _confirmFocusNodes) {
//       node.dispose();
//     }
//     super.dispose();
//   }

//   void _onPinChanged(String value, int index, {bool isConfirm = false}) {
//     if (value.isNotEmpty) {
//       final focusNodes = isConfirm ? _confirmFocusNodes : _focusNodes;

//       if (index < 3) {
//         focusNodes[index + 1].requestFocus();
//       } else {
//         focusNodes[index].unfocus();
//         if (isConfirm) {
//           // When confirm PIN is complete, validate it
//           _validateConfirmPin();
//         } else if (pinController.showConfirmPin.value) {
//           // Move to confirm PIN field
//           _confirmFocusNodes[0].requestFocus();
//         } else {
//           // Validate main PIN (either first time setup or verification)
//           _validateAndProceed();
//         }
//       }
//     }
//   }

//   void _validateAndProceed() async {
//     String pin = _controllers.map((c) => c.text).join();

//     if (pin.length != 4) {
//       _showError('Please enter a 4-digit PIN');
//       return;
//     }

//     // If PIN is not set yet, this is first time - show confirm PIN
//     if (!pinController.isPinSet.value) {
//       pinController.initialPin.value = pin;
//       pinController.showConfirmPin.value = true;

//       // Focus on confirm PIN field
//       Future.delayed(const Duration(milliseconds: 100), () {
//         _confirmFocusNodes[0].requestFocus();
//       });
//       return;
//     }

//     // If PIN is already set, verify it
//     final isCorrect = await pinController.verifyPin(pin);

//     if (isCorrect) {
//       Get.back();
//       Get.toNamed(AppRoutes.qrCodeScanScreen);
//     } else {
//       _showError('Incorrect PIN. Please try again.');
//       _clearAllFields();
//     }
//   }

//   void _validateConfirmPin() async {
//     String confirmPin = _confirmControllers.map((c) => c.text).join();

//     if (confirmPin.length != 4) {
//       _showError('Please enter a 4-digit PIN');
//       return;
//     }

//     if (pinController.initialPin.value != confirmPin) {
//       _showError('PINs do not match. Please try again.');
//       _clearAllFields();
//       pinController.showConfirmPin.value = false;
//       pinController.initialPin.value = '';
//       _focusNodes[0].requestFocus();
//       return;
//     }

//     // Save the PIN
//     final success = await pinController.savePin(pinController.initialPin.value);

//     if (success) {
//       // First time PIN setup - just close dialog and show success
//       Get.back();
//       Get.snackbar(
//         'Success',
//         'PIN set successfully!',
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.green.shade100,
//         colorText: Colors.green.shade900,
//         margin: EdgeInsets.all(16.r),
//         borderRadius: 12.r,
//         duration: const Duration(seconds: 2),
//         icon: Icon(Icons.check_circle, color: Colors.green.shade900),
//       );
//       // Reset the confirm PIN state
//       pinController.showConfirmPin.value = false;
//       pinController.initialPin.value = '';
//     } else {
//       _showError('Failed to save PIN. Please try again.');
//       _clearAllFields();
//       pinController.showConfirmPin.value = false;
//       pinController.initialPin.value = '';
//     }
//   }

//   void _clearAllFields() {
//     for (var controller in _controllers) {
//       controller.clear();
//     }
//     for (var controller in _confirmControllers) {
//       controller.clear();
//     }
//     _focusNodes[0].requestFocus();
//   }

//   void _showError(String message) {
//     for (var controller in _controllers) {
//       controller.clear();
//     }
//     for (var controller in _confirmControllers) {
//       controller.clear();
//     }
//     _focusNodes[0].requestFocus();

//     Get.snackbar(
//       'Invalid PIN',
//       message,
//       snackPosition: SnackPosition.TOP,
//       backgroundColor: Colors.red.shade100,
//       colorText: Colors.red.shade900,
//       margin: EdgeInsets.all(16.r),
//       borderRadius: 12.r,
//       duration: const Duration(seconds: 2),
//       icon: Icon(Icons.error_outline, color: Colors.red.shade900),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildHeader(),
//               _buildPinFields(),
//               Obx(
//                 () => pinController.showConfirmPin.value
//                     ? _buildConfirmPinFields()
//                     : const SizedBox.shrink(),
//               ),
//               _buildActionButtons(),
//               SizedBox(height: 16.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 20.h),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [AppColors.cAppColors, AppColors.cAppColors.withOpacity(0.8)],
//         ),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20.r),
//           topRight: Radius.circular(20.r),
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const SizedBox(width: 40),
//               Expanded(
//                 child: Obx(
//                   () => Text(
//                     pinController.isPinSet.value ? 'Enter PIN' : 'Set New PIN',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               IconButton(
//                 onPressed: () => Get.back(),
//                 icon: const Icon(Icons.close, color: Colors.white),
//                 iconSize: 24.sp,
//               ),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           Obx(
//             () => Text(
//               pinController.isPinSet.value
//                   ? 'Enter your 4-digit PIN to access scanner'
//                   : pinController.showConfirmPin.value
//                   ? 'Confirm your 4-digit PIN'
//                   : 'Create a 4-digit PIN for security',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 13.sp,
//                 color: Colors.white.withOpacity(0.9),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPinFields() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
//       child: Column(
//         children: [
//           Obx(
//             () =>
//                 !pinController.isPinSet.value &&
//                     !pinController.showConfirmPin.value
//                 ? Padding(
//                     padding: EdgeInsets.only(bottom: 12.h),
//                     child: Text(
//                       'Enter PIN',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey.shade700,
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: List.generate(
//               4,
//               (index) => _buildPinBox(index, isConfirm: false),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildConfirmPinFields() {
//     return Padding(
//       padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 24.h),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(bottom: 12.h),
//             child: Text(
//               'Confirm PIN',
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey.shade700,
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: List.generate(
//               4,
//               (index) => _buildPinBox(index, isConfirm: true),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPinBox(int index, {required bool isConfirm}) {
//     final controllers = isConfirm ? _confirmControllers : _controllers;
//     final focusNodes = isConfirm ? _confirmFocusNodes : _focusNodes;

//     return Container(
//       width: 60.w,
//       height: 60.h,
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(
//           color: focusNodes[index].hasFocus
//               ? AppColors.cAppColors
//               : Colors.grey.shade300,
//           width: 2,
//         ),
//         boxShadow: focusNodes[index].hasFocus
//             ? [
//                 BoxShadow(
//                   color: AppColors.cAppColors.withOpacity(0.3),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ]
//             : [],
//       ),
//       child: TextField(
//         controller: controllers[index],
//         focusNode: focusNodes[index],
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         obscureText: true,
//         obscuringCharacter: '●',
//         style: TextStyle(
//           fontSize: 24.sp,
//           fontWeight: FontWeight.bold,
//           color: Colors.grey.shade800,
//         ),
//         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//         decoration: const InputDecoration(
//           counterText: '',
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.zero,
//         ),
//         onChanged: (value) => _onPinChanged(value, index, isConfirm: isConfirm),
//         onTap: () {
//           // Clear field on tap
//           controllers[index].clear();
//         },
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 24.w),
//       child: Obx(
//         () => SizedBox(
//           width: double.infinity,
//           height: 50.h,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.cAppColors,
//               elevation: 2,
//               shadowColor: AppColors.cAppColors.withOpacity(0.4),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//             ),
//             onPressed: pinController.isLoading.value
//                 ? null
//                 : () {
//                     if (pinController.showConfirmPin.value) {
//                       _validateConfirmPin();
//                     } else {
//                       _validateAndProceed();
//                     }
//                   },
//             child: pinController.isLoading.value
//                 ? SizedBox(
//                     height: 20.h,
//                     width: 20.w,
//                     child: const CircularProgressIndicator(
//                       strokeWidth: 2,
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   )
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         pinController.isPinSet.value
//                             ? Icons.lock_open
//                             : pinController.showConfirmPin.value
//                             ? Icons.check_circle_outline
//                             : Icons.lock_outline,
//                         color: Colors.white,
//                       ),
//                       SizedBox(width: 8.w),
//                       Text(
//                         pinController.isPinSet.value
//                             ? 'Verify PIN'
//                             : pinController.showConfirmPin.value
//                             ? 'Confirm PIN'
//                             : 'Set PIN',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// void showPinEntryPopup() {
//   // Ensure controller is initialized
//   if (!Get.isRegistered<PinController>()) {
//     Get.put(PinController());
//   }

//   Get.dialog(
//     const PinEntryOverlay(),
//     barrierDismissible: false,
//     barrierColor: Colors.black54,
//   );
// }