require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe "ActiveModel validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_length_of(:username).is_at_least(5).is_at_most(15) }
    it 'should not contain special characters' do
      user = User.create(username: '@shish32',password: 'P@ssw0rd')
      expect(user.errors.messages[:username]).to eq ['is invalid']
    end
  end
end

