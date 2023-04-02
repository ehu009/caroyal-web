class InquiriesController < ApplicationController
  def index
    @todo = Inquiry.where status: "todo"
    @done = Inquiry.where status: "done"
  end

  def show
    @inq = Inquiry.find params[:id]
  end

  def new
    @inq = Inquiry.new
  end

  def create
    message = "Your inquiry has been saved."
    redir = contact_path

    @inq = Inquiry.new create_params
    @inq.status = "todo"
    unless @inq.save then
      message = @inq.errors.messages
    end

    redirect_to contact_path, notice: message
  end

  def edit
    @inq = Inquiry.find params[:id]
  end

  def update
    message = "Inquiry has been updated."
    redir = edit_inquiries_path

    @inq = Inquiry.find params[:id]
    if @inq.update update_params then
      redir = inquiries_path
    else
      message = @inq.errors.messages
    end

    redirect_to redir, notice: message
  end

  def destroy
    message = "Inquiry has been destroyed."
    redir = edit_inquiries_path

    @inq = Inquiry.find params[:id]
    if @inq.destroy then
      redir = inquiries_path
    else
      message = @inq.errors.messages
    end

    redirect_to redir, notice: message
  end

  private
  def create_params
    params.require(:inquiry).permit(:role, :email, :body)
  end

  def update_params
    params.require(:inquiry).permit(:role, :email, :body, :status)
  end
  
end
