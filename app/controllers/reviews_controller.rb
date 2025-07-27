class ReviewsController < ApplicationController
  before_action :set_review, only: [:destroy]

  # CWE-80: XSS Vulnerability
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      # Intentionally vulnerable to XSS - no sanitization
      flash[:notice] = "Review added: #{@review.content}"
      redirect_to @product
    else
      flash[:alert] = "Error adding review"
      redirect_to @product
    end
  end

  def destroy
    @review.destroy
    redirect_to @review.product, notice: 'Review was successfully deleted.'
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      # Intentionally vulnerable - allowing HTML content
      params.require(:review).permit(:content, :rating)
    end
end 