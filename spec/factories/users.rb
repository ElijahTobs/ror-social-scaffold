FactoryBot.define do
  factory :user do
    name { 'User' }
    email { 'User@test.com' }
    password { 'microverse' }
    password_confirmation { 'microverse' }
  end
end