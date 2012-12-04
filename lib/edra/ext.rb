class String
  def camelize(first_upper = true)
    parts = split("_")
    return (first_upper ? parts.first[0..0].upcase : parts.first[0..0].downcase) + parts.first[1..-1] if parts.size == 1
    res = []
    parts.each_with_index do |part,i|
      fu = (i != 0 || first_upper)
      res << part.camelize(fu)
    end
    res.join("")
  end
end