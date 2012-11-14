require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Column" do
  
  describe 'simple column' do
    let(:column) do
      EDRA::Column.new(:name => "title", :type => "string")
    end
  
    it 'to_ember' do
      column.to_ember.should == "title: DS.attr('string')"
    end
  end
  
  describe 'underscore column' do
    let(:column) do
      EDRA::Column.new(:name => "year_published", :type => "integer")
    end
  
    it 'to_ember' do
      column.to_ember.should == "year_published: DS.attr('number')"
    end
    
    it 'to_ember with camel prop' do
      column.to_ember(:camel => true).should == "year_published: DS.attr('number'),\n  yearPublished: (function() { return this.get('year_published'); }).property('year_published')"
    end
  end
  
  describe "type conversion" do
    def em_type(type)
      EDRA::Column.new(:type => type).ember_type
    end
    it 'varchar' do
      em_type('varchar').should == 'string'
    end
    it 'varchar(255)' do
      em_type('varchar').should == 'string'
    end
    it 'character varying' do
      em_type('character varying(255)').should == 'string'
    end
    it 'int' do
      em_type('int').should == 'number'
    end
  end
  
end
