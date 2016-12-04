class Admin::Users::StoresController < Admin::BaseController
  def index
    @user = User.find(params[:user_id])

    @page_size = Kuli::Application::PAGE_SIZE
    @current_page = params[:page].present? ? params[:page].to_i : 0
    @stores = Store.where(user: @user).offset(@current_page * @page_size).limit(@page_size)    
  end
end
