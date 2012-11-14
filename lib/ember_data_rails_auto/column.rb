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
    
    def to_ember
      "#{name}: DS.attr('#{ember_type}')"
    end
  end
end

