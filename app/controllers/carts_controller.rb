class CartsController < ApplicationController
  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
    current_user.current_cart.cart_checkout
    current_user.current_cart = nil
    current_user.save
    redirect_to cart_path(Cart.find(params[:id]))
  end

end
