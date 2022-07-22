%% ¡header!
SettingsEdgesPP < PanelProp (pr, settings graph panel) is the panel with graph settings.

%%% ¡description!
SettingsEdgesPP plots the panel for brain graph settings 

%%% ¡seealso!
SettingsPosition, uicheckbox, uipushbutton

%% ¡properties!
p

% checkboxes
checkbox_link
checkbox_arrow
checkbox_cylinder
checkbox_text

% buttons
button_link_color
button_arrow_color
button_cylinder_color

% dropdowns
dropdown_link

% labels and editfields
label_link_w
edit_link_w
label_arrow_sw
edit_arrow_sw
label_arrow_hl
edit_arrow_hl
label_arrow_hw
edit_arrow_hw
label_arrow_node
edit_arrow_node
label_arrow_n
edit_arrow_n
label_cylinder_r
edit_cylinder_r
label_cylinder_n
edit_cylinder_n

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of graph settings.
    %
    % DRAW(PR) draws the panel of graph settings.
    %
    % P = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard panel properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the panel.
    %
    % See also update, redraw, uipanel.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PanelProp(pr, varargin{:});    

    % link %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ~check_graphics(pr.checkbox_link, 'uicheckbox')
        pr.checkbox_link = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_link', ...
            'Text', 'Links', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINKS')) ' ' el.get(prop).getPropDescription('LINKS')], ...
            'ValueChangedFcn', {@cb_checkbox_link} ...
            );
    end
    function cb_checkbox_link(~, ~) % (src, event)
        value = get(pr.checkbox_link, 'Value');
        if value
            set(pr.checkbox_arrow, 'Value', ~value);
            set(pr.checkbox_cylinder, 'Value', ~value);
        end
        
        state_checkboxes()
        pr.cb_brain_edges()        
    end

    if ~check_graphics(pr.dropdown_link, 'uieditfield')
        pr.dropdown_link = uidropdown( ...
            'Parent', pr.p, ...
            'Tag', 'dropdown_link', ...
            'Items', el.get(prop).getPropSettings('LINKLINESTYLE'), ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINKLINESTYLE')) ' ' el.get(prop).getPropDescription('LINKLINESTYLE')], ...
            'ValueChangedFcn', {@cb_dropdown_link} ...
            );
    end
    function cb_dropdown_link(~, ~) % (src, event)
        pr.cb_brain_edges()
    end

    if ~check_graphics(pr.button_link_color, 'uibutton')
        pr.button_link_color = uibutton( ...
            'Parent', pr.p, ...
            'Tag', 'button_link_color', ...
            'Text', '', ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINKSCOLOR')) ' ' el.get(prop).getPropDescription('LINKSCOLOR')], ...
            'ButtonPushedFcn', {@cb_button_link_color} ...
            );
    end
    function cb_button_link_color(~, ~) % (src, event)
            pr.cb_button_linkcolor()
        end

    if ~check_graphics(pr.label_link_w, 'uilabel')
        pr.label_link_w =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_link_w', ...
            'Text', 'Width', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.edit_link_w, 'uieditfield')
        pr.edit_link_w = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'edit_link_w', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINKLINEWIDTH')) ' ' el.get(prop).getPropDescription('LINKLINEWIDTH')], ...
            'ValueChangedFcn', {@cb_editfield_link_w} ...
            );
    end
    function cb_editfield_link_w(~, ~) % (src, event)
        pr.cb_brain_edges()
    end

    % arrow %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ~check_graphics(pr.checkbox_arrow, 'uicheckbox')
        pr.checkbox_arrow = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_link', ...
            'Text', 'colorbar', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Visible', true, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINKS')) ' ' el.get(prop).getPropDescription('LINKS')], ...
            'ValueChangedFcn', {@cb_checkbox_arrow} ...
            );
    end    
    function cb_checkbox_arrow(~, ~) % (src, event)
        value = get(pr.checkbox_arrow, 'Value');
        if value
            set(pr.checkbox_link, 'Value', ~value);
            set(pr.checkbox_cylinder, 'Value', ~value);
        end
        state_checkboxes()
        pr.cb_brain_edges()
    end

    if ~check_graphics(pr.button_arrow_color, 'uibutton')
        pr.button_arrow_color = uibutton( ...
            'Parent', pr.p, ...
            'Tag', 'button_arrow_color', ...
            'Text', '', ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('ARROWCOLOR')) ' ' el.get(prop).getPropDescription('ARROWCOLOR')], ...
            'ButtonPushedFcn', {@cb_button_arrow_color} ...
            );
    end
    function cb_button_arrow_color(~, ~) % (src, event)
        pr.cb_button_arrowcolor()
    end

    if ~check_graphics(pr.label_arrow_sw, 'uilabel')
        pr.label_arrow_sw =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_arrow_sw', ...
            'Text', 'S Width', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.edit_arrow_sw, 'uieditfield')
        pr.edit_arrow_sw = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'edit_arrow_sw', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('ARROWSWIDTH')) ' ' el.get(prop).getPropDescription('ARROWSWIDTH')], ...
            'ValueChangedFcn', {@cb_editfield_arrow_sw} ...
            );
    end
    function cb_editfield_arrow_sw(~, ~) % (src, event)
        pr.cb_brain_edges()
    end

    if ~check_graphics(pr.label_arrow_hl, 'uilabel')
        pr.label_arrow_hl =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_arrow_hl', ...
            'Text', 'H Length', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.edit_arrow_hl, 'uieditfield')
        pr.edit_arrow_hl = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'edit_arrow_hl', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('ARROWHLENGTH')) ' ' el.get(prop).getPropDescription('ARROWHLENGTH')], ...
            'ValueChangedFcn', {@cb_editfield_arrow_hl} ...
            );
    end
    function cb_editfield_arrow_hl(~, ~) % (src, event)
        pr.cb_brain_edges()
    end
    
    if ~check_graphics(pr.label_arrow_hw, 'uilabel')
        pr.label_arrow_hw =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_arrow_hw', ...
            'Text', 'H Width', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.edit_arrow_hw, 'uieditfield')
        pr.edit_arrow_hw = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'edit_arrow_hw', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('ARROWHWIDTH')) ' ' el.get(prop).getPropDescription('ARROWHWIDTH')], ...
            'ValueChangedFcn', {@cb_editfield_arrow_hw} ...
            );
    end
    function cb_editfield_arrow_hw(~, ~) % (src, event)
        pr.cb_brain_edges()
    end

    if ~check_graphics(pr.label_arrow_node, 'uilabel')
        pr.label_arrow_node =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_arrow_node', ...
            'Text', 'Node', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.edit_arrow_node, 'uieditfield')
        pr.edit_arrow_node = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'edit_arrow_node', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('ARROWHNODE')) ' ' el.get(prop).getPropDescription('ARROWHNODE')], ...
            'ValueChangedFcn', {@cb_editfield_arrow_node} ...
            );
    end
    function cb_editfield_arrow_node(~, ~) % (src, event)
        pr.cb_brain_edges()
    end

    if ~check_graphics(pr.label_arrow_n, 'uilabel')
        pr.label_arrow_n =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_arrow_n', ...
            'Text', 'N', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.edit_arrow_n, 'uieditfield')
        pr.edit_arrow_n = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'edit_arrow_n', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('ARROWN')) ' ' el.get(prop).getPropDescription('ARROWN')], ...
            'ValueChangedFcn', {@cb_editfield_arrow_n} ...
            );
    end
    function cb_editfield_arrow_n(~, ~) % (src, event)
        pr.cb_brain_edges()
    end

    % cylinder %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ~check_graphics(pr.checkbox_cylinder, 'uicheckbox')
        pr.checkbox_cylinder = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_cylinder', ...
            'Text', 'binary', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('BINARY')) ' ' el.get(prop).getPropDescription('BINARY')], ...
            'ValueChangedFcn', {@cb_checkbox_cylinder} ...
            );
    end
    
    function cb_checkbox_cylinder(~, ~) % (src, event)
        value = get(pr.checkbox_cylinder, 'Value');
        if value
            set(pr.checkbox_link, 'Value', ~value);
            set(pr.checkbox_arrow, 'Value', ~value);
        end
        state_checkboxes()
        pr.cb_brain_edges()
    end

    if ~check_graphics(pr.button_cylinder_color, 'uibutton')
        pr.button_cylinder_color = uibutton( ...
            'Parent', pr.p, ...
            'Tag', 'button_cylinder_color', ...
            'Text', '', ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('CYLCOLOR')) ' ' el.get(prop).getPropDescription('CYLCOLOR')], ...
            'ButtonPushedFcn', {@cb_button_cyl_color} ...
            );
    end
    function cb_button_cyl_color(~, ~) % (src, event)
        pr.cb_button_cylcolor()
    end

    if ~check_graphics(pr.label_cylinder_r, 'uilabel')
        pr.label_cylinder_r =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_cylinder_r', ...
            'Text', 'Radius', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.edit_cylinder_r, 'uieditfield')
        pr.edit_cylinder_r = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'edit_cylinder_r', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('CYLR')) ' ' el.get(prop).getPropDescription('CYLR')], ...
            'ValueChangedFcn', {@cb_editfield_cyl_r} ...
            );
    end
    function cb_editfield_cyl_r(~, ~) % (src, event)
        pr.cb_brain_edges()
    end

    if ~check_graphics(pr.label_cylinder_n, 'uilabel')
        pr.label_cylinder_n =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_cylinder_n', ...
            'Text', 'N', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.edit_cylinder_n, 'uieditfield')
        pr.edit_cylinder_n = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'edit_cylinder_n', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('CYLN')) ' ' el.get(prop).getPropDescription('CYLN')], ...
            'ValueChangedFcn', {@cb_editfield_cyl_n} ...
            );
    end
    function cb_editfield_cyl_n(~, ~) % (src, event)
        pr.cb_brain_edges()
    end

    % text
    if ~check_graphics(pr.checkbox_text, 'uicheckbox')
        pr.checkbox_text = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_text', ...
            'Text', 'Texts', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('TEXTS')) ' ' el.get(prop).getPropDescription('TEXTS')], ...
            'ValueChangedFcn', {@cb_checkbox_text} ...
            );
    end
    function cb_checkbox_text(~, ~) % (src, event)
        pr.cb_brain_edges()
    end  

    % general functions
    function state_checkboxes()
        if get(pr.checkbox_link, 'Value') % link
            % activate
            set(pr.button_link_color, 'Visible', true)
            set(pr.dropdown_link, 'Visible', true)
            set(pr.label_link_w, 'Visible', true)
            set(pr.edit_link_w, 'Visible', true)           

            % deactivate
            set(pr.button_arrow_color, 'Visible', false)
            set(pr.button_cylinder_color, 'Visible', false)
            set(pr.label_arrow_sw, 'Visible', false)
            set(pr.edit_arrow_sw, 'Visible', false)
            set(pr.label_arrow_hl, 'Visible', false)
            set(pr.edit_arrow_hl, 'Visible', false)
            set(pr.label_arrow_hw, 'Visible', false)
            set(pr.edit_arrow_hw, 'Visible', false)
            set(pr.label_arrow_node, 'Visible', false)
            set(pr.edit_arrow_node, 'Visible', false)
            set(pr.label_arrow_n, 'Visible', false)
            set(pr.edit_arrow_n, 'Visible', false)
            set(pr.label_cylinder_r, 'Visible', false)
            set(pr.edit_cylinder_r, 'Visible', false)
            set(pr.label_cylinder_n, 'Visible', false)
            set(pr.edit_cylinder_n, 'Visible', false)            
            
        elseif get(pr.checkbox_arrow, 'Value') % arrow
            % activate
            set(pr.button_arrow_color, 'Visible', true)
            set(pr.label_arrow_sw, 'Visible', true)
            set(pr.edit_arrow_sw, 'Visible', true)
            set(pr.label_arrow_hl, 'Visible', true)
            set(pr.edit_arrow_hl, 'Visible', true)
            set(pr.label_arrow_hw, 'Visible', true)
            set(pr.edit_arrow_hw, 'Visible', true)
            set(pr.label_arrow_node, 'Visible', true)
            set(pr.edit_arrow_node, 'Visible', true)
            set(pr.label_arrow_n, 'Visible', true)
            set(pr.edit_arrow_n, 'Visible', true)

            % deactivate            
            set(pr.button_cylinder_color, 'Visible', false)
            set(pr.button_link_color, 'Visible', false)
            set(pr.dropdown_link, 'Visible', false)
            set(pr.label_link_w, 'Visible', false)
            set(pr.edit_link_w, 'Visible', false)             
            set(pr.label_cylinder_r, 'Visible', false)
            set(pr.edit_cylinder_r, 'Visible', false)
            set(pr.label_cylinder_n, 'Visible', false)
            set(pr.edit_cylinder_n, 'Visible', false)    
        elseif get(pr.checkbox_cylinder, 'Value') % cylinder
            % activate            
            set(pr.button_cylinder_color, 'Visible', true)
            set(pr.label_cylinder_r, 'Visible', true)
            set(pr.edit_cylinder_r, 'Visible', true)
            set(pr.label_cylinder_n, 'Visible', true)
            set(pr.edit_cylinder_n, 'Visible', true) 

            % deactivate            
            set(pr.button_arrow_color, 'Visible', false)
            set(pr.label_arrow_sw, 'Visible', false)
            set(pr.edit_arrow_sw, 'Visible', false)
            set(pr.label_arrow_hl, 'Visible', false)
            set(pr.edit_arrow_hl, 'Visible', false)
            set(pr.label_arrow_hw, 'Visible', false)
            set(pr.edit_arrow_hw, 'Visible', false)
            set(pr.label_arrow_node, 'Visible', false)
            set(pr.edit_arrow_node, 'Visible', false)
            set(pr.label_arrow_n, 'Visible', false)
            set(pr.edit_arrow_n, 'Visible', false)
            set(pr.button_link_color, 'Visible', false)
            set(pr.dropdown_link, 'Visible', false)
            set(pr.label_link_w, 'Visible', false)
            set(pr.edit_link_w, 'Visible', false)             
            
        else % texts
            
        end
    end

    state_checkboxes()
    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the graph settings.
    %
    % UPDATE(PR) updates the content and permissions of the graph settings.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.checkbox_link, 'Enable', pr.get('ENABLE'))
        set(pr.checkbox_arrow, 'Enable', pr.get('ENABLE'))
        set(pr.checkbox_cylinder, 'Enable', pr.get('ENABLE'))
        set(pr.checkbox_text, 'Enable', pr.get('ENABLE'))
        
        set(pr.button_link_color, 'Enable', pr.get('ENABLE'))
        set(pr.button_arrow_color, 'Enable', pr.get('ENABLE'))
        set(pr.button_cylinder_color, 'Enable', pr.get('ENABLE'))
        
        set(pr.dropdown_link, 'Enable', pr.get('ENABLE'))
        
        set(pr.edit_link_w, 'Enable', pr.get('ENABLE'))
        set(pr.edit_arrow_sw, 'Enable', pr.get('ENABLE'))
        set(pr.edit_arrow_hl, 'Enable', pr.get('ENABLE'))
        set(pr.edit_arrow_hw, 'Enable', pr.get('ENABLE'))
        set(pr.edit_arrow_node, 'Enable', pr.get('ENABLE'))
        set(pr.edit_arrow_n, 'Enable', pr.get('ENABLE'))        
        set(pr.edit_cylinder_r, 'Enable', pr.get('ENABLE'))
        set(pr.edit_cylinder_n, 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA            
            set(pr.checkbox_link, 'Value', el.get(prop).get('LINKS'))
            set(pr.checkbox_arrow, 'VALUE', el.get(prop).get('ARROWS'))
            set(pr.checkbox_cylinder, 'Value', el.get(prop).get('CYLINDERS'))
            set(pr.checkbox_text, 'Value', el.get(prop).get('TEXTS'))
            
            set(pr.dropdown_link, 'Value', el.get(prop).get('LINKLINESTYLE'))
            
            set(pr.edit_link_w, 'Value', el.get(prop).get('LINKLINEWIDTH'))
            set(pr.edit_arrow_sw, 'Value', el.get(prop).get('ARROWSWIDTH'))
            set(pr.edit_arrow_hl, 'Value', el.get(prop).get('ARROWHLENGTH'))
            set(pr.edit_arrow_hw, 'Value', el.get(prop).get('ARROWHWIDTH'))
            set(pr.edit_arrow_node, 'Value', el.get(prop).get('ARROWHNODE'))
            set(pr.edit_arrow_n, 'Value', el.get(prop).get('ARROWN'))
            set(pr.edit_cylinder_r, 'Value', el.get(prop).get('CYLR'))
            set(pr.edit_cylinder_n, 'Value', el.get(prop).get('CYLN'))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.checkbox_link, 'Value', el.get(prop).get('LINKS'))
            set(pr.checkbox_arrow, 'VALUE', el.get(prop).get('ARROWS'))
            set(pr.checkbox_cylinder, 'Value', el.get(prop).get('CYLINDERS'))
            set(pr.checkbox_text, 'Value', el.get(prop).get('TEXTS'))
            
            set(pr.dropdown_link, 'Value', el.get(prop).get('LINKLINESTYLE'))
            
            set(pr.edit_link_w, 'Value', el.get(prop).get('LINKLINEWIDTH'))
            set(pr.edit_arrow_sw, 'Value', el.get(prop).get('ARROWSWIDTH'))
            set(pr.edit_arrow_hl, 'Value', el.get(prop).get('ARROWHLENGTH'))
            set(pr.edit_arrow_hw, 'Value', el.get(prop).get('ARROWHWIDTH'))
            set(pr.edit_arrow_node, 'Value', el.get(prop).get('ARROWHNODE'))
            set(pr.edit_arrow_n, 'Value', el.get(prop).get('ARROWN'))
            set(pr.edit_cylinder_r, 'Value', el.get(prop).get('CYLR'))
            set(pr.edit_cylinder_n, 'Value', el.get(prop).get('CYLN'))


            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LINKS'), 'Callback')
                set(pr.checkbox_link, 'Enable', pr.get('ENABLE'))                
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('ARROWS'), 'Callback')
                set(pr.checkbox_arrow, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('CYLINDERS'), 'Callback')
                set(pr.checkbox_cylinder, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('TEXTS'), 'Callback')
                set(pr.checkbox_text, 'Enable', pr.get('ENABLE'))
            end
            
        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.checkbox_link, ...
                    'Value', el.get(prop).getPropDefault('LINKS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_arrow, 'VALUE', el.get(prop).get('ARROWS'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.checkbox_cylinder, ...
                    'Value', el.get(prop).getPropDefault('CYLINDERS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_text, ...
                    'Value', el.get(prop).getPropDefault('TEXTS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                
                set(pr.dropdown_link, 'Value', el.get(prop).get('LINKLINESTYLE'), ...
                    'Enable', pr.get('ENABLE'))
            
                set(pr.edit_link_w, 'Value', el.get(prop).get('LINKLINEWIDTH'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.edit_arrow_sw, 'Value', el.get(prop).get('ARROWSWIDTH'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.edit_arrow_hl, 'Value', el.get(prop).get('ARROWHLENGTH'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.edit_arrow_hw, 'Value', el.get(prop).get('ARROWHWIDTH'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.edit_arrow_node, 'Value', el.get(prop).get('ARROWHNODE'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.edit_arrow_n, 'Value', el.get(prop).get('ARROWN'), 'Enable', ...
                    pr.get('ENABLE'))
                set(pr.edit_cylinder_r, 'Value', el.get(prop).get('CYLR'), 'Enable', ...
                    pr.get('ENABLE'))
                set(pr.edit_cylinder_n, 'Value', el.get(prop).get('CYLN'), 'Enable', ...
                    pr.get('ENABLE'))
            else
                set(pr.checkbox_link, ...
                    'Value', el.get(prop).get('AXIS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_arrow, 'VALUE', el.get(prop).get('ARROWS'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.checkbox_cylinder, ...
                    'Value', el.get(prop).get('CYLINDERS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_text, ...
                    'Value', el.get(prop).get('TEXTS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                
                set(pr.dropdown_link, 'Value', el.get(prop).get('LINKLINESTYLE'), ...
                    'Enable', pr.get('ENABLE'))
            
                set(pr.edit_link_w, 'Value', el.get(prop).get('LINKLINEWIDTH'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.edit_arrow_sw, 'Value', el.get(prop).get('ARROWSWIDTH'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.edit_arrow_hl, 'Value', el.get(prop).get('ARROWHLENGTH'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.edit_arrow_hw, 'Value', el.get(prop).get('ARROWHWIDTH'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.edit_arrow_node, 'Value', el.get(prop).get('ARROWHNODE'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.edit_arrow_n, 'Value', el.get(prop).get('ARROWN'), 'Enable', ...
                    pr.get('ENABLE'))
                set(pr.edit_cylinder_r, 'Value', el.get(prop).get('CYLR'), 'Enable', ...
                    pr.get('ENABLE'))
                set(pr.edit_cylinder_n, 'Value', el.get(prop).get('CYLN'), 'Enable', ...
                    pr.get('ENABLE'))
            end
    end
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'pixels' for panel. 
    % 2. REDRAW() is typically called internally by PanelElement and does not need 
    %  to be explicitly called in children of PanelProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT = s(5.5)
    %
    % See also draw, update, PanelElement, s.

    [h_p, varargin] = get_and_remove_from_varargin(s(12.3), 'Height', varargin);
    
    pr.redraw@PanelProp('Height', h_p, varargin{:})
    
    % left column 2.3
    set(pr.checkbox_link, 'Position', [s(.3) s(9.8) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.checkbox_arrow, 'Position', [s(.3) s(6.3) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.checkbox_cylinder, 'Position', [s(.3) s(3.8) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.checkbox_text, 'Position', [s(.3) s(.3) .30*w(pr.p, 'pixels') s(1.7)])
    
    % right column
    % links   
    set(pr.dropdown_link, 'Position', [s(8.6) s(8.3) w(pr.p, 'pixels')-s(10) s(1.7)])
    set(pr.label_link_w, 'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(6.2) .1*w(pr.p, 'pixels')  s(1.7)])
    set(pr.edit_link_w, 'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(4.2) .30*w(pr.p, 'pixels')  s(1.7)])
    
    % arrows
    set(pr.label_arrow_sw, 'Position', [.35*w(pr.p, 'pixels')+s(1.7) s(8.3) .1*w(pr.p, 'pixels')  s(1.7)])
    set(pr.edit_arrow_sw, 'Position', [.5*w(pr.p, 'pixels')+s(1.7) s(8.3) .30*w(pr.p, 'pixels')  s(1.7)])
    set(pr.label_arrow_hl, 'Position', [.35*w(pr.p, 'pixels')+s(1.7) s(6.3) .1*w(pr.p, 'pixels')  s(1.7)])
    set(pr.edit_arrow_hl, 'Position', [.5*w(pr.p, 'pixels')+s(1.7) s(6.3) .30*w(pr.p, 'pixels')  s(1.7)])
    set(pr.label_arrow_hw, 'Position', [.35*w(pr.p, 'pixels')+s(1.7) s(4.3) .1*w(pr.p, 'pixels')  s(1.7)])
    set(pr.edit_arrow_hw, 'Position', [.5*w(pr.p, 'pixels')+s(1.7) s(4.3) .30*w(pr.p, 'pixels')  s(1.7)])
    set(pr.label_arrow_node, 'Position', [.35*w(pr.p, 'pixels')+s(1.7) s(2.3) .1*w(pr.p, 'pixels')  s(1.7)])
    set(pr.edit_arrow_node, 'Position', [.5*w(pr.p, 'pixels')+s(1.7) s(2.3) .30*w(pr.p, 'pixels')  s(1.7)])
    set(pr.label_arrow_n, 'Position', [.35*w(pr.p, 'pixels')+s(1.7) s(.3) .1*w(pr.p, 'pixels')  s(1.7)])
    set(pr.edit_arrow_n, 'Position', [.5*w(pr.p, 'pixels')+s(1.7) s(.3) .30*w(pr.p, 'pixels')  s(1.7)])

    % cyl
    set(pr.label_cylinder_r, 'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(8.3)  .20*w(pr.p, 'pixels')   s(1.7)])
    set(pr.edit_cylinder_r, 'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(8.3)  .20*w(pr.p, 'pixels')   s(1.7)])
    set(pr.label_cylinder_n, 'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(6.3)  .20*w(pr.p, 'pixels')   s(1.7)])
    set(pr.edit_cylinder_n, 'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(6.3)  .20*w(pr.p, 'pixels')   s(1.7)])
    
    % colorbuttons
    set(pr.button_link_color, 'Position', [s(.9)+.60*w(pr.p, 'pixels') s(10.3) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.button_arrow_color, 'Position', [s(.9)+.60*w(pr.p, 'pixels') s(10.3) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.button_cylinder_color, 'Position', [s(.9)+.60*w(pr.p, 'pixels') s(10.3) .30*w(pr.p, 'pixels') s(1.7)])
    
end
function cb_brain_edges(pr)
    %CB_AXIS executes callback for all checkboxes.
    %
    % CB_AXIS(PR) executes callback for all checkboxes.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set( ...
        'LINKS', get(pr.checkbox_link, 'Value'), ...
        'LINKLINESTYLE', get(pr.dropdown_link, 'Value'), ...
        'LINKLINEWIDTH', get(pr.edit_link_w, 'Value'), ...
        'ARROWS', get(pr.checkbox_arrow, 'Value'), ...
        'ARROWSWIDTH', get(pr.edit_arrow_sw, 'Value'), ...
        'ARROWHLENGTH', get(pr.edit_arrow_hl, 'Value'), ...
        'ARROWHWIDTH', get(pr.edit_arrow_hw, 'Value'), ...
        'ARROWHNODE', get(pr.edit_arrow_node, 'Value'), ...
        'ARROWN', get(pr.edit_arrow_n, 'Value'), ...
        'CYLINDERS', get(pr.checkbox_cylinder, 'Value'), ...
        'CYLR', get(pr.edit_cylinder_r, 'Value'), ...
        'CYLN', get(pr.edit_cylinder_n, 'Value'), ...
        'TEXTS', get(pr.checkbox_text, 'Value') ...        
        )

end
function cb_button_linkcolor(pr)
    %CB_BUTTON_LINKCOLOR executes callback for the button.
    %
    % CB_BUTTON_LINKCOLOR(PR) executes callback for the button.

    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop).get('LINKSCOLOR'));
    if ~isequal(new_color, el.get(prop).get('LINKSCOLOR'))
        el.get(prop).set('LINKSCOLOR', new_color)

        pr.update()
    end
end
function cb_button_arrowcolor(pr)
    %CB_BUTTON_ARROWCOLOR executes callback for the button.
    %
    % CB_BUTTON_ARROWCOLOR(PR) executes callback for the button.

    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop).get('ARROWCOLOR'));
    if ~isequal(new_color, el.get(prop).get('ARROWCOLOR'))
        el.get(prop).set('ARROWCOLOR', new_color)

        pr.update()
    end
end
function cb_button_cylcolor(pr)
    %CB_BUTTON_CYLCOLOR executes callback for the button.
    %
    % CB_BUTTON_CYLCOLOR(PR) executes callback for the button.

    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop).get('CYLCOLOR'));
    if ~isequal(new_color, el.get(prop).get('CYLCOLOR'))
        el.get(prop).set('CYLCOLOR', new_color)

        pr.update()
    end
end