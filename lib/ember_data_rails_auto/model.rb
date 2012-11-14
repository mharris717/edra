module EDRA
  class Model
    include FromHash
    attr_accessor :name
    fattr(:columns) { [] }
    fattr(:associations) { [] }
    
    def to_ember_model
      cols = (columns+associations).map { |x| "  #{x.to_ember}" }.join(",\n")
      "App.#{name.camelize} = DS.Model.extend({
#{cols}
});"
    end
    
    def to_ember_coll
      "App.#{name.to_s.camelize(false)}s = App.store.findAll(App.#{name.to_s.camelize});"
    end
    
    def to_ember(ops={})
      res = to_ember_model
      res += "\n\n#{to_ember_coll}" if ops[:coll]
      res
    end
    
    def from_ar(ar_cls)
      self.name = ar_cls.name.downcase
      
      ar_cls.columns.each do |ar_col|
        self.columns << Column.new(:name => ar_col.name, :type => ar_col.type.to_s) unless ar_col.name.to_s == 'id'
      end
      
      ar_cls.reflections.each do |name,obj|
        self.associations << Association.new(:name => name, :type => obj.macro)
      end
    end
    def self.from_ar(ar_cls)
      new.tap { |x| x.from_ar(ar_cls) }
    end
  end
end

