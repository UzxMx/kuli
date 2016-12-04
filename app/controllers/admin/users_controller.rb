class Admin::UsersController < Admin::BaseController
  def index
    @page_size = Kuli::Application::PAGE_SIZE
    @current_page = params[:page].present? ? params[:page].to_i : 0
    @users_count = User.count
    @users = User.offset(@current_page * @page_size).limit(@page_size)
  end

  def show
    @user = User.find(params[:id])
  end
end
