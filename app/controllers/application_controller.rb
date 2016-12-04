class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  def authenticate_user!
    super
    if current_user and not current_user.info_filled
      if controller_name != 'users' or (action_name != 'fill_info_view' and action_name != 'fill_info')
        redirect_to users_fill_info_path
      end
    end
  end
end
