# encoding: utf-8

class ExploreController < ApplicationController
  def index
    # [
    #     {
    #       "lat": 0,
    #       "lng": 0,
    #       "picture": {
    #         "url": "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png",
    #         "width":  36,
    #         "height": 36
    #       },
    #       "infowindow": "hello!"
    #     }
    #   ]
    @hash = Gmaps4rails.build_markers([current_user]) do |user, marker|
      marker.lat 0
      marker.lng 0
      marker.json({:id => user.id })
      marker.picture({
      "url" => "http://img3.douban.com/pics/travel/place-single.png",
      "width" =>  32,
      "height" => 32})
      marker.infowindow render_to_string(:partial => "/users/my_template", :locals => { :object => user})
    end
  end
end
