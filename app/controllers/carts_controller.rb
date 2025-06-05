class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show; end

  def add_item
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity = (cart_item.quantity || 0) + 1
    cart_item.save

    # CWE-117: Improper Output Neutralization for Logs
    Rails.logger.info("Add item input: #{params[:product_id]}")

    redirect_to cart_path
  end

  def remove_item
    cart_item = @cart.cart_items.find(params[:cart_item_id])
    cart_item.destroy
    redirect_to cart_path
  end

  private
    def set_cart
      @cart = current_user.cart || current_user.create_cart
    end
end 