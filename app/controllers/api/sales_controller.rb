module Api
  class SalesController < ::ApplicationController

    def index
      render :json => {
          sales: ::ScoringService.new.scored_sales
      }
    end

  end
end