module EDRA
  class Model
    include FromHash
    attr_accessor :name
    fattr(:columns) { [] }
    fattr(:associations) { [] }
    def name; @name.to_s; end
    
    def class_name
      name.camelize
    end
    def coll_name
      name.camelize(false) + "s"
    end
    def route_name
      coll_name
    end
    
    def to_ember(ops={})
      res = []
      res << to_ember_model(ops) unless ops[:model] == false
      res << to_ember_coll if ops[:coll]
      res << to_ember_route if ops[:route]
      res.join("\n\n")
    end
    
    def from_ar(ar_cls)
      self.name = ar_cls.name.downcase
      
      self.columns = ar_cls.columns.reject { |x| x.name.to_s == 'id' }.map { |x| Column.new(:name => x.name, :type => x.type.to_s) }
      
      ar_cls.reflections.each do |name,obj|
        self.associations << Association.new(:name => name, :type => obj.macro)
      end
    end
    def self.from_ar(ar_cls)
      new.tap { |x| x.from_ar(ar_cls) }
    end
    
    module JS
      def to_ember_model(ops={})
        cols = (columns+associations).map { |x| "  #{x.to_ember(ops)}" }.join(",\n")
        "
App.#{class_name} = DS.Model.extend({
  #{cols}
});".strip
      end

      def to_ember_coll
        "
App.#{class_name}.reopenClass({url: '#{name}'});

App.#{coll_name} = App.store.findAll(App.#{class_name});".strip
      end

      def to_ember_route
        "
window.rootRoute.reopen({
  #{route_name}: Ember.Route.extend({
    route: '/#{route_name}',

    enter: function(router) { 
      console.debug('enter #{route_name}'); 
    },

    connectOutlets: function(router) { 
      console.debug('connectOutlets #{route_name}'); 
      router.get('applicationController').connectOutlet('#{route_name}',App.#{coll_name})
    }
  })
})".strip
      end
    end
    
    include JS
  end
end

