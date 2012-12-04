module EDRA
  class Association
    include FromHash
    attr_accessor :name, :type
    
    def to_ember(ops={})
      assoc_ops = if ember_type == "belongsTo"
        "{}"
      else
        "{key: 'book_ids'}"
        #{}"{}"
      end
      
      cls = if ember_type == 'belongsTo'
        name.to_s.camelize
      else
        name.to_s.camelize[0..-2]
      end
      "#{name.to_s.camelize(false)}: DS.#{ember_type}('App.#{cls}', #{assoc_ops})"
    end
    
    def ember_type
      res = type.to_s.camelize(false)
      raise "bad ember type #{res}" unless %w(hasMany belongsTo).include?(res)
      res
    end
  end
end