require 'rails_helper'

RSpec.describe SearchHistory, type: :model do
  it { should belong_to(:user)}
  it { should validate_presence_of(:keyword)}
  it { should validate_uniqueness_of(:keyword).scoped_to(:user_id) }
end
