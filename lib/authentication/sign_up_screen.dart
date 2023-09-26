import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../common/constants/gaps.dart';
import '../common/constants/sizes.dart';
import '../common/widgets/auth_button.dart';
import '../router.dart';
import 'view_models/sign_up_view_model.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  //final logoImage = 'assets/images/threads_black_logo.png';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");

  late String _email = "";
  late String _password = "";
  bool _obscureText = true;

  /// 비밀번호 입력값 초기화
  void _onClearTap() {
    _passwordController.clear();
  }

  /// 비밀번호 hide
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  /// 비밀번호 유효성 검사
  bool _isPasswordValid() {
    return _passwordController.text.isNotEmpty &&
        _passwordController.text.length > 8 &&
        _passwordController.text.length < 21;
  }

  Future<void> _onSignup(context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        ref.read(signUpForm.notifier).state = {
          "email": _email,
          "password": _password,
        };
        ref.read(signUpProvider.notifier).signUp(context);
      }
    }
  }

  void _onMoveLoginScreen(BuildContext context) {
    context.go(Routes.loginURL);
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  ///마지막 실행, 모든게 다끝날때
  @override
  Future<void> dispose() async {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Gaps.v10,
            Row(
              //가로 축 가운데 정렬
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FaIcon(
                  FontAwesomeIcons.fire,
                  color: Colors.red,
                ),
                Text(
                  "MOOD",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.fire,
                  color: Colors.red,
                ),
              ],
            ),
            Gaps.v80,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size40,
                  vertical: Sizes.size20,
                ),
                child: Center(
                  // Center widget was incorrectly placed in your original code.
                  child: Column(
                    // Column widget was incorrectly placed in your original code.
                    children: [
                      Gaps.v40,
                      // const Text(
                      //   "Create your account",
                      //   style: TextStyle(
                      //       fontSize: Sizes.size24,
                      //       fontWeight: FontWeight.w800),
                      // ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Gaps.v28,
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                suffixIcon: _email.isNotEmpty
                                    ? const Icon(Icons.check_circle,
                                        color: Colors.green)
                                    : null,
                                hintText: 'Email',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Please enter your email.";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  formData['email'] = newValue;
                                }
                              },
                            ),
                            Gaps.v16,
                            TextFormField(
                              /// 비밀번호처럼 ***으로 보이게함
                              obscureText: _obscureText,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                suffix: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: _onClearTap,
                                      child: const FaIcon(
                                        FontAwesomeIcons.solidCircleXmark,
                                        color: Colors.black,
                                        size: Sizes.size20,
                                      ),
                                    ),
                                    Gaps.h16,
                                    GestureDetector(
                                      onTap: _toggleObscureText,
                                      child: FaIcon(
                                        _obscureText
                                            ? FontAwesomeIcons.eye
                                            : FontAwesomeIcons.eyeSlash,
                                        color: Colors.black,
                                        size: Sizes.size20,
                                      ),
                                    )
                                  ],
                                ),
                                hintText: 'Password',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Please enter your password.";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  formData['password'] = newValue;
                                }
                              },
                            ),
                            Gaps.v16,
                            const Text(
                              "Your password must have:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.circleCheck,
                                  size: Sizes.size20,
                                  color: _isPasswordValid()
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                Gaps.h5,
                                const Text("8 to 20 characters"),
                              ],
                            ),
                            Gaps.v16,
                            GestureDetector(
                              onTap: () => _onSignup(context),
                              child: const AuthButton(
                                text: "Create Account",
                                disabled: false,
                              ),
                            ),
                            // Gaps.v16,
                            // const Text(
                            //   "Forgot password?",
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _onMoveLoginScreen(context),
                child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.7, // 화면 너비의 약 70%만큼 설정
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                      horizontal: Sizes.size16,
                    ),
                    decoration: BoxDecoration(
                      // BoxDecoration을 이용해 테두리를 만듭니다.
                      border: Border.all(
                        color: Colors.black,
                      ), // 원하는 색상과 두께로 설정 가능합니다.
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Log in',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        FaIcon(
                          FontAwesomeIcons.arrowRight,
                          size: Sizes.size14,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
