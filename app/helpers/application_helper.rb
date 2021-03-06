module ApplicationHelper
  # Tabs
  def ui_tab_link(name, options = {})
    return if options[:if] and not options[:if].call
    return if options[:unless] and options[:unless].call

    content_tag 'li' do
      link_to t(name, :scope => 'tabs'), "#tab-#{name}"
    end
  end

  def ui_tab_content(name, options = {})
    return if options[:if] and !options[:if].call
    return if options[:unless] and options[:unless].call

    partial = options.delete(:partial)
    partial ||= "tab_#{name}"
    
    content_tag 'div', :id => "tab-#{name}", :class => "ui-tabs-hide" do
      render partial
    end
  end
  
  def ui_tabs(tabs)
    content_tag 'div', :id => 'tabs', :class => 'ui-tabs' do
      buffer = content_tag 'ul' do
        tabs.collect do |tab|
          ui_tab_link tab[:name], tab
        end.to_s.html_safe
      end

      buffer += tabs.collect do |tab|
        ui_tab_content tab[:name], tab
      end.to_s.html_safe
      
      buffer
    end
  end
  
  def list_item_actions_for(resource)
    model_name = resource.class.to_s.underscore
    
    render 'layouts/list_item_actions_for', :model_name => model_name, :resource => resource
  end

  def tag_filter(model = nil, filters = nil, scope = :tagged_with)
    model ||= controller_name.singularize.camelize.constantize
    filters ||= model.top_tags

    render 'layouts/tag_filter', :filters => filters, :scope => scope
  end
  
  def sidebar_tag_filter
    content_for :sidebar do
      tag_filter
    end
  end
  
  # Nested form helpers
  def show_new_form(model)
    model_name = model.to_s.underscore
    
    output = <<EOF
$('##{model_name}_list').replaceWith('#{escape_javascript(render('form'))}');
addAutofocusBehaviour();
addAutocompleteBehaviour();
addNestedFormsBehaviour();
addCorrectnessIndicatorBehaviour();
addDatePickerBehaviour();
addAutogrowBehaviour();
EOF
  
    return output.html_safe
  end

  def hide_deleted_list_item(resource)
    model_name = resource.class.to_s.underscore
    
    output = <<EOF
$('##{model_name}_#{resource.id}').fadeOut("slow")
EOF
    
    return output.html_safe
  end
end
