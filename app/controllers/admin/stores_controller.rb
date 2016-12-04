class Admin::StoresController < Admin::BaseController
  def index
    @page_size = Kuli::Application::PAGE_SIZE
    @current_page = params[:page].present? ? params[:page].to_i : 0
    @stores_count = Store.count
    @stores = Store.offset(@current_page * @page_size).limit(@page_size)
  end

  def show
    @store = Store.find(params[:id])
  end

  def destroy
    Store.find(params[:id]).destroy!
    redirect_to action: 'index'    
  end
end
