class StoresController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_size = Kuli::Application::PAGE_SIZE
    @current_page = params[:page].present? ? params[:page].to_i : 0
    @stores = Store.where(user: current_user).offset(@current_page * @page_size).limit(@page_size)
  end

  def show
    @store = Store.where(id: params[:id], user: current_user)
  end

  def new
  end

  def edit
  end

  def create
    store = Store.new(name: params[:name], owner_name: params[:owner_name], owner_telephone: params[:owner_telephone], license_picture: params[:license_picture], user: current_user)
    store.save!

    redirect_to store_path(store.id)
  end

  def destroy
    Store.where(id: params[:id], user: current_user).first.destroy!
    redirect_to action: 'index'
  end
end
