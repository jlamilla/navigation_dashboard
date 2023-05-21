import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_dashboard/config/providers/auth_provider.dart';
import 'package:navigation_dashboard/config/providers/loading_provider.dart';
import 'package:navigation_dashboard/config/routers/app_navigator.dart';
import 'package:navigation_dashboard/infrastructure/helpers/auth_state_changes_custom.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';
import 'package:navigation_dashboard/ui/widgets/web/button/button_auth_loading.dart';
import 'package:navigation_dashboard/ui/widgets/web/text_auth/text_auth.dart';

class DetailSide extends StatelessWidget {
  const DetailSide({ Key? key, required Animation<double> animation,}) : _animation = animation, super(key: key);

  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {

    return Align(
            alignment: Alignment(-_animation.value, 0.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.63,
              child: _animation.value < 0.0 
                      ? const SingAuth()
                      : const RestorePassword()
            ),
          );
  }
}

class RestorePassword extends StatelessWidget {
  const RestorePassword({ super.key,});

  @override
  Widget build(BuildContext context) {
    final formRestoreKey = GlobalKey<FormState>();
    return  Form(
      key: formRestoreKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, _) {
          final authForm = ref.watch(authProvider.notifier);
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text( Strings.userPasswordReset,
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox( height: 10,),
                Text(Strings.userPasswordResetContent,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black.withOpacity(0.54),
                  ),
                ),
                const SizedBox( height: 30.0,),
                SizedBox(
                  width: 350.0,
                  child: TextAuthRestorePasswordEmail(authForm: authForm),
                ),
                const SizedBox( height: 40.0,),
                ButtonAuthLoading(
                  action: () async{
                    ref.read(loadingProvider.notifier).update((state) => !state);
                    if(!formRestoreKey.currentState!.validate()) return;
                      final validate = await ref.read(authProvider.notifier).restorePassword();
                      if(validate && context.mounted){
                        displayInfoBar(context, duration: const Duration(seconds: 5), alignment: const Alignment(-0.55, 0.85), builder: (context, close){
                          return InfoBar(
                            title: const Text(Strings.successAlert),
                            content: const Text(Strings.resetPasswordAlert),
                            action: IconButton(
                              icon: const Icon(FluentIcons.clear),
                              onPressed: close,
                            ),
                            severity: InfoBarSeverity.success,
                        );});
                      }else{
                        displayInfoBar(context, duration: const Duration(seconds: 5), alignment: const Alignment(-0.55, 0.85), builder: (context, close){
                          return InfoBar(
                            title: const Text(Strings.error),
                            content: const Text(Strings.resetPasswordAlertError),
                            action: IconButton(
                              icon: const Icon(FluentIcons.clear),
                              onPressed: close,
                            ),
                            severity: InfoBarSeverity.error,
                        );});
                      }
                    ref.read(loadingProvider.notifier).update((state) => !state);
                  },
                  loading: Strings.userPasswordResetLoading,
                  title: Strings.userPasswordReset,
                )
              ],
            );
        }
      )
    );
  }
}

class SingAuth extends StatelessWidget {
  const SingAuth({ super.key,});

  @override
  Widget build(BuildContext context) {
    final formAuthKey = GlobalKey<FormState>();
    AppNavigator navigation = AppNavigator(context);
    return  Form(
      key: formAuthKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Consumer(
        builder: (__, WidgetRef ref, _) {
          final authForm = ref.watch(authProvider.notifier);
          final obscureText = ref.watch(obscureTextProvider);
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(Strings.signAuth,
                  style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox( height: 10,),
                Text(Strings.authContent,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black.withOpacity(0.45),
                  ),
                ),
                const SizedBox( height: 30.0,),
                SizedBox(
                  width: 350.0,
                  child: TextAuthEmail(authForm: authForm),
                ),
                const SizedBox( height: 10,),
                SizedBox(
                  width: 350.0,
                  child: TextAuthPassword(authForm: authForm, obscureText: obscureText),
                ),
                const SizedBox( height: 40.0,),
                ButtonAuthLoading(
                  action: () async{
                    //Validate the form data
                    if(!formAuthKey.currentState!.validate()) return;
                    ref.read(loadingProvider.notifier).update((state) => !state);
                    //validate if the email and password are correct and if the user exists
                    switch (await authForm.signInEmailandPassword()) {
                      case 0:
                        displayInfoBar(context, duration: const Duration(seconds: 5), alignment: const Alignment(0.50, 0.85), builder: (context, close){
                          return InfoBar(
                            title: const Text(Strings.errorAlert),
                            content: const Text(Strings.signInValidate),
                            action: IconButton(
                              icon: const Icon(FluentIcons.clear),
                              onPressed: close,
                            ),
                            severity: InfoBarSeverity.error,
                          );
                        });
                      break;
                      case 1:
                        displayInfoBar(context, duration: const Duration(seconds: 5), alignment: const Alignment(0.512, 0.85), builder: (context, close){
                          return InfoBar(
                            title: const Text(Strings.helpAlert),
                            content: const Text(Strings.userAlertPending),
                            action: IconButton(
                              icon: const Icon(FluentIcons.clear),
                              onPressed: close,
                            ),
                            severity: InfoBarSeverity.info,
                          );
                        }); 
                      break;
                      case 2:
                        displayInfoBar(context, duration: const Duration(seconds: 5), alignment: const Alignment(0.57, 0.85), builder: (context, close){
                          return InfoBar(
                            title: const Text(Strings.warningAlert),
                            content: const Text(Strings.userAlertInactive),
                            action: IconButton(
                              icon: const Icon(FluentIcons.clear),
                              onPressed: close,
                            ),
                            severity: InfoBarSeverity.warning,
                          );
                        });
                      break;
                      case 3:
                        displayInfoBar(context, duration: const Duration(seconds: 5), alignment: const Alignment(0.50, 0.85), builder: (context, close){
                          return InfoBar(
                            title: const Text(Strings.errorAlert),
                            content: const Text(Strings.errorRolUser),
                            action: IconButton(
                              icon: const Icon(FluentIcons.clear),
                              onPressed: close,
                            ),
                            severity: InfoBarSeverity.error,
                          );
                        });
                      break;
                      case 4:
                        displayInfoBar(context, duration: const Duration(seconds: 5), alignment: const Alignment(0.50, 0.85), builder: (context, close){
                          return InfoBar(
                            title: const Text(Strings.errorAlert),
                            content: const Text(Strings.signInValidate),
                            action: IconButton(
                              icon: const Icon(FluentIcons.clear),
                              onPressed: close,
                            ),
                            severity: InfoBarSeverity.error,
                          );
                        });
                      break;
                      case 5: 
                        navigation.toScreenReplacement(context, const AuthStateChangesCustom());
                    }
                    ref.read(loadingProvider.notifier).update((state) => !state);
                  },
                  loading: Strings.authLoading,
                  title: Strings.auth,
                ),
              ],
            );
        }
      )
    );
  }
}
