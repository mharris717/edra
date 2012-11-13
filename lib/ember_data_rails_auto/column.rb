module EDRA
  class Column
    include FromHash
    attr_accessor :name, :type
    
    def ember_type
      if type =~ /varchar/i
        "string"
      elsif type =~ /character/i
        "string"
      elsif type == 'int'
        "number"
      elsif type == 'integer'
        "number"
      else
        type
      end
    end
    
    def to_ember
      "#{name.camelize(false)}: DS.attr('#{ember_type}')"
    end
  end
end