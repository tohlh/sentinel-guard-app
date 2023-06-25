class Bank {
  final String name;
  final String bankCommunicationKey;
  final String userCommunicationKey;
  final String publicKey;

  const Bank({
    required this.name,
    required this.bankCommunicationKey,
    required this.userCommunicationKey,
    required this.publicKey,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      name: json['name'],
      bankCommunicationKey: json['bankCommunicationKey'],
      userCommunicationKey: json['userCommunicationKey'],
      publicKey: json['publicKey'],
    );
  }
}
