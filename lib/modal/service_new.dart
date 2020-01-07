class Services {
  String _imageurl;
  String _name;
  String _isnew;
  String _radioButton;

  Services(this._imageurl, this._name, this._isnew, this._radioButton);

  String get radioButton => _radioButton;

  set radioButton(String value) {
    _radioButton = value;
  }

  String get isnew => _isnew;

  set isnew(String value) {
    _isnew = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get imageurl => _imageurl;

  set imageurl(String value) {
    _imageurl = value;
  }
}
