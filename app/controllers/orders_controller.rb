class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def new; end

  def create
    @order = current_user.orders.build(order_params)
    @order.total = @cart.cart_items.sum { |item| item.product.price * item.quantity }

    if @order.save
      @cart.cart_items.destroy_all
      # CWE-117: Improper Output Neutralization for Logs
      Rails.logger.info("Checkout input: #{params[:address]}")
      # CWE-601: Open Redirect
      redirect_to params[:return_to] || root_path
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private
    def set_cart
      @cart = current_user.cart
    end

    def order_params
      params.require(:order).permit(:address)
    end
end 