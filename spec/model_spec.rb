require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Model" do
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

  
  it 'to_ember' do
    model.to_ember.should == "
App.Book = DS.Model.extend({
  title: DS.attr('string'),
  author: DS.attr('string'),
  yearPublished: DS.attr('number')
});".strip
  end
end
