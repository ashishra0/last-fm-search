class SearchHistory::StoreService
   def execute(current_user, search_query)
     search_history = current_user.search_histories.build(keyword: search_query)
     if search_history.save
       Rails.logger.info("successfully saved search query #{search_query} for user id #{current_user.id}")
     else
       Rails.logger.info("could not save search query #{search_query} for user id #{current_user.id} because #{search_history.errors.full_messages.join('. ')}")
     end
   end
end