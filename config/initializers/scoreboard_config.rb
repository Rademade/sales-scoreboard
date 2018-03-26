SCOREBOARD_CONFIG = YAML.load(
    ERB.new(File.read("#{Rails.root}/config/scoreboard.yml")).result
)[Rails.env]