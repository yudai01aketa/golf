FactoryBot.define do
  factory :course do
    name { Faker::Food.dish }
    # {RakutenWebService::Gora::Course.golfCourseName}
    description { "四季折々の風景が楽しめるコースです、六甲の絶景をお楽しみ下さい" }
    # {RakutenWebService::Gora::Course.golfCourseCaption}
    tips { "グリーンが狭いので、アプローチが大切なコースです" }
    reference { "https://cookpad.com/recipe/2798655" }
    # {RakutenWebService::Gora::Course.reserveCalUrl}
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
end
