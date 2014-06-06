require 'abanalyzer'

class Statistics::Sample
  attr_reader :data

  def initialize
    @data = {}
  end

  def add(trial_result)
    unless @data[trial_result].nil?
      @data[trial_result] += 1
    else
      @data[trial_result] = 1
    end
  end

  def generated_from?(probabilities, sig=0.05)
    if probabilities.any? {|k, v| @data[k].nil? || @data[k] < 5}
      raise "sample size in every category must be greater than or equal to 5"
    end
    data_size = @data.values.inject(:+)
    category_size = @data.keys.size

    chi2_score = probabilities.keys.map{ |category|
      @data[category] * @data[category] / (data_size * probabilities[category])
    }.inject(:+) - data_size

    p_value = ::Statistics2.pchi2dist(category_size - 1, 1 - sig)
    puts "multinomial test..."
    puts "probabilities:"
    p probabilities
    puts "samples:"
    p @data
    puts "p_value: #{p_value}, score: #{chi2_score}"
    return chi2_score <= p_value
  end

  def generated_from_same_distribution?(another_data)
    data_size = @data.values.inject(:+)
    raise "data size id different" if data_size != another_data.values.inject(:+)

    another_data.each do |k, v|
      @data[k] = 0 if @data[k].nil?
    end

    @data.each do |k, v|
      another_data[k] = 0 if another_data[k].nil?
    end

    values = {data: @data, another_data: another_data}
    p "AB test with sample ..."
    p values
    not ABAnalyzer::ABTest.new(values).different?
  end
end
