class PropertiesController < ApplicationController

  def index
    @properties = Property.all
  end

  def create
  end

  def new
  end
  
  def show
  end

  def update
  end

  def destroy
  end

  private
    def property_params
      params.require(:property).permit(:name, :property_type, :coordinates, :address, :description)
    end
end
