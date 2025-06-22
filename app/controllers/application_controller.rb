class ApplicationController < ActionController::API
  def render_jsonapi(resource, serializer: nil, status: :ok, **options)
    serializer ||= "#{resource.class.name}Serializer".constantize
    render json: serializer.new(resource, options).serializable_hash, status: status
  end
end
