class PlanetInfo {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;

  PlanetInfo(
      this.position, {
        this.name,
        this.iconImage,
        this.description,
        this.images,
      });
}

List<PlanetInfo> planets = [
  PlanetInfo(1,
      name: 'Pose 1',
      iconImage: '',
      description:
      "Kapotasana invigorates your body and gives your spirits a lift. This extremely deep backbend is appropriate for advanced practitioners only.",
        images: [
          'https://www.yogajournal.com/wp-content/uploads/2007/08/2yogapedia_273_13_fnl.jpg?crop=535:301&width=1070&enable=upscale',
          'https://www.fitzabout.com/wp-content/uploads/2021/06/One-Legged-King-Pigeon-Pose-Eka-Pada-Rajakapotasana-Fitzabout.jpg'
             ]),
  PlanetInfo(2,
      name: 'Pose 2',
      iconImage: '',
      description:
        "Want to, like, connect with cosmic energy? Nataraja is another name for Shiva and his dance symbolizes cosmic energy. Natarajasana, or Lord of the Dance",
      images: [
         'https://www.yogajournal.com/wp-content/uploads/2007/08/3enneagram_289_1454_bjk.jpg?crop=535:301&width=1070&enable=upscale',
         'https://www.verywellfit.com/thmb/DiWK05qMu_qBsx_8o5eODlxfsNo=/2500x1667/filters:fill(FFDB5D,1)/Verywell-14-3566690-KingDancer02-827-5c4b724146e0fb000167c61c.jpg'
          ]),
  PlanetInfo(3,
      name: 'Pose 3',
      iconImage: '',
      description:
      "Lotus Pose, or Padmasana in Sanskrit, requires open hips and consistent practice. This pose creates an essential foundation for meditation practice while helping to manage stress with a conscious stretch in the front of the thighs and ankles.",
       images: [
         'https://www.yogajournal.com/wp-content/uploads/2007/08/ccd04508.jpg?crop=535:301&width=1070&enable=upscale',
         'https://lh3.googleusercontent.com/proxy/qkpD9iPxJE0cf5Hre0t9Cx0Zc1MqotHvRw0bP4oXv-b8Xp_2FNpFUYPHLvo-C0_Nfueuv3TWYOMVxWtts4DxAvEZwUtzD0u5Iy5NX6PJA7Od9Go6eDBT3Y0orWAFlyb5p7QiJjmBoR-uTCE2JmcPb8ZI37EU1wQ9IWUmxP8O_FWiOi9wH6s'
         ]),
  PlanetInfo(4,
      name: 'Pose 4',
      iconImage: '',
      description:
      "According to Hindu lore, the Peacock symbolizes immortality, love, and patience. Peacock Pose, called Mayurasana in Sanskrit, works to lovingly strengthen the core while stretching the palm side of the wrists.",
      images: [
       'https://www.yogajournal.com/wp-content/uploads/2008/05/peacock-master.jpg?crop=535:301&width=1070&enable=upscale',
        'https://media.istockphoto.com/photos/young-sporty-attractive-woman-practicing-yoga-doing-peacock-exercise-picture-id1046581596?k=6&m=1046581596&s=612x612&w=0&h=9fSlqlXg39xiAtI_jo4xFJEygtjggDu6lOl24GzBRzU='
         ]),
  PlanetInfo(5,
      name: 'Pose 5',
      iconImage: '',
      description:
        "Eka Pada Koundinyasana I or Pose Dedicated to the Sage Koundinya I has a lot going on—the twist, the legs going their separate ways, oh, and the arm balance. Master it.",
      images: [
        'https://www.yogajournal.com/wp-content/uploads/2007/08/nov-14-yogapedia-eka-pada-koundinyasana-1.jpg?crop=535:301&width=1070&enable=upscale',
        'https://www.yogajournal.com/wp-content/uploads/2019/10/thesagekoudinya1.jpg?crop=3:2&width=300'
         ]),
  PlanetInfo(6,
      name: 'Pose 6',
      iconImage: '',
      description:
      "Pose Dedicated to the Sage Koundinya II tones the belly and spine, strengthens the arms and wrists, and gives your self-confidence a big boost.",
      images: [
        'https://www.yogajournal.com/wp-content/uploads/2007/08/eka-pada-koundinyasana-coby-kozlowski.jpg?crop=535:301&width=1070&enable=upscale',
        'https://i.pinimg.com/originals/2b/78/83/2b788350fc3e9146a99bebb5d45c4523.jpg'
         ]),
  PlanetInfo(7,
      name: 'Pose 7',
      iconImage: '',
      description:
      "Can you practice Wheel with straight arms and Headstand without strain? Then, you're ready.",
      images: [
        'https://www.yogajournal.com/wp-content/uploads/2007/08/upward-facing-two-foot-staff-pose.jpg?crop=535:301&width=1070&enable=upscale',
        'https://media.istockphoto.com/vectors/upward-facing-twofoot-staff-pose-yoga-manga-tutorial-how-cartoon-vector-id1180557761'
         ]),
  PlanetInfo(8,
      name: 'Pose 8',
      iconImage: '',
      description:
         "Kino MacGregor says careful emphasis on technique and strategic preparation will help you find the energy to move beyond your limits one breath at a time.",
      images: [
        'https://www.yogajournal.com/wp-content/uploads/2015/02/kinoshoot_51-a.jpg?crop=535:301&width=1070&enable=upscale',
        'https://stylesatlife.com/wp-content/uploads/2018/03/Bhujapidasana-Arm-Pressing-Posture-How-To-Do-And-Benefits.jpg'
         ]),
];