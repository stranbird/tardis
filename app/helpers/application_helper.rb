module ApplicationHelper
  def mail_count
    current_user.unread_message_count
  end

  def link_to_trackable(object, object_type)
    if object
      link_to object_type.downcase, object
    else
      "a #{object_type.downcase} which does not exist anymore"
    end
  end
end
