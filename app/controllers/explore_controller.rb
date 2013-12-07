# encoding: utf-8

class ExploreController < ApplicationController
  def index
    @places = Place.all
    @hash = Gmaps4rails.build_markers(@places) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.json({:id => user.id })
      marker.picture({
      "url" => "http://img3.douban.com/pics/travel/place-single.png",
      "width" =>  32,
      "height" => 32})
      marker.infowindow render_to_string(:partial => "/users/my_template", :locals => { :object => user})
    end
  end
end
