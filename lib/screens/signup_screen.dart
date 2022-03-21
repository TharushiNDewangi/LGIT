import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_git/screens/bottom_bar.dart';
import 'package:learn_git/services/auth_service.dart';

import 'package:learn_git/screens/login_screen.dart';
import 'package:learn_git/utill/colors.dart';

import '../utill/utils.dart';
import '../widgets/text_field.dart';

/**
 * created by IT19123196(K.H.T.N Dewangi)
 */
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  /** From Tutorial 
   * that Loading variable this pop up when sign up correct*/
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });
    // Signup user through Service(Auth service)
    String res = await AuthService().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    //Check responce
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // Navigate to login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomBar()),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

/*From Tutorial
  Using Image picker we can select image using galary or we can capture image by using cammera
  when user click add image button that method called 
  and pickImage function write in utiil class
  i use Uint8List because it is dynamic (not mension any type) 
  set state because we need to display the image we selected 
  on the circle avatar*/
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // SvgPicture.asset(
              //   'assets/github.svg',
              //   color: primaryColor,
              //   height: 64,
              // ),
              // const SizedBox(
              //   height: 64,
              // ),
              // Stack(
              //   children: [
              //     const CircleAvatar(
              //       radius: 64,
              //       backgroundImage:
              //           NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
              //       backgroundColor: Colors.red,
              //     ),
              //     Positioned(
              //       bottom: -10,
              //       left: 80,
              //       child: IconButton(
              //         onPressed: () {},
              //         icon: const Icon(Icons.add_a_photo),
              //       ),
              //     )
              //   ],
              // ),
              /**From Tutorial 
               * check image != null then we use Uint8List it access memory image
               * then will pass image and it should bn not null
               * if image = null then it display default image (From network)
              */
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Color.fromARGB(255, 10, 9, 9),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Color.fromARGB(255, 12, 12, 12),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hint: 'Enter Your User Name',
                textType: TextInputType.text,
                textController: _usernameController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hint: 'Enter Your Email',
                textType: TextInputType.emailAddress,
                textController: _emailController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hint: 'Enter Your Password',
                textType: TextInputType.text,
                textController: _passwordController,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hint: 'Enter Your Password Again',
                textType: TextInputType.text,
                textController: _bioController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hint: 'Enter Your Bio',
                textType: TextInputType.text,
                textController: _bioController,
              ),
              const SizedBox(
                height: 24,
              ),
              // TextFieldInput(
              //   hintText: 'Your GitHub Level',
              //   textInputType: TextInputType.text,
              //   textEditingController: _bioController,
              // ),
              // const SizedBox(
              //   height: 24,
              // ),
              InkWell(
                child: Container(
                  //From Tutorial check loading
                  child: !_isLoading
                      ? const Text(
                          'Sign up',
                        )
                      : const CircularProgressIndicator(
                          color: whiteColor,
                        ),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                ),
                onTap: signUpUser,
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Already have an account?',
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Container(
                      child: const Text(
                        ' Login.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
