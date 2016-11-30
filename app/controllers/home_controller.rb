class HomeController < ApplicationController
  def index
  end

  def wx_oauth
    logger.debug params[:code]
    logger.debug params[:state]
  end
end
