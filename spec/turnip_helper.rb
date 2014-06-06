$:.unshift File.expand_path('../acceptance/supports', __FILE__)
Dir.glob("spec/acceptance/steps/**/*steps.rb") { |f| load f, true }