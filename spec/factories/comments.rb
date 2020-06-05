FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "そこのコース私も行きたいです" }
    association :course
  end
end
