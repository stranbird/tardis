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
    o.created_at.to_formatted_s(:shorts).gsub("UTC ", "")
  end

  def i_like(u, o)
    unless u.liked? o then 
       link_to like_review_path(o) do fa_icon "thumbs-o-up" end
    else 
       link_to unlike_review_path(o) do fa_icon "thumbs-o-up", class: "liked" end
    end 
  rescue
    ""
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

  def title_or_name(o)
    u = ""
    if o.class == User
      u = o.name
    elsif o.class == Review
      u = o.title
    end

    u || "?"
  end

  def safe_place_name(name)
    name || "无人之境"
  end

  def link_to_place(place)
    if place
      link_to_trackable place, safe_place_name(place.try(:name))
    else
      safe_place_name(place.try(:name))
    end
  end

  def a_headline(a)
    user = User.find(a.owner_id)
    if a.key == "comment.create"
      comment = a.trackable
      raw "#{link_to user.name || user.email}评论了「#{link_to_trackable comment.commentable, title_or_name(comment.commentable)}」"
    elsif a.key == "review.like"
      review = a.trackable
      place = review.place
      raw "#{link_to user.name || user.email} 喜欢了「#{link_to_place review.place}」的游记「#{link_to review.title, review}」"
    elsif a.key == "place.visited"
      place = a.trackable
      raw "#{link_to user.name || user.email}去过「#{link_to_trackable place, place.name}」"
    elsif a.key == "review.create"
      review = a.trackable
      place = review.place
      raw "#{link_to user.name || user.email}发表了「#{link_to_place review.place}」的游记「#{link_to review.title, review}」"
    end
  end

  def short_date(dt)
    dt = Time.now if dt.nil?
    dt.strftime("%Y,%m,%-d")
  end

  def activity_to_json(a)
    h = {
        startDate: short_date(a.created_at),
        headline: a_headline(a),
        text: "",
        asset:
        {
            media: "",
            credit: "",
            caption: ""
        }
    }
  end

  def activities_to_json(activities)
    skelton_h = {
      timeline: 
      {
        headline: "时间线",
        type: "default",
        text: "",
        startDate: short_date(activities.first.created_at),
        date: [ ]
      }
    }

    activities.each do |a|
      skelton_h[:timeline][:date] << activity_to_json(a)
    end

    skelton_h.to_json
  end

  def suggestion_reason(str)
    if str == "primary"
      "附近的人"
    elsif str ==  "success"
      "共同喜好多"
    elsif str ==  "info"
      "热门用户"
    elsif str ==  "warning"
      "喜欢"
    elsif str == "danger"
      "共同好友多"
    end

  end
end
