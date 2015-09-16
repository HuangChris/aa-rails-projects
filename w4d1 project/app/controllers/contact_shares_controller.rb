class ContactSharesController < ApplicationController
  def create
    shares = ContactShare.new(shares_params)
    if shares.save
      render json: shares
    else
      render(
        json: shares.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    shares = ContactShare.find(params[:id])
    if shares.destroy
      render json: shares
    else
      render(
        json: shares.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  private

  def shares_params
    params.require(:contact_share).permit(:contact_id, :user_id)
  end
end
