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
      "This pose gently lengthens and strengthens even stubbornly tight hamstrings. tand upright with your inner feet parallel and about six inches apart. Contract your front thigh muscles to lift your kneecaps. Keeping your legs completely straight, exhale and bend forward from your hip joints, moving your torso and head as one unit.",
      images: [
          'https://www.yogajournal.com/wp-content/uploads/2007/08/big-toe-pose.jpg',
          'https://i.pinimg.com/originals/23/9e/85/239e8557b918e1488828371d2c5eb2b9.jpg'
          ]),
  PlanetInfo(2,
      name: 'Pose 2',
      iconImage: '',
      description:
      "An ab and deep hip flexor strengthener, Boat Pose, or Paripurna Navasana in Sanskrit, requires you to balance on the tripod of your sitting bones and tailbone to build mental and physical focus, inspiring a full-body awareness.",
      images: [
        'https://www.yogajournal.com/wp-content/uploads/2007/08/editedboathp_292_8_bjk.jpg?crop=535:301&width=1070&enable=upscale',
        'https://www.ekhartyoga.com/media/image/articles/Boat-pose-Navasana-Ekhart-Yoga.jpg'
      ]),
  PlanetInfo(3,
      name: 'Pose 3',
      iconImage: '',
      description:
      "Bend back into the shape of a bow to feel energetically locked, loaded, and ready to take aim.",
      images: [
          'https://www.yogajournal.com/wp-content/uploads/2007/08/3enneagram_289_1380_bjk.jpg?crop=535:301&width=1070&enable=upscale',
          'https://images.squarespace-cdn.com/content/v1/5008a3c6c4aa6450352d2303/1389624068277-2PW15DJSBEHIDSTQG69E/how-to-do-bow-pose.jpg'
         ]),
  PlanetInfo(4,
      name: 'Pose 4',
      iconImage: '',
      description:
        "Bump up your energy by bending back into Camel Pose, called Urstrasana in Sanskrit. Urstrasana counteracts slouching and relieves lower back pain with a generous, heart-opening stretch while also helping to build confidence.",
       images: [
        'https://www.yogajournal.com/wp-content/uploads/2007/08/ccd03730.jpg?crop=535:301&width=1070&enable=upscale',
         'https://www.verywellfit.com/thmb/nRAjnpUWgjRu4qycJyVMJwl5eP4=/1500x1000/filters:no_upscale():max_bytes(150000):strip_icc()/CamelPose_annotated-a64d3e6977d04250b5ae442ab07e88a3.jpg'
         ]),
  PlanetInfo(5,
      name: 'Pose 5',
      iconImage: '',
      description: "A compact arm balance, Crane Pose/Crow Pose, called Bakasana in Sanskrit, encourages toning in the abs and the arms, strengthening in the core, and improves focus in the mind.",
      images: [
        'https://www.yogajournal.com/wp-content/uploads/2007/08/editcrowhp_292_9_bjk.jpg?crop=535:301&width=1070&enable=upscale',
        'https://yogabodyandbalance.com/wp-content/uploads/2020/12/CRANE-CROW-POSE-BAKASANA-1.jpg'
         ]),
  PlanetInfo(6,
      name: 'Pose 6',
      iconImage: '',
      description:
        "A modification of Plank Pose, Dolphin Plank Pose strengthens and tones the core, thighs, and arms.",
      images: [
        'https://www.yogajournal.com/wp-content/uploads/2007/08/3anatomy_287_3356_bjk.jpg?crop=535:301&width=1070&enable=upscale',
        'https://cdn.crello.com/api/media/small/164047442/stock-photo-woman-standing-in-plank'
         ]),
  PlanetInfo(7,
      name: 'Pose 7',
      iconImage: '',
      description:
      "You need strength, flexibility, and endurance, and unwavering concentration for Eagle Pose.",
       images: [
         'https://www.yogajournal.com/wp-content/uploads/2007/08/eaglehp2_292_37370_cmyk.jpg?crop=535:301&width=1070&enable=upscale',
         'https://www.verywellfit.com/thmb/O_Hzip3_YmXXNC8_M5ELFY6JcSE=/1500x1000/filters:no_upscale():max_bytes(150000):strip_icc()/EaglePose_annotated-855cf97d6d954c64bea55c10f1490724.jpg'
      ]),
  PlanetInfo(8,
      name: 'Pose 8',
      iconImage: '',
      description:
         "In Extended Hand-to-big-toe Pose, maintaining solid grounding through the standing foot helps keep you steady.",
       images: [
        'https://www.yogajournal.com/wp-content/uploads/2007/08/2yp_285_1542_prf.jpg?crop=535:301&width=1070&enable=upscale',
        'https://www.ekhartyoga.com/media/images/articles/content/Extended-Hand-to-Big-Toe-Pose.jpg'
         ]),
];