import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_case/blocs/auth/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const AuthFormWidget(),
    );
  }
}

class AuthFormWidget extends StatelessWidget {
  const AuthFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileImageForm(),
            SizedBox(height: 20),
            UsernameForm(),
            SizedBox(height: 20),
            PasswordForm(),
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: NumberForm()),
                SizedBox(width: 10),
                Expanded(child: DateForm()),
              ],
            ),
            SizedBox(height: 40),
            SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class ProfileImageForm extends StatefulWidget {
  const ProfileImageForm({super.key});

  @override
  State<ProfileImageForm> createState() => _ProfileImageFormState();
}

class _ProfileImageFormState extends State<ProfileImageForm> {
  File? _image;

  Future<void> _getImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    setState(() {
      _image = File(file.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPhotoAdded = _image != null;
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: 200,
        height: 200,
        child: isPhotoAdded
            ? Image.file(
                _image!,
                fit: BoxFit.cover,
              )
            : InkWell(
                borderRadius: BorderRadius.circular(60),
                onTap: _getImage,
                child: ColoredBox(
                  color: Colors.white.withOpacity(0.06),
                  child: const Center(
                      child: Text(
                    'tap to add a photo',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )),
                ),
              ),
      ),
    );
  }
}

class UsernameForm extends StatelessWidget {
  const UsernameForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('username_text_field'),
          onChanged: (value) =>
              context.read<AuthBloc>().add(AuthUsernameChanged(value)),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            labelText: 'username',
            errorText: state.username.displayError != null
                ? 'username should consist of latin letters only'
                : null,
          ),
        );
      },
    );
  }
}

class PasswordForm extends StatelessWidget {
  const PasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (cobtext, state) {
        return TextField(
          key: const Key('password_text_field'),
          onChanged: (value) =>
              context.read<AuthBloc>().add(AuthPasswordChanged(value)),
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            labelText: 'password',
            errorText: state.password.displayError != null
                ? 'password should not be empty'
                : null,
          ),
        );
      },
    );
  }
}

class NumberForm extends StatelessWidget {
  const NumberForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.number != current.number,
      builder: (context, state) {
        return TextField(
          key: const Key('number_text_field'),
          keyboardType: TextInputType.number,
          onChanged: (value) =>
              context.read<AuthBloc>().add(AuthNumberChanged(value)),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            labelText: 'desired salary',
            suffixText: r'$',
            errorText:
                state.number.displayError != null ? 'invalid salary' : null,
          ),
        );
      },
    );
  }
}

class DateForm extends StatelessWidget {
  const DateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.date != current.date,
      builder: (context, state) {
        return TextField(
          key: const Key('date_text_field'),
          keyboardType: TextInputType.datetime,
          onChanged: (value) =>
              context.read<AuthBloc>().add(AuthDateChanged(value)),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            labelText: 'date',
            hintText: 'dd.mm.yyyy',
            errorText: state.date.displayError != null ? 'invalid date' : null,
          ),
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(),
              )
            : state.status.isSuccess
                ? const Icon(Icons.done)
                : ElevatedButton(
                    onPressed: state.isValid
                        ? () => context
                            .read<AuthBloc>()
                            .add(const AuthFormSubmitted())
                        : null,
                    child: const Text('submit'),
                  );
      },
    );
  }
}
