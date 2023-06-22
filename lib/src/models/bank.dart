class Bank {
  final String name;
  final String bankCommunicationKey;
  final String userCommunicationKey;

  const Bank({
    required this.name,
    required this.bankCommunicationKey,
    required this.userCommunicationKey,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      name: json['name'],
      bankCommunicationKey: json['bankCommunicationKey'],
      userCommunicationKey: json['userCommunicationKey'],
    );
  }
}
