class PipedriveTotalsService

  def initialize(data)
    @data = data
  end

  def won_total
    @data ? @data['won_value'] : 0
  end

  def won_suggestion
    @data ? @data['weighted_value'] : 0
  end

end