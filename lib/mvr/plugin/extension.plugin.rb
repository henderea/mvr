require 'everyday-plugins'
include EverydayPlugins

class ExtensionPlugin
  extend Plugin

  register :option, sym: :exclude_extension, names: %w(-e --exclude-extension), desc: 'remove the file extension before doing the rename operation.  the extension will be added back on after renaming.'

  register :name_change_before, order: 10, option: :exclude_extension, regex: /^(.+)(\..+?)$/, replace: '\1', vars: { ext: '\2' }
  register :name_change_after, order: 10, option: :exclude_extension, override: '{:name}{:ext}'
end