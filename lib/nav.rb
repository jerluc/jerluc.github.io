require 'set'

def path_for_item(item)
  item.identifier.to_s.chomp('index.html')
end

def section(item)
  path = path_for_item(item)
  path.split('/')[1] || 'index'
end

def subsection(item)
  path = path_for_item(item)
  s = path.split('/')
  if s.length > 2
    return s[2]
  end
end

def active_class?(section, *subsections)
  if section(@item) == section
    if subsections.length == 0 or (subsections.length > 0 and subsection(@item) == subsections[0])
      return 'active'
    end
  end
end

def subnav(item)
  s = section(item)
  if s == 'index'
    return nil
  end

  subsections = Set.new([])
  @items.each do |it|
    if section(it) == s and subsection(it)
      subsections.add(subsection(it))
    end
  end
  subsections.to_a.sort
end
