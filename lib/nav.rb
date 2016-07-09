def create_date_listing(items)
  things = []
  items.each do |item|
    year = get_date(item).strftime('%Y')
    things_for_year = things.detect {|i| i[:name] == year }
    if things_for_year == nil
      things_for_year = {
        :name => year,
        :value => []
      }
      things << things_for_year
    end

    things_for_year[:value] << {
      :name => %'"#{item[:title]}"',
      :date => fixed_width_date(item),
      :value => item.identifier.to_s
    }
    things_for_year[:value] = things_for_year[:value].sort_by { |item| item[:date] }.reverse
  end
  things
end

def build_tree
  writings = @items.select { |i| i.identifier.to_s.include?('writings') and i[:status] == 'ready' }
  writings = create_date_listing(writings)
  _tree = [
    {
      :name => 'Projects',
      :value => [
        {
          :name => 'Rift',
          :desc => 'Infrastructure-less IoT',
          :value => [
            {
              :name => 'Source',
              :value => 'https://github.com/jerluc/rift-exchange'
            },
            {
              :name => 'Docs (WIP)',
              :value => 'http://rift.exchange'
            },
            {
              :name => 'Presentation',
              :value => 'https://slides.com/jerluc/r'
            }
          ]
        },
        {
          :name => 'biq',
          :desc => 'Rift-enabled edge compute VM',
          :value => [
            {
              :name => 'Source',
              :value => 'https://github.com/jerluc/biq'
            }
          ]
        },
        {
          :name => 'Pir',
          :desc => 'Multicast LAN discovery library',
          :value => [
            {
              :name => 'Source',
              :value => 'https://github.com/jerluc/pir'
            }
          ]
        },
        {
          :name => 'GoBee',
          :desc => 'ZigBee protocol library',
          :value => [
            {
              :name => 'Source',
              :value => 'https://github.com/jerluc/gobee'
            }
          ]
        },
        {
          :name => 'qdpy',
          :desc => 'Quickly distributed Python',
          :value => [
            {
              :name => 'Source',
              :value => 'https://github.com/jerluc/qdpy'
            }
          ]
        },
        {
          :name => 'Envy',
          :desc => 'Project-based dev environments',
          :value => [
            {
              :name => 'Source',
              :value => 'https://github.com/jerluc/envy'
            },
            {
              :name => 'Docs',
              :value => 'https://envy.readthedocs.io'
            }
          ]
        },
        {
          :name => 'Hermes',
          :desc => 'Stdout notifications',
          :value => [
            {
              :name => 'Source',
              :value => 'https://github.com/jerluc/hermes'
            }
          ]
        }
      ]
    },
    {
      :name => 'Talks',
      :value => [
        {
          :name => '"Connecting wearable devices to the physical web"',
          :value => [
            {
              :name => 'Source',
              :value => 'https://github.com/jerluc/physical-web-wearable-demo'
            },
            {
              :name => 'Slides',
              :value => 'https://docs.google.com/presentation/d/1DIjxwMXz1SeWu9cjob0UwVY9teffEPUVxeMnC47ybqs/edit?usp='
            }
          ]
        }
      ]
    },
    {
      :name => 'Writings',
      :value => writings
    },
    {
      :name => 'Misc',
      :value => [
        {
          :name => 'VOID',
          :value => 'javascript:void(0)'
        }
      ]
    },
    {
      :name => 'Resume',
      :value => 'https://github.com/jerluc/resume'
    }
  ]
  _build_tree(_tree)
end

def _build_tree(tree)
  output = ''
  tree.each do |node|
    if node[:value].instance_of? String
      output += _build_terminal(node)
    else
      output += _build_subtree(node)
    end
  end
  output
end

def _build_terminal(node)
  desc = ''
  if node.key?(:desc)
    desc = %'<span>#{node[:desc]}</span>'
  end
  %{
    <li class="file"><a href="#{node[:value]}">#{node[:name]}</a>#{desc}</li>
  }
end

def _build_subtree(node)
  desc = ''
  if node.key?(:desc)
    desc = %'<span>#{node[:desc]}</span>'
  end
  %{
  <li class="dir">
    <details>
      <summary><a>#{node[:name]}</a>#{desc}</summary>
      <ul>
        #{_build_tree(node[:value])}
      </ul>
    </details>
  </li>
  }
end
