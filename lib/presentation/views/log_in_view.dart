import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt/presentation/shared/shared.dart';
import 'package:volt/presentation/viewmodels/viewmodels.dart';
import 'package:volt/utils/constants.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  _LogInViewState createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool hidePassword = true;
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  bool buttonActive = false;

  void onListen() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        buttonActive = false;
      });
    } else {
      setState(() {
        buttonActive = true;
      });
    }
  }

  void toggleVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void toggleRememberMe() {
    setState(() {
      rememberMe = !rememberMe;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(onListen);
    _passwordController.addListener(onListen);
  }

  @override
  void dispose() {
    _emailController.removeListener(onListen);
    _passwordController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginVM = context.read<LogInViewModel>();
    return ResponsiveWidget(
      resizeToAvoidBottomInset: false,
      builder: (_, size) {
        return Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            image: const DecorationImage(
              image: AssetImage('assets/images/white_background.png'),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
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
                    'Log in to your volt account',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const CustomSpacer(flex: 3),
                Text(
                  'Email',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                const CustomSpacer(flex: 1),
                CustomTextField(
                  fillColor: Theme.of(context).primaryColorLight,
                  controller: _emailController,
                ),
                const CustomSpacer(flex: 3),
                Text(
                  'Password',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                const CustomSpacer(flex: 1),
                CustomTextField(
                  fillColor: Theme.of(context).disabledColor.withOpacity(.2),
                  obscure: hidePassword,
                  controller: _passwordController,
                  suffix: PasswordVisibilityIcon(
                    onPressed: toggleVisibility,
                    value: hidePassword,
                  ),
                ),
                const CustomSpacer(flex: 8),
                Button(
                    active: buttonActive,
                    loading: context.read<LogInViewModel>().loading,
                    text: 'Log In',
                    onPressed: () {
                      loginVM.login(
                          email: _emailController.text,
                          password: _passwordController.text);
                    }),
                const CustomSpacer(flex: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: toggleRememberMe,
                          child: Container(
                            alignment: Alignment.topCenter,
                            height: 13.h,
                            width: 13.h,
                            decoration: BoxDecoration(
                              color: rememberMe
                                  ? Palette.buttonColor
                                  : Theme.of(context).backgroundColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Palette.buttonColor,
                                width: 2,
                              ),
                            ),
                            child: rememberMe
                                ? Center(
                                    child: Icon(Icons.check,
                                        size: 9.h, color: Colors.white))
                                : null,
                          ),
                        ),
                        const CustomSpacer(
                          horizontal: true,
                          flex: 0.7,
                        ),
                        Text(
                          "Remember me",
                          style: GoogleFonts.lato(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        loginVM.navigateToRoute(forgotPasswordViewRoute);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Palette.orangeColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const CustomSpacer(
                  flex: 4,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.lato(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const CustomSpacer(
                      horizontal: true,
                      flex: 0.3,
                    ),
                    InkWell(
                      onTap: () {
                        loginVM.navigateToRoute(signUpViewRoute);
                      },
                      child: Text(
                        'Create one Here',
                        style: GoogleFonts.lato(
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
