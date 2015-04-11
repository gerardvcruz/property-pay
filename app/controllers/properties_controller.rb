class PropertiesController < ApplicationController
  attr_accessor :name, :email

  def index
    redirect_to owner_properties_path
  end

  def list
    @properties = Property.all
  end

  def create
    property = Property.new
    property.name = params[:name]
    property.property_type = params[:property_type]
    property.rent_price = params[:rent_price]
    property.save


    redirect_to owner_properties_path
    #Property.create(property_params)
  end

  def new
  end

  def show
    @property = Property.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private
    def property_params
      params.require(:property).permit(:name)
    end
end
