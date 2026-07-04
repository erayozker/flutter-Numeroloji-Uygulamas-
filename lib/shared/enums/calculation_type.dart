enum CalculationType {
  all,
  lifePath,
  destiny,
  soulUrge,
  personality;

  String get label {
    return switch (this) {
      CalculationType.all => 'T\u00fcm\u00fc',
      CalculationType.lifePath => 'Ya\u015fam Yolu',
      CalculationType.destiny => 'Kader Say\u0131s\u0131',
      CalculationType.soulUrge => 'Ruh Arzusu',
      CalculationType.personality => 'Ki\u015filik Say\u0131s\u0131',
    };
  }
}
