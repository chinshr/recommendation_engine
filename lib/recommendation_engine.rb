require 'active_record'

require 'recommendation_engine/model'
ActiveRecord::Base.send(:include, RecommendationEngine::Model)

require 'recommendation_engine/progress_bar'
require 'recommendation_engine/cache_fix'

# Fix RubyInline's permission problem,
# RubyInline doesn't like directories with
# group write permissions (like /tmp).
# ENV['INLINEDIR'] = File.join(Rails.root, 'tmp', 'rubyinline')
begin
  require 'inline'
  require 'recommendation_engine/optimizations'
rescue LoadError; end