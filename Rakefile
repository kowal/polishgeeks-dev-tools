# frozen_string_literal: true

require 'bundler'
require 'rake'
require 'polishgeeks-dev-tools'

desc 'Self check using command maintained in this gem'
task :check do
  PolishGeeks::DevTools.setup do |config|
    config.brakeman = false
    config.haml_lint = false
    config.expires_in_files_ignored = %w[
      lib/polish_geeks/dev_tools/commands/expires_in.rb
    ]
    config.empty_methods_ignored = %w[
      empty_methods_spec.rb
      file_parser_spec.rb
    ]
    config.rspec_files_structure_ignored = %w[lib/polishgeeks-dev-tools.rb]
  end

  PolishGeeks::DevTools::Runner.new.execute(
    PolishGeeks::DevTools::Logger.new
  )
end

task default: :check
