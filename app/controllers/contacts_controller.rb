class ContactsController < ApplicationController

  def new
    @company = Company.find(params[:company_id])
    @contact = Contact.new
  end

  def create
    @company = Company.find(params[:company_id])
    @contact = company.contact.create(contact_params)
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :position, :email)
  end
end
