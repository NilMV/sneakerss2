class FeedsController < ApplicationController 
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  

  def index
    feeds =  $redis.get("feeds")
    if feeds.nil?
      feeds = Feed.all.to_json
      $redis.set("feeds", feeds)
      $redis.expire("feeds",3.hour.to_i)
    end
    @feeds = JSON.load feeds
  end
   
  def show
    @feed
  end

  def new 
    @feed = Feed.new
  end

  def edit 
    @feed
  end
  
  def create
    @feed = Feed.create(feed_params)
    redirect_to feeds_path
  end

  def update
    @feed.update(feed_params)
    @feed
  end

  def destroy 
    @feed.destroy
    redirect_to feeds_path
  end

  private


  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params[:feed].permit(:name, :url, :description)
  end
end

