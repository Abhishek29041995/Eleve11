import 'package:eleve11/modal/child_services.dart';

class ServiceList {
  String _icon;
  String _name;
  String _price;
  bool _isChecked;
  List<ChildSerices> _otherservices;

  ServiceList(this._icon, this._name, this._price, this._isChecked,
      this._otherservices);


  List<ChildSerices> get otherservices => _otherservices;

  set otherservices(List<ChildSerices> value) {
    _otherservices = value;
  }

  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get icon => _icon;

  set icon(String value) {
    _icon = value;
  }

}