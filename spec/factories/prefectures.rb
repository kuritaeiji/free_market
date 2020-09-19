FactoryBot.define do
  factory :prefecture do
    id { 1 }
    name { '北海道' }

    initialize_with do
      Prefecture.find_or_initialize_by(id: 1, name: '北海道')
    end
  end
end
