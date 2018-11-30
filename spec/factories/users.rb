FactoryBot.define do
  factory :user, class: User do
    name {'test'}
    email {'test@gmail.com'}
    password {'aaaaaa'}
    password_confirmation {'aaaaaa'}
  end
end
