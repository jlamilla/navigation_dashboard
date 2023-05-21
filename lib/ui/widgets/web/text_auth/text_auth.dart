

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/infrastructure/helpers/validations.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';

class TextAuthRestorePasswordEmail extends StatelessWidget {
  const TextAuthRestorePasswordEmail({
    super.key,
    required this.authForm,
  });

  final AuthNotifier authForm;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => Validations.validateEmail(value),
      onChanged: ( value ) => authForm.email = value,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.87)),
        errorStyle: const TextStyle(fontSize: 16),
        enabledBorder: OutlineInputBorder( borderSide: BorderSide( color: Colors.black.withOpacity(0.38) )),
        focusedBorder:  OutlineInputBorder(borderSide: BorderSide( color: Colors.black.withOpacity(0.38) )),
        label: const Text(Strings.authUserEmail),
        filled: true,
        fillColor: const Color(0xffF4F8F7),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.mail,
            color: Colors.black.withOpacity(0.45),
            size: 20.0,
          ),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}



class TextAuthPassword extends ConsumerWidget {
  const TextAuthPassword({
    super.key,
    required this.authForm,
    required this.obscureText,
  });

  final AuthNotifier authForm;
  final bool obscureText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      validator: (value) => Validations.validatePassword(value),
      onChanged: ( value ) => authForm.password = value,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelStyle:  TextStyle(color: Colors.black.withOpacity(0.87)),
        errorStyle: const TextStyle(fontSize: 16),
        enabledBorder: OutlineInputBorder( borderSide: BorderSide( color: Colors.black.withOpacity(0.38) )),
        focusedBorder:  OutlineInputBorder(borderSide: BorderSide( color: Colors.black.withOpacity(0.38) )),
        label: const Text(Strings.authUserPassword,),
        filled: true,
        fillColor: const Color(0xffF4F8F7),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.lock_outline, 
            color: Colors.black.withOpacity(0.4),
              size: 20.0,
            ),
        ),
        suffixIcon: obscureText
          ? IconButton(
              onPressed: () => ref.read(obscureTextProvider.notifier).update((state) => !state) , 
              icon: Icon(Icons.remove_red_eye, color: Colors.black.withOpacity(0.8),)
            )
          : IconButton(
              onPressed: () => ref.read(obscureTextProvider.notifier).update((state) => !state), 
              icon: Icon(Icons.visibility_off,color: Colors.black.withOpacity(0.6),)
            ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class TextAuthEmail extends StatelessWidget {
  const TextAuthEmail({
    super.key,
    required this.authForm,
  });

  final AuthNotifier authForm;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => Validations.validateEmail(value),
      onChanged: ( value ) => authForm.email = value,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.black87),
        errorStyle: const TextStyle(fontSize: 16),
        enabledBorder: OutlineInputBorder( borderSide: BorderSide( color: Colors.black.withOpacity(0.38) )),
        focusedBorder:  OutlineInputBorder(borderSide: BorderSide( color: Colors.black.withOpacity(0.38) )),
        label: const Text(Strings.authUserEmail),
        filled: true,
        fillColor: const Color(0xffF4F8F7),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.mail,
            color: Colors.black.withOpacity(0.45),
            size: 20.0,
          ),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
