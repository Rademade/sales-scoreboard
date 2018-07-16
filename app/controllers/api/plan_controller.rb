module Api
  class PlanController < ::ApplicationController

    def index
      date = Date.today.strftime("%Y-%m-01")
      totals = ::PipedriveService.instance.totals(date)
      render :json => {
          date: date,
          won_total_plan: ::SCOREBOARD_CONFIG['plans']['won_total'],
          new_deals_plan: ::SCOREBOARD_CONFIG['plans']['new_deals'],
          won_deals_plan: ::SCOREBOARD_CONFIG['plans']['won_deals'],
          won_total_fact: totals.won_total,
          won_suggestion: totals.won_suggestion
      }
    end

  end
end