class ContactsController < ApplicationController
  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    if contact.destroy
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def index
    user = User.find(params[:user_id])
    p user.contacts
    p user.shared_contacts
    render json: [user.contacts, "space for clarity", user.shared_contacts]
  end

  def show
    render json: Contact.find(params[:id])
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
