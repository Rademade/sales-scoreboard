class ScoringService

  def scored_sales
    sales = sales_list
    update_deals_summary(sales, ::PipedriveService.instance.created_deals, :created_deals)
    update_deals_summary(sales, ::PipedriveService.instance.won_deals, :won_deals)
    update_deals_summary(sales, ::PipedriveService.instance.decision_deals, :decision_deals)
    update_activities_summary(sales, ::PipedriveService.instance.activities, :activities_count)
    update_contacts_summary(sales, ::PipedriveService.instance.contacts, :person_count)
    # sales
  end

  def update_activities_summary(sales, activities, field)
    activities.each do |activity|
      sale = sales.select { |sale|
        sale[:pipedrive_id] == activity['assigned_to_user_id']
      }.first
      sale[field] = sale[field] + 1 if sale
    end
  end

  def update_contacts_summary(sales, contacts, field)
    contacts.each do |deal|
      sale = sales.select { |sale|
        sale[:pipedrive_id] == deal['owner_id']['id']
      }.first
      sale[field] = sale[field] + 1 if sale
    end
    sales
  end

  def update_deals_summary(sales, items, field)
    items.each do |deal|
      sale = sales.select { |sale|
        sale[:pipedrive_id] == deal['user_id']['id']
      }.first
      sale[field] = sale[field] + 1 if sale
    end
    sales
  end


  def sales_list
    users = []
    ::SCOREBOARD_CONFIG['users'].each do |user|
      users << user_factory(user['name'], user['pipedrive_id'])
    end
    users
  end

  def user_factory(name, id)
    {
        name: name,
        pipedrive_id: id,
        created_deals: 0,
        decision_deals: 0,
        won_deals: 0,
        activities_count:0,
        person_count: 0
    }
  end

end