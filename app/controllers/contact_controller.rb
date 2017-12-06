class ContactController < ApplicationController

  def new
  end

  def create
  @name = params[:name]
  @message = params[:message]
end
end
