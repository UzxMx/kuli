class UsersController < ApplicationController
  
  # GET /users/fill_info
  def fill_info_view
    @regions = Region.all
  end

  # POST /users/fill_info
  def fill_info
    current_user.name = params[:name]
    current_user.school = params[:school]
    current_user.shipping_address = params[:shipping_address]
    current_user.telephone = params[:telephone]
    current_user.id_card_picture = params[:id_card_picture]
    current_user.id_card_reverse_picture = params[:id_card_reverse_picture]
    current_user.region = Region.find(params[:region])
    current_user.info_filled = true

    current_user.save!

    redirect_to users_show_path
  end

  def show
    @not_collapsed = true
  end
end