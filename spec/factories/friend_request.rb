FactoryBot.define do
  factory :friendship do
    friend_id { User.last.id }
    user_id { User.first.id }
    confirmed { true }
  end
end