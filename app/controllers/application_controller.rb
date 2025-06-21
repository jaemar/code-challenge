class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def render_jsonapi(resource, serializer: nil, status: :ok, **options)
    serializer ||= "#{resource.class.name}Serializer".constantize
    render json: serializer.new(resource, options).serializable_hash, status: status
  end
end
