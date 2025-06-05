class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      # CWE-80: XSS vulnerability - rendering user input as HTML without sanitization
      render json: { content: @review.content.html_safe }, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    head :no_content
  end

  private
    def review_params
      params.require(:review).permit(:content, :rating)
    end
end 