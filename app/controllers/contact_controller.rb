class ContactController < ApplicationController
  def form
  end
  
  def create
    @contact = Contact.new(name: params[:name], email: params[:email], content: params[:content])
    if @contact.save
      flash[:notice] = "お問い合わせが完了しました"
      redirect_to("/")
    else
      @error_message = "すべての項目に入力してください"
      render("contact/form")
    end
  end
end
