class NoticeController< ApplicationController
  layout 'devise'

  def registNotice
    @email = params[:email]
  end

  def resetNotice
    @email = params[:email]
  end
end