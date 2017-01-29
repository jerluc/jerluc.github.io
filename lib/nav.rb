def item_for_url(rel_url)
  for item in @items
    if item.identifier.to_s.end_with?(rel_url)
      return item
    end
  end
  nil
end

def create_date_listing(items)
  things = []
  items.each do |item|
    year = get_date(item).strftime('%Y')
    things_for_year = things.detect { |i| i[:name] == year }
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
  things.sort_by { |thing_for_year| thing_for_year[:name] }.reverse
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
              :value => 'https://github.com/jerluc/riftd'
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
        #{
        #  :name => 'biq',
        #  :desc => 'Rift-enabled edge compute VM',
        #  :value => [
        #    {
        #      :name => 'Source',
        #      :value => 'https://github.com/jerluc/biq'
        #    }
        #  ]
        #},
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
          :name => 'LOVEr',
          :desc => 'Distro manager for the LOVE 2D game engine',
          :value => [
            {
              :name => 'Source',
              :value => 'https://github.com/jerluc/lover'
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
    # Fuck Ruby
    {
      :name => 'Tutorials',
      :value => [
        {
          :name => 'Introduction to programming',
          :value => [
            {
              :name => '0',
              :desc => 'A brief preface',
              :value => '/tutorials/introduction-to-programming/preface.html'
            },
            {
              :name => '1',
              :desc => 'What is programming?',
              :value => '/tutorials/introduction-to-programming/what-is-programming.html'
            },
            {
              :name => '2',
              :desc => 'Using the terminal',
              :value => '/tutorials/introduction-to-programming/using-the-terminal.html'
            },
            #{
            #  :name => '3',
            #  :desc => 'Navigating the file system',
            #  :value => '/tutorials/introduction-to-programming/navigating-the-filesystem.html'
            #},
            #{
            #  :name => '4',
            #  :desc => 'Introduction to Python',
            #  :value => '/tutorials/introduction-to-programming/introduction-to-python.html'
            #},
          ]
        }
      ]
    },
    {
      :name => 'Writings',
      :value => writings
    },
    {
      :name => 'Identities',
      :value => [
        {
          :name => 'Email',
          :desc => 'My inbox',
          :value => 'javascript:window.location=\'mailto:jeremy\' + \'a\' + \'lucas\' + \'@\' + \'gmail.com\''
        },
        {
          :name => 'GitHub',
          :desc => 'My code',
          :value => 'https://github.com/jerluc'
        },
        {
          :name => 'Keybase',
          :desc => 'My identities',
          :value => 'https://keybase.io/jerluc'
        },
        {
          :name => 'StackOverflow',
          :desc => 'My questions and answers',
          :value => 'http://stackoverflow.com/users/544109/jerluc'
        },
        {
          :name => 'Lobste.rs',
          :desc => 'My discussions and commentary',
          :value => 'https://lobste.rs/u/jerluc'
        },
        {
          :name => 'HackerRank',
          :desc => 'My challenges',
          :value => 'https://www.hackerrank.com/jerluc',
        },
        {
          :name => 'LinkedIn',
          :desc => 'My career',
          :value => 'https://www.linkedin.com/in/jeremy-lucas-51004033'
        }
      ]
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
    desc = %' <span class="desc">#{node[:desc]}</span>'
  end
  %{
    <li class="file"><a href="#{node[:value]}">#{node[:name]}</a>#{desc}</li>
  }
end

def _build_subtree(node)
  desc = ''
  if node.key?(:desc)
    desc = %' <span class="desc">#{node[:desc]}</span>'
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
