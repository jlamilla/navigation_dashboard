import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Formatter {

static String priceFormat(String price) {
    return '\$${NumberFormat('#,##0', 'es-CO').format(int.parse(price))}';
}
static String dateFormat() {
  return  DateFormat("dd/MM/yyyy, hh:mm:ss a").format(DateTime.now());
}

static phoneNumber(){
  return MaskTextInputFormatter(mask: '### ## ## ###',filter: {"#":RegExp(r'[0-9]')});
}
static sizes(){
  return MaskTextInputFormatter(mask: '#',filter: {"#":RegExp(r'[1-9]')});
}
static size(){
  return MaskTextInputFormatter(mask: '##',filter: {"#":RegExp(r'^[a-zA-Z0-9]+$')});
}
static amount(){
  return MaskTextInputFormatter(mask: '###',filter: {"#":RegExp(r'[0-9]')});
}
static countCartShop(){
  return MaskTextInputFormatter(mask: '###',filter: {"#":RegExp(r'[0-9]')});
}

static pintaProduct(){
  return MaskTextInputFormatter(mask: '##',filter: {"#":RegExp(r'[0-9]')});
}
static referenceProduct(){
  return MaskTextInputFormatter(mask: '#######',filter: {"#":RegExp(r'^[a-zA-Z0-9]+$')});
}
static dni(){
  return MaskTextInputFormatter(mask: '##########',filter: {"#":RegExp(r'[0-9]')});
}

static text(){
  return MaskTextInputFormatter(mask: '', filter: {"#":RegExp(r'[0-9]')});
}

}
