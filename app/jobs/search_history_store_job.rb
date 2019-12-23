class SearchHistoryStoreJob < ApplicationJob
  queue_as :default

  def perform(user_id, query)
    user = User.find_by_id(user_id)
    SearchHistory::StoreService.new.execute(user, query) if user
  end
end
