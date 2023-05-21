import 'dart:html';

import 'package:navigation_dashboard/ui/constants/list_element.dart';
import 'package:navigation_dashboard/ui/constants/strings.dart';

class Validations{


  static String? validateEmail( value ) {
  
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);
              
              return regExp.hasMatch(value ?? '')
                ? null
                : 'El valor ingresado no luce como un correo';
  
  }

  static String? validatePassword( value ) {
  
              return ( value != null && value.length >= 6 ) 
                ? null
                : 'Debe de tener mínimo 6 caracteres';                                    
              
  }

  static String? validateDni( value ) {
  
              return ( value != null && value.length >= 4 ) 
                ? null
                : 'Debe de tener mínimo 4 caracteres';                                    
              
  }

  static String? validatePhoneNumber( value ) {
  
              return ( value != null && value.length > 10 ) 
                ? null
                : 'Debe de tener mínimo 10 caracteres';                                    
              
  }

  static String? validateAddress( value ) {
  
              return ( value != null && value.length >= 8 ) 
                ? null
                : 'Debe de tener mínimo 8 caracteres';                                    
              
  }
  static String? validateSelectProductSize( String? value ) {
              if(value != null && value.isNotEmpty){
                if(ListElement.productSite.where((item) =>  0 == '${Strings.siteProduct} $item'.compareTo(value)).toList().isEmpty){
                  return Strings.validateSelect; 
                }
              }else{
                return Strings.validateSelect;
              }
              return null;                                                 
  }
  static String? validateSelectDepartment( String? value ) {
              if(value != null && value.isNotEmpty){
                if(ListElement.departmentMunicipal.where((item) =>  0 == item.department.compareTo(value)).toList().isEmpty){
                  return Strings.validateSelect; 
                }
              }else{
                return Strings.validateSelect;
              }

              return null;                                                 
  }
  static String? validateSelectMunicipal( String? value, List<String> list ) {
              if(value != null && value.isNotEmpty){
                if(!list.contains(value)){
                  return Strings.validateSelect; 
                }
              }else{
                return Strings.validateSelect;
              }
              return null;                                                 
  }
  static String? validateSelect( String? value) {

              if (value == null || value.isEmpty) {
                  return Strings.validateSelect;
              }
              return null;                                  
  }
  static String? validateNoEmptyString( value ) {

              String pattern = r'^[a-zA-Z\u00C0-\u017F\s]+$';
              RegExp regExp  = RegExp(pattern);
              if(value != null){
                if(value.length < 3){
                  return 'Debe de tener mínimo 3 caracteres';
                }else if (!regExp.hasMatch(value)){
                  return 'El valor ingresado no luce como una letra';
                }
              }
              return null;
  }

  static String? validateNoEmpty( value ) {

              if(value != null){
                if(value.length < 2){
                  return 'Debe de tener mínimo 2 caracteres';
                }
              }
              return null;
  }

  static String? validateReference( value ) {

              if(value != null){
                if(value.length < 6){
                  return 'La referencia debe de tener 6 caracteres';
                }
              }
              return null;
  }

  static String? validateSize( value ) {

              if(value != null){
                if(value.length < 1){
                  return 'Debe de tener mínimo 1 carácter';
                }
              }
              return null;
  }

  static String? validateAmount( value ) {

              if(value != null){
                if(value.length < 1){
                  return 'Debe de tener mínimo 1 carácter';
                }else if (value == '0' || value == '00'|| value == '000'){
                  return 'Debe ingresar un valor diferente de 0';
                }
              }
              return null;
  }

  static String? validatePinta( value ) {

              if(value != null){
                if(value.length < 1){
                  return 'Debe de tener mínimo 1 carácter';
                }else if (value == '0' || value == '00'){
                  return 'Debe ingresar un valor diferente de 0';
                }
              }
              return null;
  }
  
}