module Api
  class PlanController < ::ApplicationController

    def index
      date = Date.today.strftime("%Y-%m-01")
      render :json => {
          date: date,
          won_total_plan: ::SCOREBOARD_CONFIG['plans']['won_total'],
          new_deals_plan: ::SCOREBOARD_CONFIG['plans']['new_deals'],
          won_deals_plan: ::SCOREBOARD_CONFIG['plans']['won_deals'],
          won_total_fact: ::PipedriveService.instance.total_won(date)
      }
    end

  end
end