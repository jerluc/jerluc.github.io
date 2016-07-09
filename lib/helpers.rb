include Nanoc::Helpers::Rendering

require 'date'

def get_date(item)
  Date.parse(item[:date])
end

def fixed_width_date(item)
  get_date(item).strftime('%Y-%m-%d')
end

def display_date(item)
  get_date(item).strftime('%-d %B %Y')
end
