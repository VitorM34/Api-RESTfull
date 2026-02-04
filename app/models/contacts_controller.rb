class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token


  def index
    @contacts = Contact.all
    render json: @contacts.map(&:to_br)
  end

  # GET /contacts/:id
  def show
    render json: @contact.to_br
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact.to_br, status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/:id
  def update
    if @contact.update(contact_params)
      render json: @contact.to_br, status: :ok
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/:id
  def destroy
    @contact.destroy
    head :no_content
  end

  private

    def set_contact
      @contact = Contact.find(params[:id])
    end

   def contact_params
    params.require(:contact).permit(:name, :email, :birthdate, :kind_id)
   end
end
