User.create!(name:  "ゲストユーザー",
            email: "sample@example.com",
            password:              "foobar",
            password_confirmation: "foobar",
            admin: true)

20.times do |n|
 name  = Faker::Name.name
 email = "sample-#{n+1}@example.com"
 password = "password"
 User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password)
end

Course.create!(name: "アジア取手カントリー倶楽部",
             tips: "バンカーが多い感じがしました",
             score: 100,
             recommend: 5,
             memo: "ドライバーが調子良かった",
             user_id: 1,
             picture: open("./public/images/golf_01.jpg"))
course = Course.first
Log.create!(course_id: course.id,
content: course.memo)

Course.create!(name: "大神戸ゴルフ倶楽部",
             tips: "グリーンのスピードがかなり早いのでご注意を",
             score: 100,
             recommend: 5,
             memo: "パターの調子が良かった",
             user_id: 1,
             picture: open("./public/images/golf_02.jpeg"))
course = Course.first
Log.create!(course_id: course.id,
content: course.memo)

Course.create!(name: "かずさカントリークラブ",
             tips: "OBが多く、ウォーターハザードも多かったので中級者以上のコースだと思います",
             score: 100,
             recommend: 5,
             memo: "アプローチの練習をしなければ、、、",
             user_id: 1,
             picture: open("./public/images/golf_03.jpg"))
course = Course.first
Log.create!(course_id: course.id,
content: course.memo)

Course.create!(name: "石岡ゴルフ倶楽部",
             tips: "プロも回るコースで楽しく回れます",
             score: 100,
             recommend: 5,
             memo: "楽しく回れてまた行きたいと思います",
             user_id: 1,
             picture: open("./public/images/golf_04.jpeg"))
course = Course.first
Log.create!(course_id: course.id,
content: course.memo)

Course.create!(name: "千葉新日本ゴルフ倶楽部",
             tips: "景色がかなりいいが、風が強め",
             score: 100,
             recommend: 4,
             memo: "楽しくラウンドできました",
             user_id: 1,
             picture: open("./public/images/golf_05.jpeg"))
course = Course.first
Log.create!(course_id: course.id,
content: course.memo)

Course.create!(name: "本千葉カントリークラブ",
             tips: "千葉の僻地にありますがオススメのコースです",
             score: 100,
             recommend: 5,
             memo: "バンカーにはまった回数が多かった。",
             user_id: 1,
             picture: open("./public/images/golf_06.jpeg"))
course = Course.first
Log.create!(course_id: course.id,
content: course.memo)

Course.create!(name: "セブンハンドレッドクラブ",
             tips: "芝が整っており気持ちよくプレーできました",
             score: 100,
             recommend: 3,
             memo: "ベストスコア出た79",
             user_id: 1,
             picture: File.open("./public/images/golf07.jpg"))
course = Course.first
Log.create!(course_id: course.id,
content: course.memo)

Course.create!(name: "成田ゴルフ倶楽部",
             tips: "いいコースだと思います",
             score: 100,
             recommend: 5,
             memo: "",
             user_id: 1,
             picture: File.open("#{Rails.root}/public/images/golf08.jpg"))
course = Course.first
Log.create!(course_id: course.id,
content: course.memo)

Course.create!(name: "神有カントリー倶楽部",
             tips: "六甲の景色を見ながら優雅に回れます。山奥にあるので平地より少し寒いです",
             score: 110,
             recommend: 5,
             memo: "雨でスコアが伸び悩んだ",
             user_id: 1,
             picture: File.open("#{Rails.root}/public/images/golf09.jpg"))
course = Course.first
Log.create!(course_id: course.id,
content: course.memo)

# フォロー、フォロワー
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
