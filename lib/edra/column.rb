module EDRA
  class Column
    include FromHash
    attr_accessor :name, :type
    
    def ember_type
      if %w(string date number).include?(type)
        type
      elsif type =~ /varchar/i
        "string"
      elsif type =~ /character/i
        "string"
      elsif type == 'int'
        "number"
      elsif type == 'integer'
        "number"
      elsif type == 'datetime'
        "string"
      else
        raise "unknown type #{type}"
      end
    end
    
    def to_ember_attr
      "#{name}: DS.attr('#{ember_type}')"
    end
    def to_ember_camel_prop
      "#{name.to_s.camelize(false)}: (function() { return this.get('#{name}'); }).property('#{name}')"
    end
    
    def to_ember(ops={})
      res = []
      res << to_ember_attr
      res << "  " + to_ember_camel_prop if ops[:camel] && name.to_s != name.to_s.camelize(false)
      res.join(",\n")
    end
  end
end

