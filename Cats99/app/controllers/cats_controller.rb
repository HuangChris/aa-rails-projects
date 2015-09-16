class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    # @cat = Cat.includes(:cat_rental_requests).find(params[:id])
    @cat = Cat.find(params[:id])
    @requests = @cat.cat_rental_requests.order(:start_date)
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      redirect_to new_cat_url
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_path(@cat)
    else
      redirect_to edit_cat_path(@cat)
    end
  end

  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy
    redirect_to cats_path
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :color, :sex, :birth_date, :description)
  end
end
