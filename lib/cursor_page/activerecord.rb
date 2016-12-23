# frozen_string_literal: true
require 'active_support/lazy_load_hooks'

ActiveSupport.on_load :active_record do
  require 'cursor_page/activerecord/extension'
  ::ActiveRecord::Base.send :include, CursorPage::ActiveRecordExtension
  ::ActiveRecord::Relation.send :include, CursorPage::ActiveRecordRelationExtension
end
