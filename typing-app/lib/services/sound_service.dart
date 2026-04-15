class SoundService {
  static final SoundService _instance = SoundService._internal();

  factory SoundService() {
    return _instance;
  }

  SoundService._internal();

  // 効果音の再生（実装予定）
  Future<void> playCorrectSound() async {
    // 正解音
  }

  Future<void> playIncorrectSound() async {
    // ハズレ音
  }

  Future<void> playComboSound() async {
    // コンボ達成音
  }

  Future<void> playGameOverSound() async {
    // ゲームオーバー音
  }

  // 背景音楽
  Future<void> playBackgroundMusic() async {
    // BGM 再生
  }

  Future<void> stopBackgroundMusic() async {
    // BGM 停止
  }
}
