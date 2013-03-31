class MessagePresenter < BasePresenter
  presents :message

  def render_message
    div_for message, :class => 'message_body' do
      render_partial
    end
  end

  def render_partial
    locals = {message: message, presenter: self}
    render partial_path, locals
  end

  def partial_path
    partial_paths.detect do |path|
      lookup_context.template_exists? path, nil, true
    end || raise("No partial found for message in #{partial_paths}")
  end

  def partial_paths
    message_paths + ["messages/base"]
  end

  def message_paths
    message.type.nil? ? [] : ["messages/#{message.type.underscore}"]
  end
end
