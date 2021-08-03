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
      "In mountain pose there is a lot going on, even though it may look like just standing.",
         images: [
        'https://www.gaia.com/wp-content/uploads/Tadasana-StephSchwartz-768x432.jpg',
        'https://yogadigest.com/wp-content/uploads/2019/11/Header-mountain_pose-750x441-735x432.jpg',
        ]),
  PlanetInfo(2,
      name: 'Pose 2',
      iconImage: '',
      description:
      "Inhale and bring your arms up and over your head. Raised arms pose is your basic morning stretch, but focus on keeping the good alignment you established in mountain pose.",
      images: [
        'https://www.lawyersupdate.co.in/wp-content/uploads/2019/02/4.jpg',
        'https://www.yogaclassplan.com/wp-content/uploads/2015/11/Raised-Arm-Pose.jpg'
      ]),
  PlanetInfo(3,
      name: 'Pose 3',
      iconImage: '',
      description:
      "Exhale and fold over your legs into a forward bend. If the hamstrings feel a little tight at first, bend the knees so that you can release your spine. Let the head hang heavy. Keep the legs gently bent with feet hip-width apart for better stability (you can straighten the legs, but it is not necessary). You can clasp opposite elbows with opposite hands while swaying gently side to side.",
          images: [
        'https://www.verywellfit.com/thmb/YWogPqJj82uvrLItRAPZ-9x7wdo=/1500x1000/filters:no_upscale():max_bytes(150000):strip_icc()/StandingForwardBend_annotated-6440e933400844368b278c561db7fe82.jpg',
        'https://www.ekhartyoga.com/media/images/articles/content/Uttanasana-Standing-forward-fold-Esther-Ekhart-Yoga.jpg',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbyFPH6np_ozaBMiPR1CQBhDlNIRBzX2wNj4U2KzLSNaZwtppXd0EmBj4gkwF0LQquaZQ&usqp=CAU',
         ]),
  PlanetInfo(4,
      name: 'Pose 4',
      iconImage: '',
      description:
      "Move your feet out to the edges of your mat and bend your knees, coming into a squat. The toes may turn out if necessary. If your heels do not reach the floor, you can sit on two stacked blocks. This modification makes the pose more accessible for many people." ,
      images: [
        'https://www.gaia.com/wp-content/uploads/Meta-GAIA_CAVEMANCOLLECTIVE-190-squat-pose-1024x576-768x432.jpg',
        'https://www.yogateket.com/image/original/malasanapose.jpg',
        'https://www.verywellfit.com/thmb/08WJylVicjRk_cQBuQL3IU3i94g=/1500x1000/filters:no_upscale():max_bytes(150000):strip_icc()/GarlandPose_annotated-b5c747a639ec4929a59307c20ce42a1f.jpg'
      ]),
  PlanetInfo(5,
      name: 'Pose 5',
      iconImage: 'assets/jupiter.png',
      description: "From malasana, come back into a forward fold with legs gently bent and feet underneath your hips. When you are ready, step your left leg to the back of your mat and bend your right knee for a deep lunge.",

      images: [
        'https://www.verywellfit.com/thmb/2npbeliACbYbCNdB75cFss4WzO4=/1500x1000/filters:fill(FFDB5D,1)/Lunges_unannotated1-399b9230f4154a30ad89034ba260fc1b.jpg',
        'https://cdn.prod.openfit.com/uploads/2019/09/12180012/static-lunge-header-1200x600.jpg',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbIKucyEvHwj72znBie6IA6rmtCfiajcYOFubjvf9oKfsORanbRqmn9uqiYXBwarGBLyc&usqp=CAU'
      ]),
  PlanetInfo(6,
      name: 'Pose 6',
      iconImage: '',
      description:
      "After your second lunge, step the left foot to the back of the mat. Feet should be hip-width apart. Hips should be level with the shoulders. This is the classic preparation for a push-up. Stay here for five breaths while making sure that your hips do not drop too low or rise too high.",
      images: [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu2zmfhniRrggAxeaLVk3Vr20iyFTTbEntTDcYYxlnlfmImLbMLD9b12Up9BFSRUyLto4&usqp=CAU',
        'https://i20.haber7.net/resize/1300x731//haber/haber7/photos/2020/06/plank_hareketi_ne_ise_yarar_evde_etkili_plank_hareketi_nasil_yapilir_5_dakikada_karin_kasi_1581166163_4639.jpg'
      ]),
  PlanetInfo(7,
      name: 'Pose 7',
      iconImage: '',
      description:
      "After catching your breath, swing your legs around so that they are outstretched in front of you. Staff pose is the seated equivalent of mountain pose, in that it seems very simple but has a lot going on.",
      images: [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScYKC7N-yQavXFPguw517k1xOh3jIaozb84xJWRZoMXN54mK5R_iBK-dpPkWmkRg5buUs&usqp=CAU',
        'https://www.yogajournal.com/wp-content/uploads/2007/08/staff-pose.jpg'
      ]),
  PlanetInfo(8,
      name: 'Pose 8',
      iconImage: '',
      description:
      "On an exhalation, bring your torso over your legs in a forward bend. Allow a gentle bend in the knees to keep this pose simple and manageable.",
      images: [
        'https://3i133rqau023qjc1k3txdvr1-wpengine.netdna-ssl.com/wp-content/uploads/2014/11/Yoga_Seated-Forward-Fold_Exercise.jpg',
        'https://www.yogajournal.com/wp-content/uploads/2007/08/promoforwardfoldhp2_292_37503_cmyk.jpg'
      ]),
];