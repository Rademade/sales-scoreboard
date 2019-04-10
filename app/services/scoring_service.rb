class ScoringService

  WON_AMOUNT_KEY = "9fde2e6ef68bb0101759292580b830403172b512"

  def scored_sales
    sales = sales_list

    # Won deals count and amount
    won_deals = ::PipedriveService.instance.won_deals
    update_deals_summary(sales, won_deals, :won_deals)
    update_won_amount(sales, won_deals)

    update_deals_summary(sales, ::PipedriveService.instance.created_deals, :created_deals)
    update_deals_summary(sales, ::PipedriveService.instance.decision_deals, :decision_deals)
    update_activities_summary(sales, ::PipedriveService.instance.activities, :activities_count)
    update_contacts_summary(sales, ::PipedriveService.instance.contacts, :person_count)

    sales
  end

  def update_activities_summary(sales, activities, field)
    activities.each do |activity|
      sale = sales.select {|sale| sale[:pipedrive_id] == activity['assigned_to_user_id']}.first
      sale[field] = sale[field] + 1 if sale
    end
  end

  def update_contacts_summary(sales, contacts, field)
    contacts.each do |deal|
      sale = sales.select {|sale| sale[:pipedrive_id] == deal['owner_id']['id']}.first
      sale[field] = sale[field] + 1 if sale
    end
  end

  def update_deals_summary(sales, deals, field)
    deals.each do |deal|
      sale = sales.select {|sale| sale[:pipedrive_id] == deal['user_id']['id']}.first
      sale[field] = sale[field] + 1 if sale
    end
  end

  def update_won_amount(sales, deals)
    deals.each do |deal|
      sale = sales.select {|sale| sale[:pipedrive_id] == deal['user_id']['id']}.first
      deal_amount = deal[WON_AMOUNT_KEY]
      sale[:won_amount] = sale[:won_amount] + deal_amount if sale && deal_amount
    end
  end

  def sales_list
    users = []
    ::SCOREBOARD_CONFIG['users'].each do |user|
      users << {
          name: user['name'],
          pipedrive_id: user['pipedrive_id'],
          created_deals: 0,
          decision_deals: 0,
          won_deals: 0,
          won_amount: 0,
          activities_count:0,
          person_count: 0
      }
    end
    users
  end

end