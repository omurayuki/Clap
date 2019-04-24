
//エラーの時にindicatorが出っ放し
//realmどこかで削除しなきゃいけないんじゃ無いか
//rx周りがめちゃくちゃ
//同じ関数, 同じUI処理を書いてる pickerとか
//callback 地獄
//mypage編集画面で編集したbelongデータをusers個々人のdbで変更していた。そうじゃなくてteamの中のbelongを変更して、かつteamから毎回取得してこなければいけない。全体で共有するデータだから
//編集の際に、realmにあるuserデータも更新


////今日の目標
//https://fukatsu.tech/realm-reset
//https://qiita.com/y-some/items/27a8e27c1e3901540831



//わかってないこと
//singleton static





//realm使う場面
//calendar private(realm) public
//timeline



//diaryのデータをどこかに持っておく必要がある　ローカルで瞬時に読み込むため しかし、データが更新された時のローカルへの反映をどうするか サブスレッドで通信処理ますと？　それをviewwillappearで都度やるか、twitterみたいに上にスクロールした時にやるか
//表示するためのdiaryのデータを別クラスかstructに保存するか、ローカルのDBに保持しておく必要がある　そしてcollectionViewのdateHeaderとcellに渡す必要がある
//明日はデータ構造を整理するために紙に書く、そしてベストプラクティスを考える
//timelineVCで色々処理(dateを~~)しているが、それも見直し

//ui.logintBtn.rx.tap
//    .bind(onNext: { [weak self] _ in
//        guard let this = self else { return }
//        this.showIndicator()
//        this.ui.logintBtn.bounce(completion: {
//            this.viewModel?.login(mail: this.ui.mailField.text ?? "", pass: this.ui.passField.text ?? "", completion: { (uid, error) in
//                if let _ = error {
//                    self?.hideIndicator()
//                    AlertController.showAlertMessage(alertType: .loginFailed, viewController: this)
//                }
//                self?.viewModel?.saveToSingleton(uid: uid ?? "", completion: {
//                    self?.hideIndicator(completion: {
//                        print("Why move!!")
//                        this.routing.showTabBar(uid: UserSingleton.sharedInstance.uid)
//                    })
//                })
//            })
//        })
//    }).disposed(by: viewModel.disposeBag)
