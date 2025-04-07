import 'package:easeops_hrms/app_export.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sbh60,
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: GetStorageHelper.getUserData().name != null
                ? AppColors.lightColor
                : null,
          ),
          child: GetStorageHelper.getUserData().name == null
              ? Image.asset(
                  AppImages.appLogo,
                  color: AppColors.lightColor,
                )
              : GetStorageHelper.getUserData().displayPicture == null
                  ? Padding(
                      padding: all16,
                      child: FittedBox(
                        child: CustomText(
                          title: (GetStorageHelper.getUserData().name ?? '')
                              .substring(0, 2)
                              .toUpperCase(),
                          fontWeight: FontWeight.w500,
                          color: AppColors.kcWhiteColor,
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Image.network(
                        GetStorageHelper.getUserData().displayPicture ?? '',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
        ),
        sbh10,
        CustomText(
          title: GetStorageHelper.getUserData().name ?? '',
          fontSize: fontLarge,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
        sbh5,
        CustomText(
          title: GetStorageHelper.getUserData().email ??
              GetStorageHelper.getProfileData().phoneNumber ??
              '',
          fontSize: fontSmallMedium,
          textAlign: TextAlign.center,
          color: AppColors.textColor,
        ),
        sbh16,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 20,
            ),
            sbw5,
            Flexible(
              child: CustomText(
                title:
                    GetStorageHelper.getCurrentLocationData()?.locationName ??
                        '',
                textAlign: TextAlign.center,
                fontSize: fontBase,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        sbh30,
        const CustomDivider(),
        sbh30,
      ],
    );
  }
}
