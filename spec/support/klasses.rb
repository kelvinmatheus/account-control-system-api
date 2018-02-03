module Klasses
  module KlassHelpers
    def symbolize_klass(name)
      name.to_s.underscore.to_sym
    end
  end
end