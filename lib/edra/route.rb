module EDRA
  class Route
    include FromHash
    attr_accessor :model
    fattr(:coll_name) { model.coll_name }
    fattr(:name) { model.route_name }
    
    def to_ember
      "window.edra.routes.add({#{name}: Ember.Route.extend({
  route: '/#{name}',

  enter: function(router) { 
    console.debug('enter #{name}'); 
  },

  connectOutlets: function(router) { 
    console.debug('connectOutlets #{name}'); 
    router.get('applicationController').connectOutlet('#{name}',App.#{coll_name})
  }
})
})".strip
    end
    
  end
end