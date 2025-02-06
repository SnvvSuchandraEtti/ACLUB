class ClubMember {
  final String role;
  final String firstName;
  final String lastName;
  final String rollNo;
  final String phoneNo;

  ClubMember({
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.rollNo,
    required this.phoneNo,
  });

  factory ClubMember.fromJson(Map<String, dynamic> json) {
    return ClubMember(
      role: json['role'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      rollNo: json['rollNo'],
      phoneNo: json['phoneNo'].toString(),
    );
  }
}