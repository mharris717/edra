module EDRA
  class Association
    include FromHash
    attr_accessor :name, :type
    
    def to_ember(ops={})
      "#{name.to_s.camelize(false)}: DS.#{ember_type}('App.#{name.to_s.camelize}')"
    end
    
    def ember_type
      res = type.to_s.camelize(false)
      raise "bad ember type #{res}" unless %w(hasMany belongsTo).include?(res)
      res
    end
  end
end