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
      column.to_ember.should == "yearPublished: DS.attr('number')"
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
