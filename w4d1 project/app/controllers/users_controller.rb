class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def favorites
    user = User.find(params[:id])
    favorite_contacts = user.contacts.where(favorited: true)
    # favorite_shared = user.include(:shared_contacts).contact_shares.where(favorited: true).contact
    favorite_shared = user.shared_contacts.where("contact_shares.favorited = ?", true)
    render json: ["favorite contacts:", favorite_contacts,
      "favorite contacts shared:", favorite_shared]
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
