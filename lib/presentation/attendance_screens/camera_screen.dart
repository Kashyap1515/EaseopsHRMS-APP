import 'package:camera/camera.dart';
import 'package:easeops_hrms/app_export.dart';
import 'package:easeops_hrms/main.dart';

class AttendanceCameraScreen extends GetView<AttendanceController> {
  const AttendanceCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!kIsWeb) {
            if (controller.userLat.value == 0.0 ||
                controller.userLon.value == 0.0) {
              unawaited(controller.setLocation());
            }
            final frontCamera = cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
            );
            controller.cameraController.value = CameraController(
              frontCamera,
              ResolutionPreset.max,
              enableAudio: false,
            );

            await controller.cameraController.value
                .initialize()
                .then((val) async {
              controller.cameraStatus.value = Status.loading;
              controller.cameraStatus.value = Status.completed;
              await controller.setInitialData();
            }).catchError((Object e) {
              if (e is CameraException) {
                switch (e.code) {
                  case 'CameraAccessDenied':
                    break;
                  default:
                    break;
                }
              }
            });
          }
        });
      },
      builder: (context) {
        return BaseLayout(
          appBar: customAppBar(
            title: 'Take a Picture',
            imageIcon: AppIcons.iconMenu,
            automaticallyImplyLeading: false,
            elevation: 0,
            callback: () {
              controller.scaffoldKey.currentState?.openDrawer();
            },
          ),
          scaffoldKey: controller.scaffoldKey,
          drawer: customDrawer(),
          body: Obx(
            () => Scaffold(
              body: controller.cameraStatus.value == Status.completed
                  ? cameraBody()
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget cameraBody() {
    if (!controller.cameraController.value.value.isInitialized) {
      return Container();
    }
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: Get.size.height,
            child: CameraPreview(controller.cameraController.value),
          ),
          if (kIsWeb)
            const SizedBox()
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                bottom: 24,
                right: 32,
                left: 32,
              ),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: FloatingActionButton(
                      onPressed: () async {
                        await controller.captureImage();
                      },
                      backgroundColor: Colors.white,
                      elevation: 8,
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
