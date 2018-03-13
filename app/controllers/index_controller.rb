class IndexController < ApplicationController

  def index
    render :file => 'layouts/application', :layout => false
  end

end