module CursorPage
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    module ClassMethods
      def cursor_page(options = {})
        key = options.fetch(:key, self.primary_key)
        before = options.fetch(:before, nil)
        after = options.fetch(:after, nil)

        scope = if before
          where("#{key} < ?", before).order(Hash[key, :desc])
        elsif after
          where("#{key} > ?", after).order(Hash[key, :asc])
        else
          order("#{key} desc")
        end

        scope.cursor = {
          key: key,
          before: before,
          after: after
        }
        scope
      end
    end
  end

  module ActiveRecordRelationExtension
    extend ActiveSupport::Concern

    included do
      attr_accessor :cursor
    end

    def reset #:nodoc:
      @cursor = nil
      super
    end

    def to_cursor_param
      cursor_param = {}

      if @cursor[:after].nil?
        cursor_param = {
          before: Base64.strict_encode64(last.try(@cursor[:key]).to_s),
          after: Base64.strict_encode64(first.try(@cursor[:key]).to_s)
        }
      else
        cursor_param = {
          before: Base64.strict_encode64(first.try(@cursor[:key]).to_s),
          after: Base64.strict_encode64(last.try(@cursor[:key]).to_s)
        }
      end

      cursor_param
    end
  end
end

ActiveRecord::Base.send(:include, CursorPage::ActiveRecordExtension)
ActiveRecord::Relation.send(:include, CursorPage::ActiveRecordRelationExtension)
