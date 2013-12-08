class MessagesController < ApplicationController
  
  before_filter :set_user
  
  def index
    if params[:mailbox] == "sent"
      @messages = @user.sent_messages
    else
      @messages = @user.received_messages
      p @messages
    end
  end
  
  def show
    @message = Message.read_message(params[:id], current_user)
  end
  
  def new
    @user = User.find(params[:to]) if params[:to]
    @message = Message.new
    @message.to = @user

    if params[:reply_to]
      @reply_to = @user.received_messages.find(params[:reply_to])
      unless @reply_to.nil?
        @message.to = @reply_to.sender.login
        @message.subject = "Re: #{@reply_to.subject}"
        @message.body = "\n\n*Original message*\n\n #{@reply_to.body}"
      end
    end

    if request.xhr? then
      render layout: nil
      return
    end
  end
  
  def create
    @message = Message.new(params[:message])
    @message.sender = @user
    @message.recipient = User.find_by_email(params[:message][:to])

    if @message.save
      flash[:notice] = "Message sent"
      
      if request.xhr? then
        render :js => "$(\"#myModal\").modal('hide');"
      else
        redirect_to user_messages_path(@user)
      end  
    else
      render :action => :new
    end
  end
  
  def delete_selected
    if request.post?
      if params[:delete]
        params[:delete].each { |id|
          @message = Message.find(:first, :conditions => ["messages.id = ? AND (sender_id = ? OR recipient_id = ?)", id, @user, @user])
          @message.mark_deleted(@user) unless @message.nil?
        }
        flash[:notice] = "Messages deleted"
      end
      redirect_to :back
    end
  end
  
  private
    def set_user
      @user = User.find(params[:user_id])
      p "-" * 20
      p @user
    end
end