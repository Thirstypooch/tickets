class Host {
  final String name;
  final String avatar;

  const Host({required this.name, required this.avatar});
}

class HostDetail {
  final String name;
  final String avatar;
  final String joinedDate;
  final String responseRate;
  final String responseTime;

  const HostDetail({
    required this.name,
    required this.avatar,
    required this.joinedDate,
    required this.responseRate,
    required this.responseTime,
  });
}
