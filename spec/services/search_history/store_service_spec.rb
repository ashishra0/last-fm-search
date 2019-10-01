require 'rails_helper'

RSpec.describe SearchHistory::StoreService do
  describe '#execute' do
    let(:user) {User.create!(username: 'ashish', password: 'password')}
    let(:user1) {User.create!(username: 'ashishrao', password: 'password')}
    it 'should save search keyword' do
      SearchHistory::StoreService.new.execute(user, 'dire straits')
      SearchHistory::StoreService.new.execute(user1, 'Bryan Adams')
      expect(user.search_histories.count).to eq(1)
      expect(user.search_histories.count).to eq(1)
    end

    it 'should not save duplicate search keyword' do
      SearchHistory::StoreService.new.execute(user, 'Bryan Adams')
      SearchHistory::StoreService.new.execute(user, 'Bryan Adams')
      expect(user.search_histories.count).to eq(1)
    end
  end
end