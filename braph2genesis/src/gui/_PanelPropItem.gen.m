%% ¡header!
PanelPropItem < PanelProp (pr, panel property item) plots the panel of a property item.

%%% ¡description!
PanelPropItem plots the panel of a an ITEM property with a pushbutton that opens the linked object.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uibutton

%% ¡properties!
p
button

f_item % item figure

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the item property.
    %
    % DRAW(PR) draws the panel of the item property.
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
    
    if ~check_graphics(pr.button, 'pushbutton')
        pr.button = uibutton( ...
            'Parent', pr.p, ...
            'Tag', 'button', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'ButtonPushedFcn', {@cb_button} ...
            );
    end

    function cb_button(~, ~) % (src, event)
        pr.cb_button()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the button.
    %
    % UPDATE(PR) updates the content and permissions of the button.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.button, ...
                'Text', el.get(prop).tostring(), ...
                'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}) ...
                )
            
        case {Category.PARAMETER, Category.DATA, Category.Figure, Category.GUI}
            set(pr.button, ...
                'Text', el.get(prop).tostring(), ...
                'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}) ...
                )
            
        case Category.RESULT
            value = el.getr(prop);
            
            if isa(value, 'NoValue')
                set(pr.button, ...
                    'Text', el.getPropDefault(prop).tostring(), ...
                    'Tooltip', regexprep(el.getPropDefault(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.button, ...
                    'Text', el.get(prop).tostring(), ...
                    'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
                    'Enable', 'on' ...
                    )
            end
    end
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel. 
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
    %  - HEIGHT = 3.5 * BRAPH2.FONTSIZE * BRAPH2.S
    %
    % See also draw, update, PanelElement, BRAPH2.
    
    [h_p, varagin] = get_and_remove_from_varargin(ceil(3.5 * BRAPH2.FONTSIZE * BRAPH2.S), 'Height', varargin);

    pr.redraw@PanelProp('Height', h_p, varargin{:})

    set(pr.button, 'Position', [ ...
        ceil(5 * BRAPH2.S) ...
        ceil(.25 * BRAPH2.FONTSIZE * BRAPH2.S) ...
        ceil(w(pr.p, 'pixels') - 10) ...
        ceil(1.75 * BRAPH2.FONTSIZE * BRAPH2.S) ...
        ])
end
function cb_button(pr)
    %CB_PUSHBUTTON_VALUE executes callback for the pushbutton.
    %
    % CB_PUSHBUTTON_VALUE(PR) executes callback for the pushbutton.

    persistent time
    if isempty(time)
        time = 0;
    end
    if now - time > 0.5 / (24 * 60 * 60)
        time = now;

        set(pr.button, 'Enable', 'off')

        el = pr.get('EL');
        prop = pr.get('PROP');

        if ~check_graphics(pr.f_item, 'figure')
            f = ancestor(pr.p, 'figure');
            gui = GUIElement( ...
                'PE', el.getr(prop).get('EL'), ...
                'POSITION', [x0(f, 'normalized')+w(f, 'normalized') y0(f, 'normalized') w(f, 'normalized') h(f, 'normalized')], ...
                'CLOSEREQ', false ...
                );
            pr.f_item = gui.draw();
        else
            gui = get(pr.f_item, 'UserData');
            gui.cb_bring_to_front();
        end
        set(pr.button, 'Enable', 'on')
    end
    
    % updates and redraws the parent PanelElement as well as all siblings PanelProp's
    pe = get(get(pr.p, 'Parent'), 'UserData');
    pe.update()
    pe.redraw()
end
function cb_bring_to_front(pr)
    %CB_BRING_TO_FRONT brings to the front the item figure.
    %
    % CB_BRING_TO_FRONT(PR) brings to the front the item figure.
    %
    % See also cb_hide, cb_close.

    cb_bring_to_front@Panel(pr);
    
    % bring to front item figure
    if check_graphics(pr.f_item, 'figure')
        figure(pr.f_item)
        set(pr.f_item, ...
            'Visible', 'on', ...
            'WindowState', 'normal' ...
            )        
    end
end
function cb_hide(pr)
    %CB_HIDE hides the item figure.
    %
    % CB_HIDE(PR) hides the item figure.
    %
    % See also cb_bring_to_front, cb_close.
    
    cb_hide@Panel(pr);
    
    % hide callback element figure
    if check_graphics(pr.f_item, 'figure')
        set(pr.f_item, 'Visible', 'off')
    end
end
function cb_close(pr)
    %CB_CLOSE closes the item figure.
    % 
    % CB_CLOSE(PR) closes the item figure.
    %
    % See also cb_bring_to_front, cb_hide.
    
    cb_close@Panel(pr);

    % close callback element figure
    if check_graphics(pr.f_item, 'figure')
        close(pr.f_item)
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropItem and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure();
et = ETA();
props = [et.PROP_ITEM_M et.PROP_ITEM_P et.PROP_ITEM_D  et.PROP_ITEM_F et.PROP_ITEM_G et.PROP_ITEM_R et.PROP_ITEM_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropItem('EL', et, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
end
close(fig1)