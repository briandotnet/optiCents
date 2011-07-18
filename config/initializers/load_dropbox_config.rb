# config/initializers/load_contest_config.rb
DROPBOX_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/dropbox_config.yml")[RAILS_ENV]