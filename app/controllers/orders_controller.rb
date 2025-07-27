class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def new
    @order = current_user.orders.build
  end

  # CWE-601: Open Redirect
  # CWE-117: Improper Output Neutralization for Logs
  def create
    @order = current_user.orders.build(order_params)
    @order.total = @cart.cart_items.sum { |item| item.product.price * item.quantity }

    if @order.save
      # CWE-117: Logging user input without sanitization
      Rails.logger.info "New order created with address: #{params[:order][:address]}"
      
      # CWE-601: Open redirect - no validation of return_to URL
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
    @cart = current_user.cart || current_user.create_cart
  end

  def order_params
    params.require(:order).permit(:address)
  end
end 