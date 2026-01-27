import 'dart:io';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/common/widgets/appbar.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../../../utils/app_text.dart';
import '../controller/qr_code_generate_controller.dart';

// class ScanQrCodeScreen extends StatefulWidget {
//   const ScanQrCodeScreen({Key? key}) : super(key: key);
//
//   @override
//   _ScanQrCodeScreenState createState() => _ScanQrCodeScreenState();
// }
//
// class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
//   String searchKeyword = "";
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   bool isProcessing = false;
//   bool isCameraInitialized = false; // Track camera initialization
//
//   @override
//   void initState() {
//     super.initState();
//     if (!Get.isRegistered<QrCodeGenerateController>()) {
//       Get.put(QrCodeGenerateController());
//     }
//   }
//
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (isCameraInitialized && controller != null) {
//       if (Platform.isAndroid) {
//         controller?.pauseCamera();
//       } else if (Platform.isIOS) {
//         controller?.resumeCamera();
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         _cleanupCamera();
//         Get.back(result: "");
//         return false;
//       },
//       child: Scaffold(
//         appBar: CustomAppBar(title: "Qr Scanner"),
//         body: SafeArea(child: _buildTrainerListView()),
//       ),
//     );
//   }
//
//   Widget _buildTrainerListView() {
//     return FocusDetector(
//       onVisibilityGained: () {
//         isProcessing = false;
//         if (isCameraInitialized && controller != null) {
//           controller?.resumeCamera();
//         }
//       },
//       onVisibilityLost: () {
//         if (isCameraInitialized && controller != null) {
//           controller?.pauseCamera();
//         }
//       },
//       child: GetBuilder<QrCodeGenerateController>(
//         builder: (qrController) {
//           return Container(
//             color: AppColors.white,
//             child: qrController.isLoading.value
//                 ? const Center(
//                     child: CircularProgressIndicator(
//                       strokeWidth: 8.0,
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   )
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(child: _buildQrView(context)),
//                       Container(
//                         margin: EdgeInsets.only(left: 20.sp,right: 20.sp,top: 10.sp,bottom: 10.sp),
//                         child: InkWell(
//                           onTap: () {
//                             qrController.getUploadFile();
//                           },
//                           child: Container(
//                             padding: EdgeInsets.symmetric(vertical: 16.h),
//                             decoration: BoxDecoration(
//                               color: AppColors.cAppColorsBlue,
//                               borderRadius: BorderRadius.circular(10.r),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppColors.cAppColorsBlue.withOpacity(0.3),
//                                   blurRadius: 8,
//                                   spreadRadius: 0,
//                                   offset: Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             alignment: Alignment.center,
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(Icons.cloud_upload, color: Colors.white, size: 22.sp),
//                                 SizedBox(width: 10.w),
//                                 Text(
//                                   "Choose QR File",
//                                   style: getTextSemiBold(colors: Colors.white, size: 15.sp),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildQrView(BuildContext context) {
//     var scanArea = 0.65.sw;
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//         borderColor: Colors.red,
//         borderRadius: 10.r,
//         borderLength: 30.w,
//         borderWidth: 10.w,
//         cutOutSize: scanArea,
//       ),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//       isCameraInitialized = true; // Mark camera as initialized
//     });
//
//     controller.scannedDataStream.listen((scanData) async {
//       if (isProcessing) return;
//
//       if (scanData.code != null && scanData.code!.isNotEmpty) {
//         isProcessing = true;
//
//         try {
//           await controller.pauseCamera();
//
//           if (Get.isRegistered<QrCodeGenerateController>()) {
//             final qrController = Get.find<QrCodeGenerateController>();
//             await qrController.verifyQrCode(
//               scanData.code ?? "",
//               context,
//             );
//           }
//         } catch (e) {
//           print('Error processing QR code: $e');
//           isProcessing = false;
//           await controller.resumeCamera();
//         }
//       }
//     });
//   }
//
//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     if (!p) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Camera permission denied')));
//     }
//   }
//
//   void _cleanupCamera() {
//     try {
//       // Only attempt to stop if camera was initialized
//       if (isCameraInitialized && controller != null) {
//         controller?.stopCamera();
//       }
//       controller = null;
//       isCameraInitialized = false;
//     } catch (e) {
//       print('Error cleaning up camera: $e');
//     }
//   }
//
//   @override
//   void dispose() {
//     _cleanupCamera();
//     super.dispose();
//   }
// }

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({Key? key}) : super(key: key);

  @override
  _ScanQrCodeScreenState createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isProcessing = false;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<QrCodeGenerateController>()) {
      Get.put(QrCodeGenerateController());
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (isCameraInitialized && controller != null) {
      if (Platform.isAndroid) {
        controller?.pauseCamera();
      }
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWeb = constraints.maxWidth >= 800;

        return WillPopScope(
          onWillPop: () async {
            _cleanupCamera();
            Get.back(result: "");
            return false;
          },
          child: isWeb ? _buildWebLayout() : _buildMobileLayout(),
        );
      },
    );
  }

  Widget _buildWebLayout() {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: 500, // Consistent with ProfileScreen
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: ClipRect(
            child: _mainScannerBody(true),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: CustomAppBar(title: "Qr Scanner"),
      body: SafeArea(child: _mainScannerBody(false)),
    );
  }

  Widget _mainScannerBody(bool isWeb) {
    return FocusDetector(
      onVisibilityGained: () {
        isProcessing = false;
        if (isCameraInitialized && controller != null) {
          controller?.resumeCamera();
        }
      },
      onVisibilityLost: () {
        if (isCameraInitialized && controller != null) {
          controller?.pauseCamera();
        }
      },
      child: GetBuilder<QrCodeGenerateController>(
        builder: (qrController) {
          return Container(
            color: AppColors.white,
            child: qrController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
              children: [
                if (isWeb) CustomAppBar(title: "Qr Scanner", isWeb: true),
                Expanded(child: _buildQrView(context, isWeb)),
                _buildUploadButton(qrController, isWeb),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQrView(BuildContext context, bool isWeb) {
    // Define scan area relative to the container width
    var scanArea = isWeb ? 300.0 : 0.65.sw;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: isWeb ? 10 : 10.r,
        borderLength: isWeb ? 30 : 30.w,
        borderWidth: isWeb ? 10 : 10.w,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  Widget _buildUploadButton(QrCodeGenerateController qrController, bool isWeb) {
    return Container(
      margin: EdgeInsets.all(isWeb ? 20 : 20.sp),
      child: InkWell(
        onTap: () => qrController.getUploadFile(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: isWeb ? 16 : 16.h),
          decoration: BoxDecoration(
            color: AppColors.cAppColorsBlue,
            borderRadius: BorderRadius.circular(isWeb ? 10 : 10.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.cAppColorsBlue.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_upload, color: Colors.white, size: isWeb ? 22 : 22.sp),
              SizedBox(width: isWeb ? 10 : 10.w),
              Text(
                "Choose QR File",
                style: getTextSemiBold(colors: Colors.white, size: isWeb ? 15 : 15.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      isCameraInitialized = true;
    });

    controller.scannedDataStream.listen((scanData) async {
      if (isProcessing) return;

      if (scanData.code != null && scanData.code!.isNotEmpty) {
        isProcessing = true;
        try {
          await controller.pauseCamera();
          final qrController = Get.find<QrCodeGenerateController>();
          await qrController.verifyQrCode(scanData.code ?? "", context);
        } catch (e) {
          isProcessing = false;
          await controller.resumeCamera();
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission denied')),
      );
    }
  }

  void _cleanupCamera() {
    if (isCameraInitialized && controller != null) {
      controller?.stopCamera();
    }
    controller = null;
    isCameraInitialized = false;
  }

  @override
  void dispose() {
    _cleanupCamera();
    super.dispose();
  }
}