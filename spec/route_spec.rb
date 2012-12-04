require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Route" do
  let(:columns) do
    res = []
    res << EDRA::Column.new(:name => "title", :type => "string")
    res << EDRA::Column.new(:name => "author", :type => "string")
    res << EDRA::Column.new(:name => "year_published", :type => "integer")
    res
  end
  let(:model) do
    EDRA::Model.new(:name => "book", :columns => columns)
  end
  let(:route) do
    EDRA::Route.new(:model => model)
  end
  
  it 'to_ember' do
    exp = "
window.edra.routes.add({books: Ember.Route.extend({
route: '/books',

enter: function(router) { 
  console.debug('enter books'); 
},

connectOutlets: function(router) { 
  console.debug('connectOutlets books'); 
  router.get('applicationController').connectOutlet('books',App.books)
}
})
})"
    route.to_ember.should be_equal_lines(exp)
  end
end
