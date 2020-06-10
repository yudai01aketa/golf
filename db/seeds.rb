User.create!(name:  "山田 太郎",
            email: "sample@example.com",
            password:              "foobar",
            password_confirmation: "foobar",
            admin: true)

30.times do |n|
 name  = Faker::Name.name
 email = "sample-#{n+1}@example.com"
 password = "password"
 User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password)
end

10.times do |n|
  Course.create!(name: Faker::Food.dish,
               description: "風が強く吹きさらすコースが多いです",
               tips: "バンカーが多いです",
               reference: "https://cookpad.com/recipe/2798655",
               score: 100,
               recommend: 5,
               memo: "パターの調子が良かったですわ",
               user_id: 1)
  course = Course.first
  Log.create!(course_id: course.id,
  content: course.memo)
end

# フォロー、フォロワー
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
