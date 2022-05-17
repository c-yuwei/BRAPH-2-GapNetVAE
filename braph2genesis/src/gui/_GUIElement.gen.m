%% ¡header!
GUIElement < GUI (gui, element gui) is a GUI for an element.

%%% ¡description!
% % % GUI plots an element in a figure.
% % % 
% % % CONSTRUCTOR - To construct a GUI use the constructor:
% % % 
% % %     gui = GUI(''PE'', <element>)
% % %     
% % % DRAW - To create the element figure, call gui.draw():
% % % 
% % %     f = gui.<strong>draw</strong>();
% % %  
% % %  Here, f is the figure.
% % %  It is also possible to use pr.draw() to get the figure handle and to set its properties.
% % %   
% % % CALLBACK - This is a callback function:
% % % 
% % %     gui.<strong>cb_bring_to_front</strong>() - brings to the front the figure and its dependent figures
% % %     gui.<strong>cb_hide</strong>() - hides the figure and its dependent figures
% % %     gui.<strong>cb_close</strong>() - closes the figure and its dependent figures

%%% ¡seealso!
GUI, Element, PanelElement, uifigure

%% ¡props!

%%% ¡prop!
PE (metadata, item) is the plot element.
%%%% ¡settings!
'PanelElement'
%%%% ¡conditioning!
if ~isa(value, 'PanelElement')
    value = PanelElement('EL', value, 'ID', ['Plot of ' value.tostring()]);
end

%%% ¡prop!
FILE (data, string) is the B2 file where the element is saved.

%%% ¡prop!
MENU_FILE (gui, logical) determines whether to show the menu file.
%%%% ¡default!
true

%%% ¡prop!
MENU_IMPORT (gui, logical) determines whether to show the menu import.
%%%% ¡default!
true

%%% ¡prop!
MENU_EXPORT (gui, logical) determines whether to show the menu export.
%%%% ¡default!
true

%%% ¡prop!
MENU_PERSONALIZE (gui, logical) determines whether to show the menu personalize.
%%%% ¡default!
true

%%% ¡prop!
MENU_ABOUT (gui, logical) determines whether to show the menu about.
%%%% ¡default!
true

%%% ¡prop!
TOOL_FIG (gui, logical) determines whether to show the toolbar figure buttons.
%%%% ¡default!
false

%%% ¡prop!
TOOL_FILE (gui, logical) determines whether to show the toolbar file buttons.
%%%% ¡default!
true

%%% ¡prop!
TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons.
%%%% ¡default!
true

%% ¡props_update!

%%% ¡prop!
MENUBAR (gui, logical) determines whether to show the menubar.
%%%% ¡default!
true

%%% ¡prop!
TOOLBAR (gui, logical) determines whether to show the toolbar.
%%%% ¡default!
true

%% ¡properties!
f % handle for figure 

menu_file
menu_import
menu_export
menu_personalize
menu_about

toolbar

pp % handle for parent panel of the element panel
p % panel element

text_filename % handle for text field filename

f_layout % handle to figure with panel to manage layout

%% ¡methods!
function f_out = draw(gui, varargin)
% % %     %GUI creates and displays the GUI figure for an element.
% % %     %
% % %     % GUI() creates and displays the GUI figure for an element.
% % %     %
% % %     % F = DRAW(GUI) returns a handle to the GUI figure.
% % %     %
% % %     % DRAW(GUI, 'Property', VALUE, ...) sets the properties of the parent
% % %     %  panel with custom Name-Value pairs.
% % %     %  All standard plot properties of figure can be used.
% % %     %
% % %     % It is possible to access the properties of the various graphical
% % %     %  objects from the handle F of the GUI figure.
% % %     %
% % %     % The GUI, PanelElement and Element can be retrieved as 
% % %     %  GUI = get(F, 'UserData')
% % %     %  PE = GUI.get('PE')
% % %     %  EL = PE.get('EL')
% % %     %
% % %     % See also cb_bring_to_front, figure.

    gui.f = draw@GUI(gui, 'Draw', false, varargin{:});
        
    pe = gui.get('PE');
    el = pe.get('EL');
    
    % Set GUI name
    if el.existsTag('ID')
        name = el.get('ID');
    else
        name = el.tostring();
    end
    gui.set('NAME', [el.getClass() ' - ' name ' - ' BRAPH2.STR])

    % Menu
    if gui.get('MENUBAR') && gui.get('MENU_FILE') && check_graphics(gui.f, 'figure') && ~check_graphics(gui.menu_file, 'uimenu')
        gui.menu_file = uimenu(gui.f, 'Label', 'File');

        uimenu(gui.menu_file, ...
            'Label', 'Open ...', ...
            'Accelerator', 'O', ...
            'Callback', {@cb_open})
        uimenu(gui.menu_file, ...
            'Label', 'Save', ...
            'Accelerator', 'S', ...
            'Callback', {@cb_save})
        uimenu(gui.menu_file, ...
            'Label', 'Save as ...', ...
            'Accelerator', 'A', ...
            'Callback', {@cb_saveas})
        uimenu(gui.menu_file, ...
            'Separator', 'on', ...
            'Label', 'Close', ...
            'Accelerator', 'C', ...
            'Callback', {@cb_close})
    elseif (~gui.get('MENUBAR') || ~gui.get('MENU_FILE'))
        delete(gui.menu_file)
    end
    function cb_open(~, ~)
        % select file
        [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.getName() ' file.']);
        if filterindex
            filename = fullfile(path, file);
            tmp_el = BRAPH2.load(filename);
            if strcmp(tmp_el.getClass(), el.getClass())
                pe.reinit(tmp_el)
                el = tmp_el; % update local variable 'el' to synchronize it with pe 'el'  
                gui.draw()
            else
                GUIElement('PE', tmp_el, 'FILE', filename).draw()
            end
        end
    end
    function cb_save(~, ~)
        filename = gui.get('FILE');
        if isfile(filename)
            BRAPH2.save(el, filename)
        else
            cb_saveas();
        end
    end
    function cb_saveas(~, ~)
        % select file
        [file, path, filterindex] = uiputfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.getName() ' file.']);
        % save file
        if filterindex
            filename = fullfile(path, file);
            BRAPH2.save(el, filename)
            gui.set('FILE', filename)
            update_filename();
        end
    end
    function cb_close(~, ~)
        gui.cb_close()
    end
    
    if gui.get('MENUBAR') && gui.get('MENU_IMPORT') && check_graphics(gui.f, 'figure') && ~check_graphics(gui.menu_import, 'uimenu')
        gui.menu_import = uimenu(gui.f, ...
            'Label', 'Import', ...
            'Callback', {@cb_refresh_import_menu});
    elseif (~gui.get('MENUBAR') || ~gui.get('MENU_IMPORT'))
        delete(gui.menu_import)
    end
    function cb_refresh_import_menu(~,~)
disp('refresh import')
    % % % % % % % %         im_menus = get(gui.menu_import, 'Children');
    % % % % % % % %         for i = 1:1:length(im_menus)
    % % % % % % % %             delete(im_menus(i));
    % % % % % % % %         end
    % % % % % % % %         eval([el.getClass() '.getGUIMenuImport(el, gui.menu_import, pe)']);
    % % % % % % % %         el = pe.get('el');
    end    

    if gui.get('MENUBAR') && gui.get('MENU_EXPORT') && check_graphics(gui.f, 'figure') && ~check_graphics(gui.menu_export, 'uimenu')
        gui.menu_export = uimenu(gui.f, ...
            'Label', 'Export', ...
            'Callback', {@cb_refresh_export_menu});
    elseif (~gui.get('MENUBAR') || ~gui.get('MENU_EXPORT'))
        delete(gui.menu_export)
    end
    function cb_refresh_export_menu(~,~)
disp('refresh export')        
    % % % % % % % %         el = pe.get('el');
    % % % % % % % %         ex_menus = get(gui.menu_export, 'Children');
    % % % % % % % %         for i = 1:length(ex_menus)
    % % % % % % % %             delete(ex_menus(i));
    % % % % % % % %         end
    % % % % % % % %         eval([el.getClass() '.getGUIMenuExport(el, gui.menu_export, pe)']);
     end

    if gui.get('MENUBAR') && gui.get('MENU_PERSONALIZE') && check_graphics(gui.f, 'figure') && ~check_graphics(gui.menu_personalize, 'uimenu')
        gui.menu_personalize = uimenu(gui.f, 'Label', 'Personalize');
        uimenu(gui.menu_personalize, ...
            'Label', 'Layout ...', ...
            'Callback', {@cb_layout});
    elseif (~gui.get('MENUBAR') || ~gui.get('MENU_PERSONALIZE'))
        delete(gui.menu_personalize)
    end
    function cb_layout(~, ~)
disp('layout')        
    % % % % % % % %         if isgraphics(gui.f_layout, 'figure')
    % % % % % % % %             delete(gui.f_layout)
    % % % % % % % %         end
    % % % % % % % %         
    % % % % % % % %         gui.f_layout = figure( ...
    % % % % % % % %             'Visible', 'off', ...
    % % % % % % % %             'NumberTitle', 'off', ...
    % % % % % % % %             'Name', ['Layout ' el.getClass() ' - ' BRAPH2.STR], ...
    % % % % % % % %             'Units', get(gui.f, 'Units'), ...
    % % % % % % % %             'Position', [Plot.x0(gui.f)+Plot.w(gui.f) Plot.y0(gui.f)+Plot.h(gui.f)*2/3 Plot.w(gui.f) Plot.h(gui.f)/3], ...
    % % % % % % % %             'Units', 'character', ...
    % % % % % % % %             'MenuBar', 'none', ...
    % % % % % % % %             'DockControls', 'off', ...
    % % % % % % % %             'Color', pe.get('BKGCOLOR') ...
    % % % % % % % %             );
    % % % % % % % %         set_braph2icon(gui.f_layout);
    % % % % % % % % 
    % % % % % % % %         edit_table = uitable('Parent', gui.f_layout, ...
    % % % % % % % %             'Units', 'normalized', ...
    % % % % % % % %             'Position', [.02 .2 .9 .7], ...
    % % % % % % % %             'ColumnName', {'Show', 'Order', 'Title', 'Property', 'Category', 'Format'}, ...
    % % % % % % % %             'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
    % % % % % % % %             'ColumnEditable', [true true true false false false], ...
    % % % % % % % %             'CellEditCallback', {@cb_edit_tb} ...
    % % % % % % % %             );
    % % % % % % % %         save_edit_btn = uicontrol('Parent', gui.f_layout, ...
    % % % % % % % %             'Units', 'normalized', ...
    % % % % % % % %             'Position', [.49 .02 .24 .1], ...
    % % % % % % % %             'String', 'Save', ...
    % % % % % % % %             'Callback', {@cb_save_edit} ...
    % % % % % % % %             );
    % % % % % % % %         cancel_edit_btn =  uicontrol('Parent', gui.f_layout, ...
    % % % % % % % %             'Units', 'normalized', ...
    % % % % % % % %             'Position', [.74 .02 .24 .1], ...
    % % % % % % % %             'String', 'Cancel', ...
    % % % % % % % %             'Callback', {@cb_cancel_edit} ...
    % % % % % % % %             );
    % % % % % % % % 
    % % % % % % % %         [order, title, visible] = load_layout(el);
    % % % % % % % %         VISIBLE = 1;
    % % % % % % % %         ORDER = 2;
    % % % % % % % %         TITLE = 3;
    % % % % % % % %         TAG = 4;
    % % % % % % % %         CATEGORY = 5;
    % % % % % % % %         FORMAT = 6;
    % % % % % % % %         data = cell(el.getPropNumber(), 6);
    % % % % % % % %         for prop = 1:1:el.getPropNumber()
    % % % % % % % %             data{prop, VISIBLE} = visible(prop);
    % % % % % % % %             data{prop, ORDER} = order(prop);
    % % % % % % % %             data{prop, TITLE} = title{prop};
    % % % % % % % %             data{prop, TAG} = upper(el.getPropTag(prop));
    % % % % % % % %             data{prop, CATEGORY} = el.getPropCategory(prop);
    % % % % % % % %             data{prop, FORMAT} = el.getPropFormat(prop);
    % % % % % % % %         end        
    % % % % % % % %         set(edit_table, 'Data', data);
    % % % % % % % % 
    % % % % % % % %         set(gui.f_layout, 'Visible', 'on');
    % % % % % % % %         
    % % % % % % % %         function cb_edit_tb(~, event)
    % % % % % % % %             prop = event.Indices(1);
    % % % % % % % %             col = event.Indices(2);
    % % % % % % % %             newdata = event.NewData;
    % % % % % % % %             data = get(edit_table, 'Data');
    % % % % % % % % 
    % % % % % % % %             if col == VISIBLE
    % % % % % % % %                 if newdata == true
    % % % % % % % %                     if any(~isnan(cell2mat(data(:, ORDER))))
    % % % % % % % %                         data{prop, ORDER} = max(cell2mat(data(:, ORDER))) + 1;
    % % % % % % % %                     else % all NaN (edge case)
    % % % % % % % %                         data{prop, ORDER} = 1;
    % % % % % % % %                     end
    % % % % % % % %                 else % newdata == false
    % % % % % % % %                     for i = data{prop, ORDER} + 1:1:max(cell2mat(data(:, ORDER)))
    % % % % % % % %                         data{cell2mat(data(:, ORDER)) == i, ORDER} = i - 1;
    % % % % % % % %                     end
    % % % % % % % %                     data{prop, ORDER} = NaN;
    % % % % % % % %                 end
    % % % % % % % %             end
    % % % % % % % % 
    % % % % % % % %             if col == ORDER
    % % % % % % % %                 if isnan(newdata)
    % % % % % % % %                     data{prop, VISIBLE} = false;
    % % % % % % % %                 else
    % % % % % % % %                     data{prop, VISIBLE} = true;
    % % % % % % % %                 end
    % % % % % % % %                 
    % % % % % % % %                 order = cell2mat(data(:, ORDER)) + .00301040106;
    % % % % % % % %                 order(prop) = newdata;
    % % % % % % % %                 for i = 1:1:numel(order) - sum(isnan(order))
    % % % % % % % %                     min_order_index = find(order == min(order));
    % % % % % % % %                     data{min_order_index, ORDER} = i;
    % % % % % % % %                     order(min_order_index) = NaN;
    % % % % % % % %                 end
    % % % % % % % %             end
    % % % % % % % % 
    % % % % % % % %             set(edit_table, 'Data', data);
    % % % % % % % %         end
    % % % % % % % %         function cb_save_edit(~, ~)
    % % % % % % % %             data = get(edit_table, 'Data');
    % % % % % % % %             order = cell2mat(data(:, 2))';
    % % % % % % % %             title = data(:, 3); title = title';
    % % % % % % % %             save_layout(el, order, title)
    % % % % % % % % 
    % % % % % % % %             pe.reinit(el);
    % % % % % % % %             gui.draw()
    % % % % % % % %         end
    % % % % % % % %         function cb_cancel_edit(~, ~)
    % % % % % % % %             close(gui.f_layout)
    % % % % % % % %         end
    end

    if gui.get('MENUBAR') && gui.get('MENU_ABOUT') && check_graphics(gui.f, 'figure') && ~check_graphics(gui.menu_about, 'uimenu') 
        gui.menu_about = BRAPH2.add_menu_about(gui.f);
    elseif (~gui.get('MENUBAR') || ~gui.get('MENU_ABOUT'))
        delete(gui.menu_about)
    end

% % % % %     % Toolbar
% % % % % % % %     if gui.get('TOOLBAR') && ~check_graphics(gui.toolbar, 'uitoolbar')
% % % % % % % %         set(gui.f, 'Toolbar', 'figure')
% % % % % % % % 
% % % % % % % %         gui.toolbar = findall(gui.f, 'Tag', 'FigureToolBar');
% % % % % % % % 
% % % % % % % %         delete(findall(gui.toolbar, 'Tag', 'Standard.NewFigure'))
% % % % % % % %         
% % % % % % % %         if ~gui.get('TOOL_FIG')
% % % % % % % %             delete(findall(gui.toolbar, 'Tag', 'Standard.PrintFigure'))
% % % % % % % %             delete(findall(gui.toolbar, 'Tag', 'Standard.EditPlot'))
% % % % % % % %             delete(findall(gui.toolbar, 'Tag', 'Standard.OpenInspector'))
% % % % % % % %             delete(findall(gui.toolbar, 'Tag', 'Exploration.Brushing'))
% % % % % % % %             delete(findall(gui.toolbar, 'Tag', 'DataManager.Linking'))
% % % % % % % %             delete(findall(gui.toolbar, 'Tag', 'Annotation.InsertColorbar'))
% % % % % % % %             delete(findall(gui.toolbar, 'Tag', 'Annotation.InsertLegend'))
% % % % % % % %             delete(findall(gui.toolbar, 'Tag', 'Plottools.PlottoolsOff'))
% % % % % % % %             delete(findall(gui.toolbar, 'Tag', 'Plottools.PlottoolsOn'))
% % % % % % % %         else
% % % % % % % %             toolbar_print = findall(gui.toolbar, 'Tag', 'Standard.PrintFigure');
% % % % % % % %             set(toolbar_print, ...
% % % % % % % %                 'Separator', 'on' ...
% % % % % % % %                 )
% % % % % % % %         end
% % % % % % % % 
% % % % % % % %         if gui.get('TOOL_FILE')
% % % % % % % %             % Open
% % % % % % % %             toolbar_open = findall(gui.toolbar, 'Tag', 'Standard.FileOpen');
% % % % % % % %             set(toolbar_open, ...
% % % % % % % %                 'Tag', 'BRAPH2.FileOpen', ...
% % % % % % % %                 'TooltipString', ['Open ' el.getName()], ...
% % % % % % % %                 'ClickedCallback', {@cb_open})
% % % % % % % %             % Save
% % % % % % % %             toolbar_save = findall(gui.toolbar, 'Tag', 'Standard.SaveFigure');
% % % % % % % %             set(toolbar_save, ...
% % % % % % % %                 'Tag', 'BRAPH2.SaveFigure', ...
% % % % % % % %                 'TooltipString', ['Save ' el.getName()], ...
% % % % % % % %                 'ClickedCallback', {@cb_save})
% % % % % % % %         else
% % % % % % % %             toolbar_open = findall(gui.toolbar, 'Tag', 'Standard.FileOpen');
% % % % % % % %             delete(findall(gui.toolbar, 'Tag', 'Standard.SaveFigure'))
% % % % % % % %         end
% % % % % % % %         
% % % % % % % %         if gui.get('TOOL_ABOUT')
% % % % % % % % % % %             uipushtool(gui.toolbar, 'Separator', 'on', 'Visible', 'off')
% % % % % % % % % % %             uipushtool(gui.toolbar, 'Separator', 'on', 'Visible', 'off')
% % % % % % % % % % % 
% % % % % % % % % % %             % Website
% % % % % % % % % % %             toolbar_web = uipushtool(gui.toolbar, ...
% % % % % % % % % % %                 'Separator', 'on', ...
% % % % % % % % % % %                 'TooltipString', 'Link to braph.org', ...
% % % % % % % % % % %                 'CData', imresize(imread('icon_web.png'), [24 24]), ...
% % % % % % % % % % %                 'ClickedCallback', {@cb_web});
% % % % % % % % % % % 
% % % % % % % % % % %             % Forum
% % % % % % % % % % %             toolbar_web = uipushtool(gui.toolbar, ...
% % % % % % % % % % %                 'Separator', 'off', ...
% % % % % % % % % % %                 'TooltipString', 'Link to the BRAPH 2.0 forum', ...
% % % % % % % % % % %                 'CData', imresize(imread('icon_forum.png'), [24 24]), ...
% % % % % % % % % % %                 'ClickedCallback', {@cb_forum});
% % % % % % % % % % % 
% % % % % % % % % % %             % Twitter
% % % % % % % % % % %             toolbar_web = uipushtool(gui.toolbar, ...
% % % % % % % % % % %                 'Separator', 'off', ...
% % % % % % % % % % %                 'TooltipString', 'Link to the BRAPH 2.0 Twitter', ...
% % % % % % % % % % %                 'CData', imresize(imread('icon_twitter.png'), [24 24]), ...
% % % % % % % % % % %                 'ClickedCallback', {@cb_twitter});
% % % % % % % % % % % 
% % % % % % % % % % %             uipushtool(gui.toolbar, 'Separator', 'on', 'Visible', 'off')
% % % % % % % % % % %             uipushtool(gui.toolbar, 'Separator', 'on', 'Visible', 'off')
% % % % % % % % % % % 
% % % % % % % % % % %             % License
% % % % % % % % % % %             toolbar_web = uipushtool(gui.toolbar, ...
% % % % % % % % % % %                 'Separator', 'on', ...
% % % % % % % % % % %                 'TooltipString', 'BRAPH 2.0 License', ...
% % % % % % % % % % %                 'CData', imresize(imread('icon_license.png'), [24 24]), ...
% % % % % % % % % % %                 'ClickedCallback', {@cb_license});
% % % % % % % % % % % 
% % % % % % % % % % %             % About
% % % % % % % % % % %             toolbar_web = uipushtool(gui.toolbar, ...
% % % % % % % % % % %                 'Separator', 'off', ...
% % % % % % % % % % %                 'TooltipString', 'Informtion about BRAPH 2.0 and credits', ...
% % % % % % % % % % %                 'CData', imresize(imread('icon_about.png'), [24 24]), ...
% % % % % % % % % % %                 'ClickedCallback', {@cb_about});
% % % % % % % %             BRAPH2.add_tool_about(gui.toolbar)
% % % % % % % %         end
% % % % % % % %     end

    % Draw text filename
    if ~check_graphics(gui.text_filename, 'uilabel')
        gui.text_filename = uilabel( ...
            'Parent', gui.f, ...
            'Tag', 'text_filename', ...
            'Text', gui.get('FILE'), ...
            'Tooltip', gui.get('FILE'), ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'left' ...
            );
    end
    function update_filename()
        set(gui.text_filename, ...
            'Text', gui.get('FILE'), ...
            'Tooltip', gui.get('FILE') ...
            )
    end

    % Draw panel element (p) contained in a parent panel (pp)
    if ~check_graphics(gui.pp, 'uipanel')
        gui.pp = uipanel( ...
            'Parent', gui.f, ...
            'Tag', 'pp', ...
            'BorderType', 'none', ...
            'Scrollable', 'on', ...
            'AutoResizeChildren', 'off' ...
            );
    end
    gui.p = pe.draw('Parent', gui.pp);

    % Callback on resize
    set(gui.f, 'SizeChangedFcn', {@cb_resize});
    function cb_resize(~, ~) % (src, event)
        h_filename = ceil(1.5 * BRAPH2.FONTSIZE * BRAPH2.S);
        set(gui.text_filename, ...
            'Position', [0 0 w(gui.f, 'pixels') h_filename] ...
            )
        set(gui.pp, ...
            'Units', 'pixels', ...
            'Position', [0 h_filename w(gui.f, 'pixels') h(gui.f, 'pixels')-h_filename] ...
            );
        pe.redraw( ... 
            'X0', 0, ...
            'Y0', 0, ...
            'Width', w(gui.pp, 'pixels'), ...
            'Height', h(gui.pp, 'pixels') ...
            )
    end
    cb_resize()

    % show figure
    drawnow()
    set(gui.f, 'Visible', 'on')
    
    % output
    if nargout > 0
        f_out = gui.f;
    end
end
% % % function cb_bring_to_front(gui)
% % %     %CB_BRING_TO_FRONT brings to front the figure and its dependent figures.
% % %     %
% % %     % CB_BRING_TO_FRONT(GUI) brings to front the figure and its dependent figures 
% % %     %  by calling the methods cb_bring_to_front() for all the PlotProp
% % %     %  panels of the PanelElement. 
% % %     %  
% % %     % Note that it will draw anew the figure if it has been closed.
% % %     %
% % %     % See also cb_hide, cb_close.
% % % 
% % %     % brings to front the main GUI
% % %     if check_graphics(gui.f, 'figure')
% % %         figure(gui.f) 
% % %         set(gui.f, ...
% % %             'Visible', 'on', ...
% % %             'WindowState', 'normal' ...
% % %             )
% % %     end
% % %     
% % %     % brings to front the other panels
% % %     pe = gui.get('PE');
% % %     pr_dict = pe.get('PR_DICT');
% % %     for prop = 1:1:pr_dict.length()
% % %         pr = pr_dict.getItem(prop);
% % %         pr.cb_bring_to_front()
% % %     end
% % % end
% % % function cb_hide(gui)
% % %     %CB_HIDE hides the figure and its dependent figures.
% % %     %
% % %     % CB_HIDE(GUI) hides the figure and its dependent figures 
% % %     %  by calling the methods cb_hide() for all the PlotProp
% % %     %  panels of the PanelElement. 
% % %     %
% % %     % See also cb_bring_to_front, cb_close.
% % % 
% % %     % hides the main GUI
% % %     if check_graphics(gui.f, 'figure')
% % %         figure(gui.f)
% % %     end
% % %     
% % %     % hides the other panels
% % %     pe = gui.get('PE');
% % %     pr_dict = pe.get('PR_DICT');
% % %     for prop = 1:1:pr_dict.length()
% % %         pr = pr_dict.getItem(prop);
% % %         pr.cb_hide()
% % %     end
% % % end
% % % function cb_close(gui)
% % %     %CB_CLOSE closes the figure and its dependent figures.
% % %     %
% % %     % CB_CLOSE(GUI) closes the figure and its dependent figures 
% % %     %  by calling the methods cb_close() for all the PlotProp
% % %     %  panels of the PanelElement. 
% % %     %  
% % %     % See also cb_bring_to_front, cb_hide.
% % % 
% % %     % determines GUI name
% % %     name = gui.get('NAME');
% % %     if isempty(name)
% % %         pe = gui.get('pe');
% % %         el = pe.get('el');
% % %         if el.existsTag('ID')
% % %             name = el.get('ID');
% % %         else
% % %             name = el.tostring();
% % %         end
% % %     end
% % %     
% % %     % closes the main GUI
% % %     if check_graphics(gui.f, 'figure')
% % %         if gui.get('CLOSEREQ')
% % %             DefaultUicontrolBackgroundColor_BAK = get(0, 'DefaultUicontrolBackgroundColor');
% % %             set(0, 'DefaultUicontrolBackgroundColor', BRAPH2.COL_FIG)
% % %             selection = questdlg(['Do you want to close ' name '?'], ...
% % %                 ['Close ' name], ...
% % %                 'Yes', 'No', 'Yes');
% % %             set(0, 'DefaultUicontrolBackgroundColor', DefaultUicontrolBackgroundColor_BAK)
% % %         else
% % %             selection = 'Yes';
% % %         end
% % %         switch selection
% % %             case 'Yes'
% % %                 delete(gui.f)
% % %                 if check_graphics(gui.f_layout, 'figure')
% % %                     close(gui.f_layout)
% % %                 end
% % %             case 'No'
% % %                 return
% % %         end
% % %     end
% % %     
% % %     % closes the other panels
% % %     pe = gui.get('PE');
% % %     pr_dict = pe.get('PR_DICT');
% % %     for prop = 1:1:pr_dict.length()
% % %         pr = pr_dict.getItem(prop);
% % %         pr.cb_close()
% % %     end
% % % end

%% ¡tests!

%%% ¡test! 
%%%% ¡name!
Basic use
%%%% ¡code!
et1 = ETA();
gui1 = GUIElement('PE', et1, 'MENUBAR', true, 'TOOLBAR', true);
f1a = gui.draw();
f1b = gui.draw();
close(f1b)

b2 = BRAPH2Constants();
gui2 = GUIElement('PE', b2, 'MENUBAR', true, 'TOOLBAR', true);
f2 = gui.draw();
close(f2)