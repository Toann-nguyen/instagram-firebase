import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_firebase/resources/auth_methods.dart';
import 'package:instagram_firebase/utils/utils.dart';
import 'package:instagram_firebase/widgets/text_field_input.dart';

import 'dart:typed_data';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  // Int8List? _image;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(
      () {
        _image = img;
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              //svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                height: 70,
              ),
              const SizedBox(
                height: 64,
              ),
              //cicualr widget to accept and show ouput file
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/7dad3704-665b-4295-98bc-ad99cfe690f7/dfbdyzf-ba04e4bd-53a2-4e18-bd8f-4140aea16f1d.jpg/v1/fit/w_375,h_466,q_70,strp/tru_kait__by_femaleeater_dfbdyzf-375w.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTM0MyIsInBhdGgiOiJcL2ZcLzdkYWQzNzA0LTY2NWItNDI5NS05OGJjLWFkOTljZmU2OTBmN1wvZGZiZHl6Zi1iYTA0ZTRiZC01M2EyLTRlMTgtYmQ4Zi00MTQwYWVhMTZmMWQuanBnIiwid2lkdGgiOiI8PTEwODAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.uo9O87cnqWi_0QaqgEysM5SjjctGgSsCEoUYyv4g-Tc'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: selectImage,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 24,
              ),
              //text field input for username
              TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),
              //text field input for email
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 24,
              ),
              //text field input for password
              TextFieldInput(
                  textEditingController: _passwordController,
                  isPass: true,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),
              //text field input for bio
              TextFieldInput(
                  textEditingController: _bioController,
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),
              //button login
              InkWell(
                onTap: () async {
                  String res = await AuthMethods().signUpUser(
                      email: _emailController.text,
                      password: _passwordController.text,
                      username: _usernameController.text,
                      bio: _bioController.text);

                  print(res);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: const Text('Sign up'),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //Transitiloning to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      "Don't have an account?",
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: const Text(
                        "Sign up.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
