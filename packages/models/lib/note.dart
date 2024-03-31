enum FlowRate { spotting, light, normal, heavy }

class NoteModel {
  String uid;

  // note
  DateTime date;
  String note;
  bool periodStart;
  bool intimacy;
  FlowRate? flow;

  // symptom
  bool? cramps;
  bool? acne;
  bool? tenderBreasts;
  bool? headache;
  bool? constipation;
  bool? diarrhea;
  bool? fatigue;
  bool? nausea;
  bool? cravings;
  bool? bloating;
  bool? backache;
  bool? perineumPain;

  // mood
  bool? calm;
  bool? happy;
  bool? energetic;
  bool? frisky;
  bool? irritated;
  bool? angry;
  bool? sad;
  bool? anxious;
  bool? apathetic;
  bool? confused;
  bool? guilty;
  bool? overwhelmed;

  NoteModel(
      {required this.uid,
      required this.date,
      required this.note,
      required this.periodStart,
      required this.intimacy,
      this.flow,
      this.cramps,
      this.acne,
      this.tenderBreasts,
      this.headache,
      this.constipation,
      this.diarrhea,
      this.fatigue,
      this.nausea,
      this.cravings,
      this.bloating,
      this.backache,
      this.perineumPain,
      this.calm,
      this.happy,
      this.energetic,
      this.frisky,
      this.irritated,
      this.angry,
      this.sad,
      this.anxious,
      this.apathetic,
      this.confused,
      this.guilty,
      this.overwhelmed});

  factory NoteModel.fromMap(Map data) {
    data = data;

    return NoteModel(
        uid: data['uid'],
        date: data['date'].toDate(),
        note: data['note'],
        periodStart: data['periodStart'],
        intimacy: data['intimacy'],
        flow: data['flow'] == "0"
            ? FlowRate.spotting
            : data['flow'] == "1"
                ? FlowRate.light
                : data['flow'] == "2"
                    ? FlowRate.normal
                    : data['flow'] == "3"
                        ? FlowRate.heavy
                        : null,
        cramps: data['cramps'],
        acne: data['acne'],
        tenderBreasts: data['tenderBreasts'],
        headache: data['headache'],
        constipation: data['constipation'],
        diarrhea: data['diarrhea'],
        fatigue: data['fatigue'],
        nausea: data['nausea'],
        cravings: data['cravings'],
        bloating: data['bloating'],
        backache: data['backache'],
        perineumPain: data['perineumPain'],
        calm: data['calm'],
        happy: data['happy'],
        energetic: data['energetic'],
        frisky: data['frisky'],
        irritated: data['irritated'],
        angry: data['angry'],
        sad: data['sad'],
        anxious: data['anxious'],
        apathetic: data['apathetic'],
        confused: data['confused'],
        guilty: data['guilty'],
        overwhelmed: data['overwhelmed']
    );
  }

  static Map<String, dynamic> toMap(NoteModel data) {
    data = data;
    return {
      'uid': data.uid,
      'date': data.date,
      'note': data.note,
      'periodStart': data.periodStart,
      'intimacy': data.intimacy,
      'flow': data.flow?.index.toString(),
      'cramps': data.cramps,
      'acne': data.acne,
      'tenderBreasts': data.tenderBreasts,
      'headache': data.headache,
      'constipation': data.constipation,
      'diarrhea': data.diarrhea,
      'fatigue': data.fatigue,
      'nausea': data.nausea,
      'cravings': data.cravings,
      'bloating': data.bloating,
      'backache': data.backache,
      'perineumPain': data.perineumPain,
      'calm': data.calm,
      'happy': data.happy,
      'energetic': data.energetic,
      'frisky': data.frisky,
      'irritated': data.irritated,
      'angry': data.angry,
      'sad': data.sad,
      'anxious': data.anxious,
      'apathetic': data.apathetic,
      'confused': data.confused,
      'guilty': data.guilty,
      'overwhelmed': data.overwhelmed
    };
  }
}
