import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_login/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Container(
        child: BlocProvider(
          create: (context) => LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context)),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print(state.toString());
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Column(
        children: [
          _UsernameInput(),
          SizedBox(height: 12),
          _PasswordInput(),
          SizedBox(height: 12),
          _SubmitButton()
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(value)),
        );
      },
      buildWhen: (previous, current) {
        if (previous.username == current.username) return false;
        return true;
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(value)),
          decoration: InputDecoration(
            errorText:
                state.password.invalid ? state.password.error.toString() : null,
          ),
        );
      },
      buildWhen: (previous, current) {
        if (previous.password == current.password) return false;
        return true;
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.status.isSubmissionInProgress
          ? CircularProgressIndicator()
          : TextButton(
              onPressed: state.status.isValidated
                  ? () => context.read<LoginBloc>().add(const LoginSubmitted())
                  : null,
              child: Text("Login"),
            );
    });
  }
}
