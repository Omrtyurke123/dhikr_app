import '../models/dhikr_model.dart';

class AdhkarData {
  static const List<DhikrCategory> categories = [
    // ─── MORNING ────────────────────────────────────────────────────────────
    DhikrCategory(
      id: 'morning',
      title: 'أذكار الصباح',
      subtitle: 'Morning Adhkar',
      iconAsset: 'morning',
      type: CategoryType.morning,
      items: [
        DhikrItem(
          id: 'm1',
          arabic: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
          translation: 'We have reached the morning and at this very time all sovereignty belongs to Allah. Praise be to Allah. None has the right to be worshipped but Allah alone, Who has no partner.',
          defaultCount: 1,
          virtue: 'يُقرأ مرة واحدة في الصباح',
        ),
        DhikrItem(
          id: 'm2',
          arabic: 'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ',
          translation: 'O Allah, by You we enter the morning, by You we enter the evening, by You we live and by You we die, and to You is the resurrection.',
          defaultCount: 1,
          virtue: 'دعاء الصباح',
        ),
        DhikrItem(
          id: 'm3',
          arabic: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
          translation: 'O Allah, You are my Lord. None has the right to be worshipped except You. You created me and I am Your servant and I abide to Your covenant and promise as best I can.',
          defaultCount: 1,
          virtue: 'سيد الاستغفار — من قاله موقناً به فمات من يومه دخل الجنة',
        ),
        DhikrItem(
          id: 'm4',
          arabic: 'رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِينًا، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا',
          translation: 'I am pleased with Allah as my Lord, Islam as my religion and Muhammad (ﷺ) as my Prophet.',
          defaultCount: 3,
          virtue: 'من قالها ثلاثاً كان حقاً على الله أن يُرضيه يوم القيامة',
        ),
        DhikrItem(
          id: 'm5',
          arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
          translation: 'Glory be to Allah and praise be to Him.',
          defaultCount: 100,
          virtue: 'من قالها مئة مرة حُطَّت خطاياه وإن كانت مثل زبد البحر',
        ),
        DhikrItem(
          id: 'm6',
          arabic: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
          translation: 'None has the right to be worshipped but Allah alone, Who has no partner. His is the dominion and His is the praise, and He is able to do all things.',
          defaultCount: 10,
          virtue: 'من قالها عشر مرات كانت كمن أعتق أربعة أنفس من ولد إسماعيل',
        ),
        DhikrItem(
          id: 'm7',
          arabic: 'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ أَصْلِحْ لِي شَأْنِي كُلَّهُ وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ',
          translation: 'O Ever Living, O Self-Subsisting, by Your mercy I seek help. Rectify all my affairs and do not leave me to myself even for the blink of an eye.',
          defaultCount: 1,
          virtue: 'دعاء الصباح والمساء',
        ),
        DhikrItem(
          id: 'm8',
          arabic: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
          translation: 'I seek refuge in the perfect words of Allah from the evil of what He has created.',
          defaultCount: 3,
          virtue: 'لَمْ يَضُرَّهُ شيء حتى يَرتحل من منزله ذلك',
        ),
        DhikrItem(
          id: 'm9',
          arabic: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
          translation: 'In the name of Allah with Whose name nothing can harm on earth or in heaven, and He is the All-Hearing, the All-Knowing.',
          defaultCount: 3,
          virtue: 'لن يضره شيء',
        ),
      ],
    ),

    // ─── EVENING ────────────────────────────────────────────────────────────
    DhikrCategory(
      id: 'evening',
      title: 'أذكار المساء',
      subtitle: 'Evening Adhkar',
      iconAsset: 'evening',
      type: CategoryType.evening,
      items: [
        DhikrItem(
          id: 'e1',
          arabic: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
          translation: 'We have reached the evening and at this very time all sovereignty belongs to Allah. Praise be to Allah. None has the right to be worshipped but Allah alone.',
          defaultCount: 1,
          virtue: 'يُقرأ مرة واحدة في المساء',
        ),
        DhikrItem(
          id: 'e2',
          arabic: 'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ الْمَصِيرُ',
          translation: 'O Allah, by You we enter the evening, by You we enter the morning, by You we live and by You we die, and to You is the final return.',
          defaultCount: 1,
          virtue: 'دعاء المساء',
        ),
        DhikrItem(
          id: 'e3',
          arabic: 'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إِلَّا أَنْتَ',
          translation: 'O Allah, grant me health in my body. O Allah, grant me health in my hearing. O Allah, grant me health in my sight. None has the right to be worshipped but You.',
          defaultCount: 3,
          virtue: 'يُقرأ ثلاث مرات صباحاً ومساءً',
        ),
        DhikrItem(
          id: 'e4',
          arabic: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ',
          translation: 'O Allah, I ask You for pardon and well-being in this life and the next.',
          defaultCount: 3,
          virtue: 'يُقرأ ثلاث مرات صباحاً ومساءً',
        ),
        DhikrItem(
          id: 'e5',
          arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
          translation: 'Glory be to Allah and praise be to Him.',
          defaultCount: 100,
          virtue: 'من قالها مئة مرة حُطَّت خطاياه',
        ),
        DhikrItem(
          id: 'e6',
          arabic: 'اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ',
          translation: 'O Allah, I have reached the evening and call on You, the bearers of Your Throne, Your angels, and all of Your creation to witness that You are Allah, none has the right to be worshipped but You alone.',
          defaultCount: 4,
          virtue: 'أعتقه الله من النار ربع النار',
        ),
      ],
    ),

    // ─── NIGHT PRAYER ───────────────────────────────────────────────────────
    DhikrCategory(
      id: 'night',
      title: 'أذكار قيام الليل',
      subtitle: 'Night Prayer Adhkar',
      iconAsset: 'night',
      type: CategoryType.night,
      items: [
        DhikrItem(
          id: 'n1',
          arabic: 'اللَّهُمَّ لَكَ الْحَمْدُ أَنْتَ نُورُ السَّمَاوَاتِ وَالْأَرْضِ وَمَنْ فِيهِنَّ، وَلَكَ الْحَمْدُ أَنْتَ قَيِّمُ السَّمَاوَاتِ وَالْأَرْضِ وَمَنْ فِيهِنَّ',
          translation: 'O Allah, praise be to You. You are the Light of the heavens and the earth and whoever is in them. And praise be to You; You are the Sustainer of the heavens and the earth.',
          defaultCount: 1,
          virtue: 'دعاء قيام الليل',
        ),
        DhikrItem(
          id: 'n2',
          arabic: 'سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ، تَبَارَكَ اسْمُكَ، وَتَعَالَى جَدُّكَ، وَلَا إِلَهَ غَيْرُكَ',
          translation: 'Glory be to You, O Allah, and praise. Blessed is Your Name, exalted is Your Majesty, there is no god but You.',
          defaultCount: 1,
          virtue: 'دعاء الاستفتاح في الصلاة',
        ),
        DhikrItem(
          id: 'n3',
          arabic: 'اللَّهُمَّ رَبَّ جِبْرَائِيلَ وَمِيكَائِيلَ وَإِسْرَافِيلَ، فَاطِرَ السَّمَاوَاتِ وَالْأَرْضِ، عَالِمَ الْغَيْبِ وَالشَّهَادَةِ، أَنْتَ تَحْكُمُ بَيْنَ عِبَادِكَ فِيمَا كَانُوا فِيهِ يَخْتَلِفُونَ',
          translation: 'O Allah, Lord of Jibreel, Mikael and Israfeel, Creator of the heavens and the earth, Knower of the seen and unseen...',
          defaultCount: 1,
          virtue: 'دعاء النبي ﷺ عند قيام الليل',
        ),
      ],
    ),

    // ─── AFTER PRAYER ───────────────────────────────────────────────────────
    DhikrCategory(
      id: 'prayer',
      title: 'أذكار الصلاة',
      subtitle: 'After Prayer Adhkar',
      iconAsset: 'prayer',
      type: CategoryType.prayer,
      items: [
        DhikrItem(
          id: 'p1',
          arabic: 'سُبْحَانَ اللَّهِ',
          translation: 'Glory be to Allah.',
          defaultCount: 33,
          virtue: 'يُقال ثلاثاً وثلاثين مرة بعد كل صلاة',
        ),
        DhikrItem(
          id: 'p2',
          arabic: 'الْحَمْدُ لِلَّهِ',
          translation: 'Praise be to Allah.',
          defaultCount: 33,
          virtue: 'يُقال ثلاثاً وثلاثين مرة بعد كل صلاة',
        ),
        DhikrItem(
          id: 'p3',
          arabic: 'اللَّهُ أَكْبَرُ',
          translation: 'Allah is the Greatest.',
          defaultCount: 33,
          virtue: 'يُقال ثلاثاً وثلاثين مرة بعد كل صلاة',
        ),
        DhikrItem(
          id: 'p4',
          arabic: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
          translation: 'None has the right to be worshipped but Allah alone, Who has no partner. His is the dominion and His is the praise, and He is able to do all things.',
          defaultCount: 1,
          virtue: 'يُكمل المئة — غُفرت له خطاياه وإن كانت مثل زبد البحر',
        ),
        DhikrItem(
          id: 'p5',
          arabic: 'اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ، وَشُكْرِكَ، وَحُسْنِ عِبَادَتِكَ',
          translation: 'O Allah, help me remember You, to be grateful to You, and to worship You in the best manner.',
          defaultCount: 1,
          virtue: 'يُقال دُبر كل صلاة',
        ),
        DhikrItem(
          id: 'p6',
          arabic: 'آيَةُ الْكُرْسِيِّ:\nاللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ، لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ، لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ',
          translation: 'Ayat Al-Kursi: Allah — there is no deity except Him, the Ever-Living, the Sustainer of existence. Neither drowsiness overtakes Him nor sleep...',
          defaultCount: 1,
          virtue: 'من قرأها دُبر كل صلاة لم يمنعه من دخول الجنة إلا الموت',
        ),
      ],
    ),

    // ─── SLEEP ──────────────────────────────────────────────────────────────
    DhikrCategory(
      id: 'sleep',
      title: 'أذكار النوم',
      subtitle: 'Sleep Adhkar',
      iconAsset: 'sleep',
      type: CategoryType.sleep,
      items: [
        DhikrItem(
          id: 's1',
          arabic: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
          translation: 'In Your name, O Allah, I die and I live.',
          defaultCount: 1,
          virtue: 'يُقال عند النوم',
        ),
        DhikrItem(
          id: 's2',
          arabic: 'اللَّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبْعَثُ عِبَادَكَ',
          translation: 'O Allah, protect me from Your punishment on the day You resurrect Your servants.',
          defaultCount: 3,
          virtue: 'يُقال ثلاث مرات قبل النوم',
        ),
        DhikrItem(
          id: 's3',
          arabic: 'سُبْحَانَ اللَّهِ',
          translation: 'Glory be to Allah.',
          defaultCount: 33,
          virtue: 'أَلَا أَدُلُّكُمَا عَلَى مَا هُوَ خَيْرٌ لَكُمَا مِنْ خَادِمٍ',
        ),
        DhikrItem(
          id: 's4',
          arabic: 'الْحَمْدُ لِلَّهِ',
          translation: 'Praise be to Allah.',
          defaultCount: 33,
          virtue: 'يُقال ثلاثاً وثلاثين مرة قبل النوم',
        ),
        DhikrItem(
          id: 's5',
          arabic: 'اللَّهُ أَكْبَرُ',
          translation: 'Allah is the Greatest.',
          defaultCount: 34,
          virtue: 'يُقال أربعاً وثلاثين مرة قبل النوم',
        ),
        DhikrItem(
          id: 's6',
          arabic: 'اللَّهُمَّ أَسْلَمْتُ نَفْسِي إِلَيْكَ، وَفَوَّضْتُ أَمْرِي إِلَيْكَ، وَوَجَّهْتُ وَجْهِي إِلَيْكَ، وَأَلْجَأْتُ ظَهْرِي إِلَيْكَ، رَغْبَةً وَرَهْبَةً إِلَيْكَ، لَا مَلْجَأَ وَلَا مَنْجَا مِنْكَ إِلَّا إِلَيْكَ',
          translation: 'O Allah, I submit my soul to You, entrust my affairs to You, turn my face to You, and depend on You in hope and fear of You.',
          defaultCount: 1,
          virtue: 'من قاله ومات من ليلته مات على الفطرة',
        ),
      ],
    ),

    // ─── MISC ────────────────────────────────────────────────────────────────
    DhikrCategory(
      id: 'misc',
      title: 'أدعية متنوعة',
      subtitle: 'Various Supplications',
      iconAsset: 'misc',
      type: CategoryType.misc,
      items: [
        DhikrItem(
          id: 'misc1',
          arabic: 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
          translation: 'Allah is sufficient for us, and He is the best disposer of affairs.',
          defaultCount: 7,
          virtue: 'يُقال سبع مرات صباحاً ومساءً',
        ),
        DhikrItem(
          id: 'misc2',
          arabic: 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
          translation: 'There is no power and no strength except with Allah.',
          defaultCount: 100,
          virtue: 'كنز من كنوز الجنة',
        ),
        DhikrItem(
          id: 'misc3',
          arabic: 'لَا إِلَهَ إِلَّا اللَّهُ',
          translation: 'None has the right to be worshipped but Allah.',
          defaultCount: 100,
          virtue: 'أفضل الذكر',
        ),
      ],
    ),

    // ─── ISTIGHFAR ──────────────────────────────────────────────────────────
    DhikrCategory(
      id: 'istighfar',
      title: 'الاستغفار',
      subtitle: 'Seeking Forgiveness',
      iconAsset: 'istighfar',
      type: CategoryType.istighfar,
      items: [
        DhikrItem(
          id: 'ig1',
          arabic: 'أَسْتَغْفِرُ اللَّهَ',
          translation: 'I seek forgiveness from Allah.',
          defaultCount: 100,
          virtue: 'كان النبي ﷺ يستغفر الله في اليوم أكثر من سبعين مرة',
        ),
        DhikrItem(
          id: 'ig2',
          arabic: 'أَسْتَغْفِرُ اللَّهَ الْعَظِيمَ',
          translation: 'I seek forgiveness from Allah, the Most Great.',
          defaultCount: 100,
          virtue: 'استغفار عظيم',
        ),
        DhikrItem(
          id: 'ig3',
          arabic: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
          translation: 'I seek the forgiveness of Allah and repent to Him.',
          defaultCount: 100,
          virtue: 'كان النبي ﷺ يقولها مئة مرة في اليوم',
        ),
        DhikrItem(
          id: 'ig4',
          arabic: 'أَسْتَغْفِرُ اللَّهَ الَّذِي لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَأَتُوبُ إِلَيْهِ',
          translation: 'I seek forgiveness from Allah, besides Whom none has the right to be worshipped, the Ever-Living, the Sustainer, and I repent to Him.',
          defaultCount: 3,
          virtue: 'غُفر له وإن كان فَرَّ من الزحف',
        ),
        DhikrItem(
          id: 'ig5',
          arabic: 'رَبِّ اغْفِرْ لِي وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ',
          translation: 'My Lord, forgive me and accept my repentance. Indeed You are the Ever-Accepting of repentance, the Most Merciful.',
          defaultCount: 100,
          virtue: 'كان النبي ﷺ يقولها مئة مرة في مجلسه',
        ),
        DhikrItem(
          id: 'ig6',
          arabic: 'سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ، أَسْتَغْفِرُكَ وَأَتُوبُ إِلَيْكَ',
          translation: 'Glory be to You, O Allah, and praise. I seek Your forgiveness and repent to You.',
          defaultCount: 10,
          virtue: 'كفارة المجلس',
        ),
        DhikrItem(
          id: 'ig7',
          arabic: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
          translation: 'O Allah, You are my Lord. None has the right to be worshipped except You. You created me and I am Your servant...',
          defaultCount: 1,
          virtue: 'سيد الاستغفار — من قاله موقناً به فمات من يومه دخل الجنة',
        ),
      ],
    ),

    // ─── TASBEEH ────────────────────────────────────────────────────────────
    DhikrCategory(
      id: 'tasbeeh',
      title: 'التسبيح',
      subtitle: 'Glorification of Allah',
      iconAsset: 'tasbeeh',
      type: CategoryType.tasbeeh,
      items: [
        DhikrItem(
          id: 'ts1',
          arabic: 'سُبْحَانَ اللَّهِ',
          translation: 'Glory be to Allah.',
          defaultCount: 33,
          virtue: 'يُقال ثلاثاً وثلاثين مرة بعد الصلاة',
        ),
        DhikrItem(
          id: 'ts2',
          arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
          translation: 'Glory be to Allah and praise be to Him.',
          defaultCount: 100,
          virtue: 'من قالها مئة مرة غُفرت له خطاياه وإن كانت مثل زبد البحر',
        ),
        DhikrItem(
          id: 'ts3',
          arabic: 'سُبْحَانَ اللَّهِ الْعَظِيمِ',
          translation: 'Glory be to Allah, the Most Great.',
          defaultCount: 100,
          virtue: 'أحب الكلام إلى الله',
        ),
        DhikrItem(
          id: 'ts4',
          arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ، سُبْحَانَ اللَّهِ الْعَظِيمِ',
          translation: 'Glory be to Allah and praise be to Him; glory be to Allah, the Most Great.',
          defaultCount: 100,
          virtue: 'كلمتان خفيفتان على اللسان، ثقيلتان في الميزان، حبيبتان إلى الرحمن',
        ),
        DhikrItem(
          id: 'ts5',
          arabic: 'سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ وَلَا إِلَهَ إِلَّا اللَّهُ وَاللَّهُ أَكْبَرُ',
          translation: 'Glory be to Allah, praise be to Allah, none has the right to be worshipped but Allah, and Allah is the Greatest.',
          defaultCount: 100,
          virtue: 'أحب إليّ مما طلعت عليه الشمس',
        ),
        DhikrItem(
          id: 'ts6',
          arabic: 'سُبْحَانَ اللَّهِ عَدَدَ خَلْقِهِ، سُبْحَانَ اللَّهِ رِضَا نَفْسِهِ، سُبْحَانَ اللَّهِ زِنَةَ عَرْشِهِ، سُبْحَانَ اللَّهِ مِدَادَ كَلِمَاتِهِ',
          translation: 'Glory be to Allah as much as the number of His creation, glory be to Allah as much as His pleasure...',
          defaultCount: 3,
          virtue: 'يَعدل تسبيح اليوم كله',
        ),
        DhikrItem(
          id: 'ts7',
          arabic: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
          translation: 'None has the right to be worshipped but Allah alone, Who has no partner. His is the dominion and His is the praise, and He is able to do all things.',
          defaultCount: 100,
          virtue: 'من قالها مئة مرة كانت له عِدل عشر رقاب',
        ),
      ],
    ),

    // ─── SALAWAT ────────────────────────────────────────────────────────────
    DhikrCategory(
      id: 'salawat',
      title: 'الصلاة على النبي ﷺ',
      subtitle: 'Sending Prayers upon the Prophet',
      iconAsset: 'salawat',
      type: CategoryType.salawat,
      items: [
        DhikrItem(
          id: 'sl1',
          arabic: 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ',
          translation: 'O Allah, send prayers upon Muhammad.',
          defaultCount: 100,
          virtue: 'من صلى عليّ مرة صلى الله عليه عشراً',
        ),
        DhikrItem(
          id: 'sl2',
          arabic: 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ',
          translation: 'O Allah, send prayers upon Muhammad and upon the family of Muhammad.',
          defaultCount: 100,
          virtue: 'من صلى عليّ مرة صلى الله عليه عشراً',
        ),
        DhikrItem(
          id: 'sl3',
          arabic: 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ، كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ، إِنَّكَ حَمِيدٌ مَجِيدٌ',
          translation: 'O Allah, send prayers upon Muhammad and upon the family of Muhammad, as You sent prayers upon Ibrahim and upon the family of Ibrahim. Indeed, You are Praiseworthy and Glorious.',
          defaultCount: 10,
          virtue: 'الصلاة الإبراهيمية الكاملة',
        ),
        DhikrItem(
          id: 'sl4',
          arabic: 'اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ عَلَى نَبِيِّنَا مُحَمَّدٍ',
          translation: 'O Allah, send prayers, peace, and blessings upon our Prophet Muhammad.',
          defaultCount: 100,
          virtue: 'الصلاة الشاملة',
        ),
        DhikrItem(
          id: 'sl5',
          arabic: 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ، وَبَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ، كَمَا صَلَّيْتَ وَبَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ، إِنَّكَ حَمِيدٌ مَجِيدٌ',
          translation: 'O Allah, send prayers upon Muhammad and upon the family of Muhammad, and bestow blessings upon Muhammad and upon the family of Muhammad, as You sent prayers and blessings upon Ibrahim and the family of Ibrahim.',
          defaultCount: 10,
          virtue: 'الصلاة الإبراهيمية الكاملة مع البركة',
        ),
        DhikrItem(
          id: 'sl6',
          arabic: 'صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ',
          translation: 'May Allah send prayers and peace upon him.',
          defaultCount: 1000,
          virtue: 'من صلى عليّ في يوم ألف مرة لم يمت حتى يُبشَّر بالجنة',
        ),
        DhikrItem(
          id: 'sl7',
          arabic: 'اللَّهُمَّ رَبَّ هَذِهِ الدَّعْوَةِ التَّامَّةِ وَالصَّلَاةِ الْقَائِمَةِ، آتِ مُحَمَّداً الْوَسِيلَةَ وَالْفَضِيلَةَ، وَابْعَثْهُ مَقَاماً مَحْمُوداً الَّذِي وَعَدْتَهُ',
          translation: 'O Allah, Lord of this perfect call and the prayer to be offered, grant Muhammad the privilege and also the eminence, and resurrect him to the praised position that You have promised him.',
          defaultCount: 1,
          virtue: 'حلت له شفاعتي يوم القيامة',
        ),
      ],
    ),
  ];

  static DhikrCategory? getCategoryById(String id) {
    try {
      return categories.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<DhikrItem> getAllItems() {
    return categories.expand((c) => c.items).toList();
  }

  /// Returns all items for categories that auto-select all when category is picked
  static List<DhikrItem> getAutoSelectedItems(String categoryId) {
    final cat = getCategoryById(categoryId);
    return cat?.items ?? [];
  }
}
