import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_viewmodel.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Consumer<RegisterViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: viewModel.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onSaved: (value) => viewModel.name = value!,
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onSaved: (value) => viewModel.email = value!,
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onSaved: (value) => viewModel.password = value!,
                          ),
                          SizedBox(height: 24.0),
                          ElevatedButton(
                            onPressed: () => viewModel.register(context),
                            child: Text('Register'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
