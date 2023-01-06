class PledgeForm {
  int type_id;
  int purpose_id;
  String amount;
  String name;
  String description;
  String deadline;

  PledgeForm({
    required this.amount,
    required this.deadline,
    required this.description,
    required this.purpose_id,
    required this.name,
    required this.type_id,
  });
}
