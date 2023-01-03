class PledgeForm {
  int user_id;
  int type_id;
  int purpose_id;
  String amount;
  String name;
  String description;
  bool status = true;
  String deadline;

  PledgeForm({
    required this.amount,
    required this.deadline,
    required this.description,
    required this.purpose_id,
    required this.name,
    required this.status,
    required this.type_id,
    required this.user_id,
  });
}
