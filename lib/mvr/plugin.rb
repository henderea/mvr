require 'everyday-plugins'
include EverydayPlugins

module Mvr
  class OptionTypes
    extend PluginType

    def self.register_option(list, options)
      list.sort_by { |v| v[:options][:sym].to_s }.each { |option|
        id      = option[:options].delete(:sym)
        names   = option[:options].delete(:names)
        default = option[:options].delete(:default) || nil
        yield(id, names, option)
        options.default_options id => default unless default.nil?
      }
    end

    def self.def_options
      register_type(:option) { |list, options| register_option(list, options) { |id, names, option| options.option id, names, option[:options] } }
      register_type(:option_with_param) { |list, options| register_option(list, options) { |id, names, option| options.option_with_param id, names, option[:options] } }
    end

    def_options
  end
  class ColorTypes
    extend PluginType

    DEFAULT_COLOR_OPTS = {
        normal:   {
            fg: :none,
            bg: :none,
        },
        same:     {
            fg: :black,
            bg: :white,
        },
        conflict: {
            fg: :white,
            bg: :red,
        },
    }

    def self.def_color
      register_type(:color_override) { |list|
        options = Plugins.get_var :options
        opts    = DEFAULT_COLOR_OPTS
        list.sort_by { |v| -v[:options][:priority] }.each { |item|
          rval = item[:block].call(options)
          unless rval.nil? || !rval
            opts = rval
            break
          end
        }
        opts.each { |opt| Format.color_profile opt[0], fgcolor: opt[1][:fg], bgcolor: opt[1][:bg] }
      }
    end

    def_color
  end
  class NameChangeTypes
    extend PluginType

    register_type(:name_change_before) { |list, name|
      options = Plugins.get_var :options
      list.sort_by { |v| v[:options][:order] }.each { |item|
        if item[:block].nil?
          if !item[:options].has_key?(:option) || options[item[:options][:option]] == (item[:options].has_key?(:value) ? item[:options][:value] : true)
            if item[:options].has_key?(:regex)
              if item[:options].has_key?(:vars)
                item[:options][:vars].each { |var|
                  v = name.gsub(item[:options][:regex], var[1])
                  Plugins.set_var var[0], v == name ? nil : v
                }
              end
              name = name.gsub(item[:options][:regex], item[:options][:replace]) if item[:options].has_key?(:replace)
            end
            if item[:options].has_key?(:override)
              name = item[:options][:override].gsub(/\{:name\}/, name).gsub(/\{:(.+?)\}/) { |_|
                val = Plugins.get_var $1.to_sym
                val.nil? ? '' : val.to_s
              }
            end
          end
        else
          rval = item[:block].call(options, name)
          name = rval unless rval.nil? || !rval
        end
      }
      name
    }

    register_type(:name_change_after) { |list, name|
      options = Plugins.get_var :options
      list.sort_by { |v| v[:options][:order] }.each { |item|
        if item[:block].nil?
          if !item[:options].has_key?(:option) || options[item[:options][:option]] == (item[:options].has_key?(:value) ? item[:options][:value] : true)
            if item[:options].has_key?(:regex)
              if item[:options].has_key?(:vars)
                item[:options][:vars].each { |var|
                  v = name.gsub(item[:options][:regex], var[1])
                  Plugins.set_var var[0], v == name ? nil : v
                }
              end
              name = name.gsub(item[:options][:regex], item[:options][:replace]) if item[:options].has_key?(:replace)
            end
            if item[:options].has_key?(:override)
              name = item[:options][:override].gsub(/\{:name\}/, name).gsub(/\{:(.+?)\}/) { |_|
                val = Plugins.get_var $1.to_sym
                val.nil? ? '' : val.to_s
              }
            end
          end
        else
          rval = item[:block].call(options, name)
          name = rval unless rval.nil? || !rval
        end
      }
      name
    }
  end
end