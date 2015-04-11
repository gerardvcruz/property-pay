class BaseController < ApplicationController
  # protect_from_forgery with: :null_session

  before_filter :only => [:new, :create] do
    params[resource_name.to_s] = resource_params
  end

  before_action :set_default_response_format
  before_action :set_includes
  before_action :set_resource, only: [:destroy, :show, :update]

  # calling this action ensures all requests are checked if they can be
  # accessed without authentication
  before_action :check_unauthenticated_access?

  # POST /api/v1/{plural_resource_name}
  def create
    # mannix 10/11/2014 commenting this for now, getting an error during testing
    # gerard 10/14/2014 fixed error, @mannix

    if @access_allowed || (can? :create, class_of_resource)
      if set_resource(class_of_resource.new(resource_params))
        get_resource.save
        render :create
      else
        render json: get_resource.errors, status: :unprocessable_entity
      end
    else
      render :json => "POST unauthorized"
    end
  end

  # DELETE /api/v1/{plural_resource_name}/1
  def destroy
    if @access_allowed || (can? :destroy, class_of_resource)
      get_resource.destroy
      head :no_content
    else
      render :json => "DELETE unauthorized"
    end
    # mannix 10/13/2014 gerard, skip_authorization_check is causing errors so commenting this out for now
    #skip_authorization_check
  end

  # GET /api/v1/{plural_resource_name}
  def index
    if @access_allowed || (can? :read, class_of_resource)
      plural_resource_name = "@#{resource_name.pluralize}"
      resources = class_of_resource.where(query_params)
            .page(page_params[:page]) # might not need this after all
            .per(page_params[:page_size])
            .as_json(:include => @includes)

      instance_variable_set(plural_resource_name, resources)
      render :json => instance_variable_get(plural_resource_name)
    else
      render :json => "GET unauthorized"
    end
  end

  # GET /api/v1/{plural_resource_name}/1
  def show
    if @access_allowed || (can? :read, class_of_resource)
      if !class_of_resource.where(:id => params[:id]).empty?
        render :show
      else
        render :status => 404, :json => {
          :status => "Not found"
        }
      end
    else
      render :json => "GET unauthorized"
    end
  end

  # PATCH/PUT /api/v1/{plural_resource_name}/1
  def update
    if @access_allowed || (can? :update, class_of_resource)
      if get_resource.update(resource_params)
        render :update
      # just shows "update success"
      # unless you wanna show a view or something
      # cos i don't know what to do
      else
        render json: get_resource.errors, status: :unprocessable_entity
      end
    else
      render :json => "PATCH/PUT unauthorized"
    end
  end

  private
    # returns the resource from the created instance variable
    # @return [Object]
    def get_resource
      instance_variable_get("@#{resource_name}")
    end

    # returns the allowed parameters for searching.
    # override this method in each API controller
    # to permit additional parameters to search on
    # @return [Hash]
    def query_params
      {}
    end

    # returns the allowed parameters for pagination
    # @return [Hash]
    def page_params
      params.permit(:page, :page_size)
    end

    # the resource class based on the controller
    # @return [Class]

    def class_of_resource
      @class_of_resource ||= resource_name.classify.constantize
    end

    # the singular name for the resource class based on the controller
    # @return [String]
    def resource_name
      @resource_name ||= self.controller_name.singularize
    end

    # only allow a trusted parameter "white list" through.
    # if a single resource is loaded for #create or #update,
    # then the controller for the resource must implement
    # the method "#{resource_name}_params" to limit permitted
    # parameters for the individual model.
    def resource_params
      @resource_params ||= self.send("#{resource_name}_params")
    end

    # use callbacks to share common setup or constraints between actions.
    def set_resource(resource = nil)
      resource ||= class_of_resource.find_by_id(params[:id])
      instance_variable_set("@#{resource_name}", resource)
    end

    def set_default_response_format
      request.format = :json
    end

    def set_includes
      @includes = []
      if params[:include]
        params[:include].split(",").each do |i|
          @includes << i.to_sym
        end
      end
    end
end
