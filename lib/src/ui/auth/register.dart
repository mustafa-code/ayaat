import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/auth/account_type.dart';
import 'package:flutter_app/src/widgets/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Register extends StatefulWidget {

  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? dropdownValue;
  bool checked = false;
  List<String> questionList = ['One', 'Two', 'Free', 'Four'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Column(
            children: [
              const Hero(
                tag: "logo",
                child: Image(
                  image: AssetImage("assets/images/logo_no_label.png"),
                  width: 96,
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                "Registration forum",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: "First name"),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Last name"),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: "E-mail"),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: const FaIcon(FontAwesomeIcons.eyeSlash, size: 18),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                          icon: const FaIcon(FontAwesomeIcons.eyeSlash, size: 18),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      hint: const Text("Security question"),
                      isExpanded: true,
                      iconSize: 42,
                      // style: const TextStyle(color: Colors.grey),
                      underline: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: questionList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Answer"),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 32),

              Row(
                children: [
                  Checkbox(
                    value: checked,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      setState(() {
                        checked = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Wrap(
                        children: <Widget>[
                          const Text(
                            "I've read and agree to the ",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                            },
                            child: const Text(
                              "terms ",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const Text(
                            "and ",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                            },
                            child: const Text(
                              "policies ",
                              style: TextStyle(
                               color: Colors.blue,
                              ),
                            ),
                          ),
                          const Text(
                            "of Elex file transfare service",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomButton(
                label: "Sign up",
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AccountType(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

            ],
          ),
        ),
      ),
    );
  }
}
