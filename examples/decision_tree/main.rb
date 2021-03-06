
require_relative 'cross_validation'
require_relative 'decision_tree'

cols = [
  :age, :workclass, :fnlwgt, :education, :education_num, :marital_status,
  :occupation, :relationship, :race, :sex, :capital_gain, :capital_loss,
  :hours_per_week, :native_country, :income
]

def discretize(datum)
  Hash[*datum.flat_map { |k, v|
    discretized_value = case k
    when :age
      discretize_age(v)
    when :capital_gain
      discretize_capital_gain(v)
    when :capital_loss
      discretize_capital_loss(v)
    when :hours_per_week
      discretize_hours_per_week(v)
    else
      v
    end
    [k, discretized_value]
  }]
end

def discretize_age(v)
  v = v.to_i
  if v <= 18
    return "<= 18"
  elsif v > 18 and v <= 25
    return "> 18 and <= 25"
  elsif v > 25 and v <= 30
    return "> 25 and <= 30"
  elsif v > 40 and v <= 50
    return "> 40 and 50"
  elsif v > 50 and v <= 60
    return "> 50 and 60"
  else
    return "> 60"
  end
end

def discretize_capital_gain(v)
  v = v.to_i
  if v <= 10000
    return "<= 10000"
  elsif v > 10000 and v <= 20000
    return "10000 and 20000"
  elsif v > 20000 and v <= 30000
    return "20000 and 30000"
  elsif v > 30000 and v <= 40000
    return "30000 and 40000"
  elsif v > 40000 and v <= 50000
    return "40000 and 50000"
  elsif v > 50000 and v <= 60000
    return "50000 and 60000"
  elsif v > 60000 and v <= 70000
    return "60000 and 70000"
  elsif v > 70000 and v <= 80000
    return "70000 and 80000"
  elsif v > 80000 and v <= 90000
    return "80000 and 90000"
  else
    return "< 90000"
  end
end

def discretize_capital_loss(v)
  v = v.to_i
  if v <= 10000
    return "<= 10000"
  elsif v > 10000 and v <= 20000
    return "10000 and 20000"
  elsif v > 20000 and v <= 30000
    return "20000 and 30000"
  elsif v > 30000 and v <= 40000
    return "30000 and 40000"
  elsif v > 40000 and v <= 50000
    return "40000 and 50000"
  elsif v > 50000 and v <= 60000
    return "50000 and 60000"
  elsif v > 60000 and v <= 70000
    return "60000 and 70000"
  elsif v > 70000 and v <= 80000
    return "70000 and 80000"
  elsif v > 80000 and v <= 90000
    return "80000 and 90000"
  else
    return "< 90000"
  end
end

def discretize_hours_per_week(v)
  v = v.to_i
  if v <= 20
    return "< 20"
  elsif v > 20 and v <= 30
    return "20 and 30"
  elsif v > 30 and v <= 40
    return "30 and 40"
  else
    return "> 40"
  end
end

cv = CrossValidation.new(cols, {})

cv.setup do |cv|
  DecisionTree.load(cols, "data/adult.csv") do |example|
    data = discretize(example)
    data.delete(:fnlwgt)
    data.delete(:education_num)
    data.delete(:native_country)
    cv.add(data)
  end
end

cv.run(:income)


