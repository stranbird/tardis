# encoding: utf-8
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

  def printDate(o)
    o.created_at.to_formatted_s(:shorts)
  end

  def i_like(u, o)
    unless u.liked? o then 
       link_to like_review_path(o) do fa_icon "thumbs-o-up" end
    else 
       link_to unlike_review_path(o) do fa_icon "thumbs-o-up", class: "liked" end
    end 
  end

  def n_like(o)
    count = o.likes.count
    count > 0 ? count : nil
    # "被#{@like_users.map(&:email).take(3).join(",")}等#{@like_users.size}个人喜欢。"  if @like_users.size > 0   
  end

  def follow_button(u, v)
    return if u == v
    unless u.following? v 
      button_to "关注他", follow_user_path(v), :remote => true, class: "btn btn-success btn-xs" 
    else 
      button_to "已经关注", unfollow_user_path(v), :remote => true, class: "btn btn-default btn-xs" 
    end
  end
end
