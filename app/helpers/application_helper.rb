module ApplicationHelper
  def mail_count
    current_user.unread_message_count
  end
end
