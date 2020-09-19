require 'rails_helper'

RSpec.describe User, type: :model do
  describe('association') do
    it { is_expected.to(belong_to(:prefecture)) }
  end

  describe('email validation') do
    it { is_expected.to(validate_presence_of(:email)) }

    it('format') do
      user = build(:user, email: 'fff.com')
      user.valid?
      expect(user.errors[:email]).to eq(['は不正な値です'])
    end

    it('uniqueness') do
      user = create(:user, email: 'f@f.com')
      user2 = build(:user, email: 'f@f.com')
      user2.valid?
      expect(user2.errors[:email]).to eq(['はすでに存在します'])
    end
  end

  describe('password validation') do
    it { is_expected.to(validate_presence_of(:password)) }
    it { is_expected.to(validate_length_of(:password).is_at_least(8)) }
    it { is_expected.to(validate_length_of(:password).is_at_most(20)) }
    it { is_expected.to(validate_confirmation_of(:password)) }
  end

  describe('nickname validation') do
    it { is_expected.to(validate_presence_of(:nickname)) }
    it { is_expected.to(validate_length_of(:nickname).is_at_most(10)) }
  end

  describe('family_name validation') do
    it { is_expected.to(validate_presence_of(:family_name)) }
    it { is_expected.to(validate_length_of(:family_name).is_at_most(10)) }
  end

  describe('first_name validation') do
    it { is_expected.to(validate_presence_of(:first_name)) }
    it { is_expected.to(validate_length_of(:first_name).is_at_most(10)) }
  end

  describe('postal_code validation') do
    it { is_expected.to(validate_presence_of(:postal_code)) }
    
    it('format') do
      user = build(:user, postal_code: '111-1111')
      user.valid?
      expect(user.errors[:postal_code]).to eq(['は不正な値です'])
    end
  end
  
  describe('address validation') do
    it { is_expected.to(validate_presence_of(:address)) }
    it { is_expected.to(validate_length_of(:address).is_at_most(50)) }
  end

  describe('image validation') do
    it('extension') do
      user = build(:user)
      user.image.attach(io: File.open(Rails.root.join('spec', 'images', 'sample.txt').to_s), 
        filename: 'sample.txt', content_type: 'text/plain')
      user.valid?
      expect(user.errors[:image]).to eq(['を添付してください'])
    end
  end
end
