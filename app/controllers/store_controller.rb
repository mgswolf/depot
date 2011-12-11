class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else
      increment_count
      @counter = session[:counter]
      @products = Product.where(:locale => I18n.locale)
      @cart = current_cart
    end
  end

  private

    def increment_count
      if session[:counter].nil?
        session[:counter] = 1
      else
        session[:counter] += 1
      end
    end
end
