# NOTE: https://eonasdan.github.io/bootstrap-datetimepicker/Extras/
module ActionView
  module Helpers
    class FormBuilder
      def datetime_select(method, options = {}, html_options = {})
        existing_time = @object.send(method)
        formatted_time = existing_time.to_time.strftime("%d.%m.%Y %H:%M") if existing_time.present?
        @template.content_tag(:div, :class => "input-group") do
          text_field(method, :value => formatted_time, :class => "form-control datetimepicker", :"data-date-format" => "DD.MM.YYYY HH:mm") +
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
        end
      end
    end
  end
end
