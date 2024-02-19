class Message {
  Message(
      {required this.told,
      required this.msg,
      required this.read,
      required this.type,
      required this.formId,
      required this.sent});
  late final String told;
  late final String msg;
  late final String read;
  late final Type type;
  late final String formId;
  late final String sent;

  Message.fromJson(Map<String, dynamic> json) {
    told = json['told'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    type = json['type'].toString()==Type.image.name?Type.image:Type.text;
    formId = json['formId'].toString();
    sent = json['sent'].toString();
  }
  Map<String, dynamic> tojson() {
    final data = <String, dynamic>{};
    data['toId'] = told;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = type.name;
    data['formId'] = formId;
    data['sent'] = sent;

    return data;
  }
}
enum Type {
  text,image
}
