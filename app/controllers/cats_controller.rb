class CatsController < ApplicationController
  before_action :require_login, except: :index
  before_action :require_owned_cat, only: [:update, :edit]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = current_user.cats.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    # params[:cat][:user_id] ||= current_user.id
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex)
  end

  def require_owned_cat
    @cat = Cat.find(params[:id])
    unless @cat.user_id == current_user.id
      flash[:errors] = ["Cannot edit someone else's cat"]
      redirect_to cats_url
    end
  end


end
