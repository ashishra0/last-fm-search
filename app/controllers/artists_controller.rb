class ArtistsController < ApplicationController
  before_action :require_user

  def index
    if search_params
      @artist_service_response = LastFm::ArtistsService.new.execute(search_params[:query], search_params[:method]).result
      if @artist_service_response
        @artist_service_response = @artist_service_response.dig('artist')
        SearchHistoryStoreJob.perform_later(current_user.id, search_params[:query])
      else
        flash[:danger] = 'Cannot search at the moment. Please try after some time'
      end
    end
  end

  private

  def search_params
    return params.require(:search).permit(:query, :method) if params[:search]
    nil
  end
end