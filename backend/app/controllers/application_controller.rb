class ApplicationController < ActionController::API
  def render_json(resource, serializer: nil, status: :ok, **options)
    resource_class = resource.is_a?(ActiveRecord::Relation) ? resource.klass : resource.class
    serializer ||= "#{resource_class.name}Blueprint".constantize
    render json: serializer.render(resource, options), status: status
  end

  def render_error(message, status: :internal_server_error)
    render json: { error: { message: message } }, status: status
  end
end
