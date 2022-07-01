import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_firebase_ddd_course/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    failure.map(
                      cancelledByUser: (_) => 'Cancelled',
                      serverError: (_) => 'Server error',
                      emailAlreadyInUse: (_) => 'Email already in use',
                      invalidEmailAndUserCombination: (_) => 'Invalid email and password combination',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  behavior: SnackBarBehavior.fixed,
                ),
              );
            },
            (_) {},
          ),
        );
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showErrorMessages,
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              const Text('📝', textAlign: TextAlign.center, style: TextStyle(fontSize: 130)),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(prefixIcon: Icon(Icons.email), labelText: 'Email'),
                autocorrect: false,
                onChanged: (value) => context.read<SignInFormBloc>().add(SignInFormEvent.emailChanged(value)),
                validator: (_) => context.read<SignInFormBloc>().state.emailAddress.value.fold(
                      (f) => f.maybeMap(invalidEmail: (_) => 'Invalid email', orElse: () => null),
                      (_) => null,
                    ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(prefixIcon: Icon(Icons.lock), labelText: 'Password'),
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => context.read<SignInFormBloc>().add(SignInFormEvent.passwordChanged(value)),
                validator: (_) => context.read<SignInFormBloc>().state.password.value.fold(
                      (f) => f.maybeMap(shortPassword: (_) => 'Short password', orElse: () => null),
                      (_) => null,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        context.read<SignInFormBloc>().add(const SignInFormEvent.signInWithEmailAndPasswordPressed());
                      },
                      child: const Text('SIGN IN', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        context.read<SignInFormBloc>().add(const SignInFormEvent.registerWithEmailAndPasswordPressed());
                      },
                      child: const Text('REGISTER', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<SignInFormBloc>().add(const SignInFormEvent.signInWithGooglePressed());
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  onPrimary: Colors.white,
                ),
                child: const Text('SIGH IN WITH GOOGLE', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              if (state.isSubmitting) ...[
                const SizedBox(height: 8),
                const LinearProgressIndicator(),
              ],
            ],
          ),
        );
      },
    );
  }
}
