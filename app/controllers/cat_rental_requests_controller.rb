class CatRentalRequestsController < ApplicationController
  before_action :require_login
  before_action :cannot_rent_own_cat, only: :create
  before_action :require_approval_by_owner, only: [:approve, :deny]

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def create
    @rental_request = current_user.cat_rental_requests.new(cat_rental_request_params)
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end

  private
  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :end_date, :start_date, :status)
  end

  def cannot_rent_own_cat
    # fail
    if Cat.find(params[:cat_rental_request][:cat_id]).user_id == current_user.id
      flash.now[:errors] = ["You cannot rent your own cat!"]
      @rental_request = CatRentalRequest.new(cat_rental_request_params)
      render :new
      # redirect_to new_cat_rental_request_url
    end
  end

  def require_approval_by_owner
    unless CatRentalRequest.find(params[:id]).cat.user == current_user
      flash[:errors] = ["You can only approve or deny requests on your own cat!"]
      redirect_to cat_url(params[:id])
    end
  end
end
