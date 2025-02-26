// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';


// class EditScreenFromData extends StatefulWidget {
//   const EditScreenFromData({super.key});

//   @override
//   State<EditScreenFromData> createState() => _EditScreenFromDataState();
// }

// class _EditScreenFromDataState extends State<EditScreenFromData> {
//   @override
//   Widget build(BuildContext context) {
//         AppLocalizations? locale = AppLocalizations.of(context);

//     return const Column(
//       children: [
// Column(
//         children: [
//           Form(
//             key: viewModel.formKey,
//             onChanged: () => viewModel.doIntent(FormDataChangedAction()),
//             child: Column(
//               children: [
//                 CustomTextFormField(
//                   controller: viewModel.nameController,
//                   labelText: locale!.fullName,
//                   hintText: locale.fullName,
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.name,
//                   validator: (name) => AppValidator.validateFieldIsNotEmpty(
//                     value: name,
//                     message: locale.emptyName,
//                   ),
//                 ),
//                 SizedBox(height: 26.h),
//                 CustomTextFormField(
//                   controller: viewModel.birthdayController,
//                   labelText: locale.birthday,
//                   hintText: locale.birthday,
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.datetime,
//                   validator: (birthDay) => AppValidator.validateFieldIsNotEmpty(
//                     value: birthDay,
//                     message: locale.emptyBirthDay,
//                   ),
//                 ),
//                 SizedBox(height: 26.h),
//                 CustomTextFormField(
//                   controller: viewModel.phoneController,
//                   labelText: locale.phoneNumber,
//                   hintText: locale.phoneNumber,
//                   textInputAction: TextInputAction.done,
//                   keyboardType: TextInputType.phone,
//                   validator: (phone) => AppValidator.validateFieldIsNotEmpty(
//                     value: phone,
//                     message: locale.emptyPhoneNumber,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 26.h),
//           SelectedGenderWidget(viewModel: viewModel),
//           SizedBox(height: 66.h),
//           BlocBuilder<FillProfileViewModel, FillProfileStates>(
//             bloc: viewModel,
//             buildWhen: (previous, current) =>
//                 current is FillProfileLoadingState,
//             builder: (context, state) {
//               return ElevatedButton(
//                 onPressed: () {
//                   viewModel.doIntent(FillProfileDataAction());
//                 },
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 60.h),
//                   backgroundColor: ColorsManager.baseBlue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                 ),
//                 child: state is FillProfileLoadingState
//                     ? Center(
//                         child: LoadingAnimationWidget.staggeredDotsWave(
//                           color: Colors.white,
//                           size: 40,
//                         ),
//                       )
//                     : Text(
//                         locale.submit,
//                         style: TextStyles.font20WhiteSemiBold,
//                       ),
//               );
//             },
//           ),
//         ],
//       )
//       ],
//     );
//   }
// }
