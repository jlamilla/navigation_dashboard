import 'package:fluent_ui/fluent_ui.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';

class AlertCustom{
  Future <bool> showContentDialog({ required BuildContext context, required Function()? action, required String title, required String content}) async{
      return await showDialog<bool>(
          context: context,
          builder: (context) => ContentDialog(
            title: Text(title, style: const TextStyle( fontSize: 20),),
            content: Text(content),
            actions: [
              Button(
                onPressed: action,
                child: const SizedBox(
                  height: 30,
                  child: Center(
                    child: Text(Strings.buttonDelete, style: TextStyle( fontSize: 15), textAlign: TextAlign.center,)
                  )
                )
              ),
              FilledButton(
                child: const SizedBox(
                  height: 30,
                  child: Center(
                    child: Text(Strings.buttonCancel, style: TextStyle( fontSize: 15), textAlign: TextAlign.center, )
                  )
                ),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          ),
        ) ?? false;
  }

  Future <bool> showSelectStateOrderDialog({ required BuildContext context, required Function()? action, required String title, required String content, required Widget select}) async{
      return await showDialog<bool>(
                  context: context,
                  builder: (context) => ContentDialog(
                    title: Text(title, style: const TextStyle( fontSize: 20),),
                    content: SizedBox(
                      width: 400,
                      height: 80,
                      child: Row(
                        children: [
                          Expanded(child: Text(content)),
                          Expanded(child: select)
                        ],
                      ),
                    ),
                    actions: [
                      Button(
                        onPressed: action,
                        child: const SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(Strings.updateState, style: TextStyle( fontSize: 15), textAlign: TextAlign.center,)
                          )
                        )
                      ),
                      FilledButton(
                        child: const SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(Strings.buttonCancel, style: TextStyle( fontSize: 15), textAlign: TextAlign.center, )
                          )
                        ),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                    ],
                  ),
                ) ?? false;
  }

}