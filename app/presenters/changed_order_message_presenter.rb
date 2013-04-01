class ChangedOrderMessagePresenter < BasePresenter
  presents :message

  def body
    content_tag :ul, :class => 'changes-list' do
      message.changes.value.reduce(''.html_safe) do |sum, change|
        sum << render_field(change.first, change.last)
      end
    end
  end

  def render_field(field, change)
    content_tag :li do
      if respond_to?(format_method(field), true)
        send(format_method(field), field, change)
      else
        format_generic(field, change)
      end
    end
  end

private

  def format_order_state_field(field, change)
    "#{Order.field_name(field)} changed from #{Order.status(change[0])} to #{Order.status(change[1])}"
  end

  def format_price_field(field, change)
    "#{Order.field_name(field)} changed from #{number_to_currency(change[0])} to #{number_to_currency(change[1])}"
  end

  def format_generic(field, change)
    "#{Order.field_name(field)} changed from #{change[0]} to #{change[1]}"
  end

  def format_method(field)
    "format_#{field.underscore}_field"
  end
end
