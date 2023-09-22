classdef ComparisonGroupPF_NxPP_Node < PanelProp
	%ComparisonGroupPF_NxPP_Node plots the panel to select a node.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% ComparisonGroupPF_NxPP_Node plots the panel to select a node from a drop-down list.
	% It is supposed to be used with the property NODE of ComparisonGroupPF_NU, ComparisonGroupPF_NS, or ComparisonGroupPF_NB.
	%
	% The list of ComparisonGroupPF_NxPP_Node properties is:
	%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel property node.
	%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel property node.
	%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel property node.
	%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel property node.
	%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel property node.
	%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel property node.
	%  <strong>7</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
	%  <strong>8</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>9</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>10</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
	%  <strong>11</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>12</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>13</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>14</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>15</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.
	%  <strong>16</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.
	%  <strong>17</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
	%  <strong>18</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.
	%  <strong>19</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
	%  <strong>20</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the editfield.
	%  <strong>21</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
	%  <strong>22</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>23</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
	%  <strong>24</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the property panel.
	%  <strong>25</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the property title.
	%  <strong>26</strong> <strong>LABEL_TITLE</strong> 	LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
	%  <strong>27</strong> <strong>BUTTON_CB</strong> 	BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
	%  <strong>28</strong> <strong>GUI_CB</strong> 	GUI_CB (data, item) is the handle to the item figure.
	%  <strong>29</strong> <strong>LISTENER_CB</strong> 	LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
	%  <strong>30</strong> <strong>BUTTON_CALC</strong> 	BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
	%  <strong>31</strong> <strong>BUTTON_DEL</strong> 	BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
	%  <strong>32</strong> <strong>LISTENER_SET</strong> 	LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
	%  <strong>33</strong> <strong>LISTENER_MEMORIZED</strong> 	LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
	%  <strong>34</strong> <strong>LISTENER_LOCKED</strong> 	LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
	%  <strong>35</strong> <strong>DROPDOWN</strong> 	DROPDOWN (evanescent, handle) is the dropdown for the node.
	%
	% ComparisonGroupPF_NxPP_Node methods (constructor):
	%  ComparisonGroupPF_NxPP_Node - constructor
	%
	% ComparisonGroupPF_NxPP_Node methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% ComparisonGroupPF_NxPP_Node methods (display):
	%  tostring - string with information about the panel property node
	%  disp - displays information about the panel property node
	%  tree - displays the tree of the panel property node
	%
	% ComparisonGroupPF_NxPP_Node methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel property node are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel property node
	%
	% ComparisonGroupPF_NxPP_Node methods (save/load, Static):
	%  save - saves BRAPH2 panel property node as b2 file
	%  load - loads a BRAPH2 panel property node from a b2 file
	%
	% ComparisonGroupPF_NxPP_Node method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel property node
	%
	% ComparisonGroupPF_NxPP_Node method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel property node
	%
	% ComparisonGroupPF_NxPP_Node methods (inspection, Static):
	%  getClass - returns the class of the panel property node
	%  getSubclasses - returns all subclasses of ComparisonGroupPF_NxPP_Node
	%  getProps - returns the property list of the panel property node
	%  getPropNumber - returns the property number of the panel property node
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% ComparisonGroupPF_NxPP_Node methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonGroupPF_NxPP_Node methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonGroupPF_NxPP_Node methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonGroupPF_NxPP_Node methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonGroupPF_NxPP_Node; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonGroupPF_NxPP_Node constants</a>.
	%
	%
	% See also uidropdown, GUI, ComparisonGroupPF_NU, ComparisonGroupPF_NS, ComparisonGroupPF_NB.
	
	properties (Constant) % properties
		DROPDOWN = 35; %CET: Computational Efficiency Trick
		DROPDOWN_TAG = 'DROPDOWN';
		DROPDOWN_CATEGORY = 7;
		DROPDOWN_FORMAT = 18;
	end
	methods % constructor
		function pr = ComparisonGroupPF_NxPP_Node(varargin)
			%ComparisonGroupPF_NxPP_Node() creates a panel property node.
			%
			% ComparisonGroupPF_NxPP_Node(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonGroupPF_NxPP_Node(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ComparisonGroupPF_NxPP_Node properties is:
			%  <strong>1</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel property node.
			%  <strong>2</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel property node.
			%  <strong>3</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel property node.
			%  <strong>4</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel property node.
			%  <strong>5</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel property node.
			%  <strong>6</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel property node.
			%  <strong>7</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
			%  <strong>8</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>9</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>10</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
			%  <strong>11</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>12</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>13</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>14</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>15</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.
			%  <strong>16</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.
			%  <strong>17</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
			%  <strong>18</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.
			%  <strong>19</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
			%  <strong>20</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the editfield.
			%  <strong>21</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
			%  <strong>22</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>23</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
			%  <strong>24</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the property panel.
			%  <strong>25</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the property title.
			%  <strong>26</strong> <strong>LABEL_TITLE</strong> 	LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
			%  <strong>27</strong> <strong>BUTTON_CB</strong> 	BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
			%  <strong>28</strong> <strong>GUI_CB</strong> 	GUI_CB (data, item) is the handle to the item figure.
			%  <strong>29</strong> <strong>LISTENER_CB</strong> 	LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
			%  <strong>30</strong> <strong>BUTTON_CALC</strong> 	BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
			%  <strong>31</strong> <strong>BUTTON_DEL</strong> 	BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
			%  <strong>32</strong> <strong>LISTENER_SET</strong> 	LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
			%  <strong>33</strong> <strong>LISTENER_MEMORIZED</strong> 	LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
			%  <strong>34</strong> <strong>LISTENER_LOCKED</strong> 	LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
			%  <strong>35</strong> <strong>DROPDOWN</strong> 	DROPDOWN (evanescent, handle) is the dropdown for the node.
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the panel property node.
			%
			% CLASS = ComparisonGroupPF_NxPP_Node.GETCLASS() returns the class 'ComparisonGroupPF_NxPP_Node'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the panel property node PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('ComparisonGroupPF_NxPP_Node') returns 'ComparisonGroupPF_NxPP_Node'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			
			pr_class = 'ComparisonGroupPF_NxPP_Node';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel property node.
			%
			% LIST = ComparisonGroupPF_NxPP_Node.GETSUBCLASSES() returns all subclasses of 'ComparisonGroupPF_NxPP_Node'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the panel property node PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('ComparisonGroupPF_NxPP_Node') returns all subclasses of 'ComparisonGroupPF_NxPP_Node'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ComparisonGroupPF_NxPP_Node' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel property node.
			%
			% PROPS = ComparisonGroupPF_NxPP_Node.GETPROPS() returns the property list of panel property node
			%  as a row vector.
			%
			% PROPS = ComparisonGroupPF_NxPP_Node.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the panel property node PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('ComparisonGroupPF_NxPP_Node'[, CATEGORY]) returns the property list of 'ComparisonGroupPF_NxPP_Node'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2];
				case 2 % Category.METADATA
					prop_list = [5 6];
				case 3 % Category.PARAMETER
					prop_list = 3;
				case 4 % Category.DATA
					prop_list = [4 22 23 28];
				case 6 % Category.QUERY
					prop_list = [7 10 11 15 16 17 18 19 20 21];
				case 7 % Category.EVANESCENT
					prop_list = [9 14 26 27 29 30 31 32 33 34 35];
				case 8 % Category.FIGURE
					prop_list = 13;
				case 9 % Category.GUI
					prop_list = [8 12 24 25];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel property node.
			%
			% N = ComparisonGroupPF_NxPP_Node.GETPROPNUMBER() returns the property number of panel property node.
			%
			% N = ComparisonGroupPF_NxPP_Node.GETPROPNUMBER(CATEGORY) returns the property number of panel property node
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the panel property node PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('ComparisonGroupPF_NxPP_Node') returns the property number of 'ComparisonGroupPF_NxPP_Node'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 35;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 2;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 10;
				case 7 % Category.EVANESCENT
					prop_number = 11;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 4;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel property node/error.
			%
			% CHECK = ComparisonGroupPF_NxPP_Node.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(ComparisonGroupPF_NxPP_Node, PROP) checks whether PROP exists for ComparisonGroupPF_NxPP_Node.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%  Element.EXISTSPROP(ComparisonGroupPF_NxPP_Node, PROP) throws error if PROP does NOT exist for ComparisonGroupPF_NxPP_Node.
			%   Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 35 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ComparisonGroupPF_NxPP_Node:' 'WrongInput'], ...
					['BRAPH2' ':ComparisonGroupPF_NxPP_Node:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonGroupPF_NxPP_Node.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel property node/error.
			%
			% CHECK = ComparisonGroupPF_NxPP_Node.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(ComparisonGroupPF_NxPP_Node, TAG) checks whether TAG exists for ComparisonGroupPF_NxPP_Node.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%  Element.EXISTSTAG(ComparisonGroupPF_NxPP_Node, TAG) throws error if TAG does NOT exist for ComparisonGroupPF_NxPP_Node.
			%   Error id: [BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'DROPDOWN' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ComparisonGroupPF_NxPP_Node:' 'WrongInput'], ...
					['BRAPH2' ':ComparisonGroupPF_NxPP_Node:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonGroupPF_NxPP_Node.'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = PR.GETPROPPROP(POINTER) returns property number of POINTER of PR.
			%  PROPERTY = Element.GETPROPPROP(ComparisonGroupPF_NxPP_Node, POINTER) returns property number of POINTER of ComparisonGroupPF_NxPP_Node.
			%  PROPERTY = PR.GETPROPPROP(ComparisonGroupPF_NxPP_Node, POINTER) returns property number of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'DROPDOWN' })); % tag = pointer %CET: Computational Efficiency Trick
			else % numeric
				prop = pointer;
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = PR.GETPROPTAG(POINTER) returns tag of POINTER of PR.
			%  TAG = Element.GETPROPTAG(ComparisonGroupPF_NxPP_Node, POINTER) returns tag of POINTER of ComparisonGroupPF_NxPP_Node.
			%  TAG = PR.GETPROPTAG(ComparisonGroupPF_NxPP_Node, POINTER) returns tag of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				comparisongrouppf_nxpp_node_tag_list = { 'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'DROPDOWN' };
				tag = comparisongrouppf_nxpp_node_tag_list{pointer}; % prop = pointer
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonGroupPF_NxPP_Node, POINTER) returns category of POINTER of ComparisonGroupPF_NxPP_Node.
			%  CATEGORY = PR.GETPROPCATEGORY(ComparisonGroupPF_NxPP_Node, POINTER) returns category of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			comparisongrouppf_nxpp_node_category_list = { 1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  7 };
			prop_category = comparisongrouppf_nxpp_node_category_list{prop};
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(ComparisonGroupPF_NxPP_Node, POINTER) returns format of POINTER of ComparisonGroupPF_NxPP_Node.
			%  FORMAT = PR.GETPROPFORMAT(ComparisonGroupPF_NxPP_Node, POINTER) returns format of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			comparisongrouppf_nxpp_node_format_list = { 2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  18 };
			prop_format = comparisongrouppf_nxpp_node_format_list{prop};
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonGroupPF_NxPP_Node, POINTER) returns description of POINTER of ComparisonGroupPF_NxPP_Node.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(ComparisonGroupPF_NxPP_Node, POINTER) returns description of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			comparisongrouppf_nxpp_node_description_list = { 'NAME (constant, string) is the name of the panel property node.'  'DESCRIPTION (constant, string) is the description of the panel property node.'  'TEMPLATE (parameter, item) is the template of the panel property node.'  'ID (data, string) is a few-letter code for the panel property node.'  'LABEL (metadata, string) is an extended label of the panel property node.'  'NOTES (metadata, string) are some specific notes about the panel property node.'  'TOSTRING (query, string) returns a string that represents the object.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the editfield.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the property panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'DROPDOWN (evanescent, handle) is the dropdown for the node.' };
			prop_description = comparisongrouppf_nxpp_node_description_list{prop};
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonGroupPF_NxPP_Node, POINTER) returns settings of POINTER of ComparisonGroupPF_NxPP_Node.
			%  SETTINGS = PR.GETPROPSETTINGS(ComparisonGroupPF_NxPP_Node, POINTER) returns settings of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 35 % ComparisonGroupPF_NxPP_Node.DROPDOWN
					prop_settings = Format.getFormatSettings(18);
				case 3 % ComparisonGroupPF_NxPP_Node.TEMPLATE
					prop_settings = 'ComparisonGroupPF_NxPP_Node';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonGroupPF_NxPP_Node.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupPF_NxPP_Node.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonGroupPF_NxPP_Node, POINTER) returns the default value of POINTER of ComparisonGroupPF_NxPP_Node.
			%  DEFAULT = PR.GETPROPDEFAULT(ComparisonGroupPF_NxPP_Node, POINTER) returns the default value of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 35 % ComparisonGroupPF_NxPP_Node.DROPDOWN
					prop_default = Format.getFormatDefault(18, ComparisonGroupPF_NxPP_Node.getPropSettings(prop));
				case 1 % ComparisonGroupPF_NxPP_Node.NAME
					prop_default = 'ComparisonGroupPF_NxPP_Node';
				case 2 % ComparisonGroupPF_NxPP_Node.DESCRIPTION
					prop_default = 'ComparisonGroupPF_NxPP_Node plots the panel to select a node from a drop-down list. It is supposed to be used with the property NODE of ComparisonGroupPF_NU, ComparisonGroupPF_NS, or ComparisonGroupPF_NB.';
				case 3 % ComparisonGroupPF_NxPP_Node.TEMPLATE
					prop_default = Format.getFormatDefault(8, ComparisonGroupPF_NxPP_Node.getPropSettings(prop));
				case 4 % ComparisonGroupPF_NxPP_Node.ID
					prop_default = 'ComparisonGroupPF_NxPP_Node ID';
				case 5 % ComparisonGroupPF_NxPP_Node.LABEL
					prop_default = 'ComparisonGroupPF_NxPP_Node label';
				case 6 % ComparisonGroupPF_NxPP_Node.NOTES
					prop_default = 'ComparisonGroupPF_NxPP_Node notes';
				case 22 % ComparisonGroupPF_NxPP_Node.EL
					prop_default = ComparisonGroupPF_NU();
				case 23 % ComparisonGroupPF_NxPP_Node.PROP
					prop_default = 45;
				case 24 % ComparisonGroupPF_NxPP_Node.HEIGHT
					prop_default = 48;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonGroupPF_NxPP_Node.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupPF_NxPP_Node.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonGroupPF_NxPP_Node, POINTER) returns the conditioned default value of POINTER of ComparisonGroupPF_NxPP_Node.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(ComparisonGroupPF_NxPP_Node, POINTER) returns the conditioned default value of POINTER of ComparisonGroupPF_NxPP_Node.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			prop_default = ComparisonGroupPF_NxPP_Node.conditioning(prop, ComparisonGroupPF_NxPP_Node.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(ComparisonGroupPF_NxPP_Node, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupPF_NxPP_Node.
			%  CHECK = PR.CHECKPROP(ComparisonGroupPF_NxPP_Node, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupPF_NxPP_Node.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput
			%  Element.CHECKPROP(ComparisonGroupPF_NxPP_Node, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupPF_NxPP_Node.
			%   Error id: BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput
			%  PR.CHECKPROP(ComparisonGroupPF_NxPP_Node, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupPF_NxPP_Node.
			%   Error id: BRAPH2:ComparisonGroupPF_NxPP_Node:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('ComparisonGroupPF_NxPP_Node')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonGroupPF_NxPP_Node.getPropProp(pointer);
			
			switch prop
				case 35 % ComparisonGroupPF_NxPP_Node.DROPDOWN
					check = Format.checkFormat(18, value, ComparisonGroupPF_NxPP_Node.getPropSettings(prop));
				case 3 % ComparisonGroupPF_NxPP_Node.TEMPLATE
					check = Format.checkFormat(8, value, ComparisonGroupPF_NxPP_Node.getPropSettings(prop));
				otherwise
					if prop <= 34
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ComparisonGroupPF_NxPP_Node:' 'WrongInput'], ...
					['BRAPH2' ':ComparisonGroupPF_NxPP_Node:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonGroupPF_NxPP_Node.getPropTag(prop) ' (' ComparisonGroupPF_NxPP_Node.getFormatTag(ComparisonGroupPF_NxPP_Node.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 35 % ComparisonGroupPF_NxPP_Node.DROPDOWN
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_dropdown} ...
					    );
					
					value = dropdown;
					
				case 19 % ComparisonGroupPF_NxPP_Node.X_DRAW
					value = calculateValue@PanelProp(pr, 19, varargin{:}); % also warning
					if value
					    pr.memorize('DROPDOWN')
					end
					
				case 20 % ComparisonGroupPF_NxPP_Node.UPDATE
					value = calculateValue@PanelProp(pr, 20, varargin{:}); % also warning
					if value
					    pf = pr.get('EL');
					    NODE = pr.get('PROP');
					    
					    keys = pf.get('CP').get('C').get('A1').get('G').get('ANODELABELS');
					    
					    set(pr.get('DROPDOWN'), ...
					        'Items', keys, ...
					        'ItemsData', [1:1:length(keys)], ...
					        'Value', pf.get(NODE) ...
					        )
					
					    prop_value = pf.getr(NODE);
					    if pf.isLocked(NODE) || isa(prop_value, 'Callback')
					        set(pr.get('DROPDOWN'), 'Enable', 'off')
					    end
					end
					
				case 21 % ComparisonGroupPF_NxPP_Node.REDRAW
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('DROPDOWN'), 'Position', [4 4 .70*w_p 21])
					end
					
				case 17 % ComparisonGroupPF_NxPP_Node.DELETE
					value = calculateValue@PanelProp(pr, 17, varargin{:}); % also warning
					if value
					    pr.set('DROPDOWN', Element.getNoValue())
					end
					
				otherwise
					if prop <= 34
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_dropdown(~, ~)
			    pr.get('EL').set(pr.get('PROP'), get(pr.get('DROPDOWN'), 'Value'))
			end
		end
	end
end