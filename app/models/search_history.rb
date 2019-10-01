class SearchHistory < ApplicationRecord
  belongs_to :user
  validates :keyword, presence: true, uniqueness: { scope: :user_id, case_sensitive: true }
end
