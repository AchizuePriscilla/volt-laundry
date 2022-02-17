import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';
import 'package:volt/utils/utils.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  bool buttonActive = false;

  void onListen() {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _locationController.text.isEmpty) {
      setState(() {
        buttonActive = false;
      });
    } else {
      setState(() {
        buttonActive = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<SignUpViewModel>().setCurrentLocation();
    _emailController.addListener(onListen);
    _passwordController.addListener(onListen);
    _phoneNumberController.addListener(onListen);
    _nameController.addListener(onListen);
    _locationController.addListener(onListen);
  }

  @override
  void dispose() {
    _emailController.removeListener(onListen);
    _passwordController.removeListener(onListen);
    _phoneNumberController.removeListener(onListen);
    _nameController.removeListener(onListen);
    _locationController.removeListener(onListen);
    super.dispose();
  }

  Future<void> _determineLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: SizedBox(
          height: 30.h,
          child: Center(
            child: Text(
              'Location permissions are permanently denied, we cannot request permissions.',
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ),
      ));
    }
    context.read<SignUpViewModel>().setCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var signUpVM = context.read<SignUpViewModel>();
    return ResponsiveWidget(
      resizeToAvoidBottomInset: true,
      builder: (_, size) {
        return Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            image: const DecorationImage(
                image: AssetImage('assets/images/white_background.png'),
                fit: BoxFit.cover),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView(children: [
                Padding(
                  padding: EdgeInsets.only(top: 75.h, left: 75.h, right: 75.h),
                  child: SizedBox(
                    child:
                        Image.asset('assets/images/volt_logo/volt_mixed.png'),
                  ),
                ),
                const CustomSpacer(flex: 3),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Create your volt account',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const CustomSpacer(flex: 3),
                CustomTextField(
                  controller: _nameController,
                  validator: (name) {
                    return signUpVM.validateFullName(name);
                  },
                  fillColor: Theme.of(context).primaryColorLight,
                  prefix: Icon(
                    Icons.person_outlined,
                    color: Theme.of(context).disabledColor.withOpacity(.6),
                  ),
                  hint: 'Full Name',
                ),
                const CustomSpacer(flex: 3),
                CustomTextField(
                  controller: _phoneNumberController,
                  validator: (phoneNumber) {
                    return signUpVM.validatePhoneNumber(phoneNumber);
                  },
                  fillColor: Theme.of(context).primaryColorLight,
                  prefix: Icon(
                    Icons.phone,
                    color: Theme.of(context).disabledColor.withOpacity(.6),
                  ),
                  hint: "Phone Number, E.g: 081XXXX8998",
                ),
                const CustomSpacer(flex: 3),
                CustomTextField(
                  controller: _locationController,
                  fillColor: Theme.of(context).primaryColorLight,
                  prefix: Icon(
                    Icons.pin_drop,
                    color: Theme.of(context).disabledColor.withOpacity(.6),
                  ),
                  hint: "Shipping Adress (Please be descriptive)",
                ),
                const CustomSpacer(flex: 3),
                CustomTextField(
                  controller: _emailController,
                  validator: (email) {
                    return signUpVM.validateEmail(email);
                  },
                  fillColor: Theme.of(context).primaryColorLight,
                  prefix: Icon(
                    Icons.mail_outline,
                    color: Theme.of(context).disabledColor.withOpacity(.6),
                  ),
                  hint: 'Email',
                ),
                const CustomSpacer(flex: 3),
                CustomTextField(
                  controller: _passwordController,
                  validator: (password) {
                    return signUpVM.validatePassword(password);
                  },
                  fillColor: Theme.of(context).primaryColorLight,
                  prefix: Icon(
                    Icons.lock_outline,
                    color: Theme.of(context).disabledColor.withOpacity(.6),
                  ),
                  hint: 'Password',
                ),
                const CustomSpacer(flex: 3),
                Button(
                    active: buttonActive,
                    loading: context.watch<SignUpViewModel>().loading,
                    text: 'Sign Up',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _determineLocation();
                        signUpVM.updateFields(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            phoneNumber: _phoneNumberController.text.trim(),
                            address: _locationController.text);
                        await signUpVM.sendVerificationToken();
                      }
                    }),
                const CustomSpacer(flex: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const CustomSpacer(
                      horizontal: true,
                      flex: 0.3,
                    ),
                    GestureDetector(
                      onTap: () {
                        signUpVM.navigateToRoute(logInViewRoute);
                      },
                      child: Text(
                        'Sign in Here',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Palette.orangeColor,
                        ),
                      ),
                    ),
                    const CustomSpacer(flex: 20),
                  ],
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
