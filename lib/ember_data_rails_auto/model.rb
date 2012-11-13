class String
  def camelize(first_upper = true)
    parts = split("_")
    return (first_upper ? parts.first[0..0].upcase : parts.first[0..0]) + parts.first[1..-1] if parts.size == 1
    res = []
    parts.each_with_index do |part,i|
      fu = (i != 0 || first_upper)
      res << part.camelize(fu)
    end
    res.join("")
  end
end

module EDRA
  class Model
    include FromHash
    attr_accessor :name, :columns
    
    def to_ember
      cols = columns.map { |x| "  #{x.to_ember}" }.join(",\n")
      "App.#{name.camelize} = DS.Model.extend({
#{cols}
});"
    end
  end
end