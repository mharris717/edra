require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Model" do
  describe "no assoc" do
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
      model.to_ember.should be_equal_lines("App.Book = DS.Model.extend({
  title: DS.attr('string'),
  author: DS.attr('string'),
  year_published: DS.attr('number')
});")
    end
    
    it 'to_ember_coll' do
      reopen = "App.Book.reopenClass({url: 'book'});"
      model.to_ember_coll.should be_equal_lines("#{reopen}\nApp.books = App.store.findAll(App.Book);")
    end
  end
  
  describe "with assoc" do
    let(:columns) do
      res = []
      res << EDRA::Column.new(:name => "title", :type => "string")
      res << EDRA::Column.new(:name => "author_id", :type => "number")
      res << EDRA::Column.new(:name => "year_published", :type => "integer")
      res
    end
    let(:associations) do
      res = []
      res << EDRA::Association.new(:name => :author, :type => :belongs_to)
      res
    end
    let(:model) do
      EDRA::Model.new(:name => "book", :columns => columns, :associations => associations)
    end


    it 'to_ember' do
      model.to_ember.should be_equal_lines("
App.Book = DS.Model.extend({
  title: DS.attr('string'),
  author_id: DS.attr('number'),
  year_published: DS.attr('number'),
  author: DS.belongsTo('App.Author', {})
});")
    end
  end
end
