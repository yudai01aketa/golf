FactoryBot.define do
  factory :course do
    name { "大神戸ゴルフ倶楽部" }
    tips { "グリーンが狭いので、アプローチが大切なコースです" }
    score { 100 }
    recommend { 5 }
    association :user
    created_at { Time.current }
  end

  trait :yesterday do
    created_at { 1.day.ago }
  end

  trait :one_week_ago do
    created_at { 1.week.ago }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end

  trait :picture do
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_course.jpg')) }
  end
end
