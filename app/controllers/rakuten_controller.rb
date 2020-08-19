class RakutenController < ApplicationController

  def index
  end

  def search
    @courses = RakutenWebService::Gora::Course.search(keyword: params[:keyword], hits: 15)
  end
end
