class PipedriveService
  include Singleton

  CREATED_DEALS_FILTER = 48
  WON_DEALS_FILTER = 52
  DECISION_DEALS_FILTER = 49
  ACTIVITIES_THIS_MONTH_FILTER = 47
  CONTACTS_THIS_MONTH_FILTER = 51

  def total_won(date)
    data = Pipedrive::Deal::get("#{Pipedrive::Deal::resource_path}/timeline", :query => {
        start_date: date,
        interval: 'month',
        amount: 1,
        field_key: 'expected_close_date',
        totals_convert_currency: 'USD'
    })
    data['data'].kind_of?(Array) ? data['data'][0]['totals_converted']['won_value'] : 0
  end

  def created_deals
    deals_filter(CREATED_DEALS_FILTER)
  end

  def won_deals
    deals_filter(WON_DEALS_FILTER)
  end

  def decision_deals
    deals_filter(DECISION_DEALS_FILTER)
  end

  def deals_filter(filter_id)
    fetch_data Pipedrive::Deal::get("#{Pipedrive::Deal::resource_path}", :query => {
        filter_id: filter_id
    })
  end

  def contacts
    fetch_data Pipedrive::Person::get("#{Pipedrive::Person::resource_path}", :query => {
        filter_id: CONTACTS_THIS_MONTH_FILTER
    })
  end

  def activities
    fetch_data Pipedrive::Activity::get("#{Pipedrive::Activity::resource_path}", :query => {
        filter_id: ACTIVITIES_THIS_MONTH_FILTER,
        user_id: 0,
        done: 1
    })
  end

  protected

  def fetch_data(result)
    result['data'].kind_of?(Array) ? result['data'] : []
  end

  def initialize
    Pipedrive.authenticate( SCOREBOARD_CONFIG['api_key'] )
  end

end