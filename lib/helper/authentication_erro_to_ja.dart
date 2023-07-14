class AuthenticationErrorToJa {
  // ログイン時の日本語エラーメッセージ
  static loginErrorMsg(int errorCode, String orgErrorMsg) {
    if (errorCode == 360587416) {
      return '有効なメールアドレスを入力してください。';
    } else if (errorCode == 505284406) {
      // 入力されたメールアドレスが登録されていない場合
      return 'メールアドレスかパスワードが間違っています。';
    } else if (errorCode == 185768934) {
      // 入力されたパスワードが間違っている場合
      return 'メールアドレスかパスワードが間違っています。';
    } else if (errorCode == 447031946) {
      // メールアドレスかパスワードがEmpty or Nullの場合
      return 'メールアドレスとパスワードを入力してください。';
    } else {
      return '$orgErrorMsg[${errorCode.toString()}]';
    }
  }

  // アカウント登録時の日本語エラーメッセージ
  static registerErrorMsg(int errorCode, String orgErrorMsg) {
    if (errorCode == 360587416) {
      return '有効なメールアドレスを入力してください。';
    } else if (errorCode == 34618382) {
      // メールアドレスかパスワードがEmpty or Nullの場合
      return '既に登録済みのメールアドレスです。';
    } else if (errorCode == 447031946) {
      // メールアドレスかパスワードがEmpty or Nullの場合
      return 'メールアドレスとパスワードを入力してください。';
    } else {
      return '$orgErrorMsg[${errorCode.toString()}]';
    }
  }

  // パスワード再設定時の日本語エラーメッセージ
  static passwordResetErrorMsg(int errorCode, String orgErrorMsg) {
    if (errorCode == 360587416) {
      return '有効なメールアドレスを入力してください。';
    } else if (errorCode == 432069392) {
      return 'メールアドレスが入力されていません';
    } else if (errorCode == 505284406) {
      return '登録されていないメールアドレスです。';
    } else {
      return '$orgErrorMsg[${errorCode.toString()}]';
    }
  }
}
