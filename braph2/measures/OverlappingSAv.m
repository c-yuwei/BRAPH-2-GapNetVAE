classdef OverlappingSAv < OverlappingS
	%OverlappingSAv is the graph Average Overlapping Strength.
	% It is a subclass of <a href="matlab:help OverlappingS">OverlappingS</a>.
	%
	% The Average Overlapping Strength (OverlappingSAv) of a graph is the average of the sum of the 
	% strengths of a node in all layers.
	%
	% OverlappingSAv methods (constructor):
	%  OverlappingSAv - constructor
	%
	% OverlappingSAv methods:
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
	% OverlappingSAv methods (display):
	%  tostring - string with information about the averge overlapping strength
	%  disp - displays information about the averge overlapping strength
	%  tree - displays the tree of the averge overlapping strength
	%
	% OverlappingSAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two averge overlapping strength are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the averge overlapping strength
	%
	% OverlappingSAv methods (save/load, Static):
	%  save - saves BRAPH2 averge overlapping strength as b2 file
	%  load - loads a BRAPH2 averge overlapping strength from a b2 file
	%
	% OverlappingSAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the averge overlapping strength
	%
	% OverlappingSAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the averge overlapping strength
	%
	% OverlappingSAv methods (inspection, Static):
	%  getClass - returns the class of the averge overlapping strength
	%  getSubclasses - returns all subclasses of OverlappingSAv
	%  getProps - returns the property list of the averge overlapping strength
	%  getPropNumber - returns the property number of the averge overlapping strength
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
	% OverlappingSAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% OverlappingSAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% OverlappingSAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% OverlappingSAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?OverlappingSAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">OverlappingSAv constants</a>.
	%
	
	methods % constructor
		function m = OverlappingSAv(varargin)
			%OverlappingSAv() creates a averge overlapping strength.
			%
			% OverlappingSAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% OverlappingSAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@OverlappingS(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the averge overlapping strength.
			%
			% CLASS = OverlappingSAv.GETCLASS() returns the class 'OverlappingSAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the averge overlapping strength M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('OverlappingSAv') returns 'OverlappingSAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('OverlappingSAv')
			%  are less computationally efficient.
			
			m_class = 'OverlappingSAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the averge overlapping strength.
			%
			% LIST = OverlappingSAv.GETSUBCLASSES() returns all subclasses of 'OverlappingSAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the averge overlapping strength M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('OverlappingSAv') returns all subclasses of 'OverlappingSAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('OverlappingSAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of averge overlapping strength.
			%
			% PROPS = OverlappingSAv.GETPROPS() returns the property list of averge overlapping strength
			%  as a row vector.
			%
			% PROPS = OverlappingSAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the averge overlapping strength M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('OverlappingSAv'[, CATEGORY]) returns the property list of 'OverlappingSAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					OverlappingS.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						OverlappingS.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						OverlappingS.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						OverlappingS.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						OverlappingS.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						OverlappingS.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						OverlappingS.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						OverlappingS.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						OverlappingS.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						OverlappingS.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of averge overlapping strength.
			%
			% N = OverlappingSAv.GETPROPNUMBER() returns the property number of averge overlapping strength.
			%
			% N = OverlappingSAv.GETPROPNUMBER(CATEGORY) returns the property number of averge overlapping strength
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the averge overlapping strength M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('OverlappingSAv') returns the property number of 'OverlappingSAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(OverlappingSAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in averge overlapping strength/error.
			%
			% CHECK = OverlappingSAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(OverlappingSAv, PROP) checks whether PROP exists for OverlappingSAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:OverlappingSAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSAv:WrongInput]
			%  Element.EXISTSPROP(OverlappingSAv, PROP) throws error if PROP does NOT exist for OverlappingSAv.
			%   Error id: [BRAPH2:OverlappingSAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == OverlappingSAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingSAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingSAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for OverlappingSAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in averge overlapping strength/error.
			%
			% CHECK = OverlappingSAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(OverlappingSAv, TAG) checks whether TAG exists for OverlappingSAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:OverlappingSAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:OverlappingSAv:WrongInput]
			%  Element.EXISTSTAG(OverlappingSAv, TAG) throws error if TAG does NOT exist for OverlappingSAv.
			%   Error id: [BRAPH2:OverlappingSAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			overlappingsav_tag_list = cellfun(@(x) OverlappingSAv.getPropTag(x), num2cell(OverlappingSAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, overlappingsav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingSAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingSAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for OverlappingSAv.'] ...
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
			%  PROPERTY = M.GETPROPPROP(POINTER) returns property number of POINTER of M.
			%  PROPERTY = Element.GETPROPPROP(OverlappingSAv, POINTER) returns property number of POINTER of OverlappingSAv.
			%  PROPERTY = M.GETPROPPROP(OverlappingSAv, POINTER) returns property number of POINTER of OverlappingSAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				overlappingsav_tag_list = cellfun(@(x) OverlappingSAv.getPropTag(x), num2cell(OverlappingSAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, overlappingsav_tag_list)); % tag = pointer
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
			%  TAG = M.GETPROPTAG(POINTER) returns tag of POINTER of M.
			%  TAG = Element.GETPROPTAG(OverlappingSAv, POINTER) returns tag of POINTER of OverlappingSAv.
			%  TAG = M.GETPROPTAG(OverlappingSAv, POINTER) returns tag of POINTER of OverlappingSAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					otherwise
						tag = getPropTag@OverlappingS(prop);
				end
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
			%  CATEGORY = M.GETPROPCATEGORY(POINTER) returns category of POINTER of M.
			%  CATEGORY = Element.GETPROPCATEGORY(OverlappingSAv, POINTER) returns category of POINTER of OverlappingSAv.
			%  CATEGORY = M.GETPROPCATEGORY(OverlappingSAv, POINTER) returns category of POINTER of OverlappingSAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingSAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@OverlappingS(prop);
			end
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
			%  FORMAT = M.GETPROPFORMAT(POINTER) returns format of POINTER of M.
			%  FORMAT = Element.GETPROPFORMAT(OverlappingSAv, POINTER) returns format of POINTER of OverlappingSAv.
			%  FORMAT = M.GETPROPFORMAT(OverlappingSAv, POINTER) returns format of POINTER of OverlappingSAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingSAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@OverlappingS(prop);
			end
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
			%  DESCRIPTION = M.GETPROPDESCRIPTION(POINTER) returns description of POINTER of M.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(OverlappingSAv, POINTER) returns description of POINTER of OverlappingSAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(OverlappingSAv, POINTER) returns description of POINTER of OverlappingSAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = OverlappingSAv.getPropProp(pointer);
			
			switch prop
				case OverlappingSAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Overlapping Strength.';
				case OverlappingSAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Overlapping Strength.';
				case OverlappingSAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Overlapping Strength.';
				case OverlappingSAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Overlapping Strength.';
				case OverlappingSAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Overlapping Strength.';
				case OverlappingSAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Overlapping Strength.';
				case OverlappingSAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Overlapping Strength.';
				case OverlappingSAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case OverlappingSAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case OverlappingSAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case OverlappingSAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case OverlappingSAv.M
					prop_description = 'M (result, cell) is the Average Overlapping Strength.';
				otherwise
					prop_description = getPropDescription@OverlappingS(prop);
			end
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
			%  SETTINGS = M.GETPROPSETTINGS(POINTER) returns settings of POINTER of M.
			%  SETTINGS = Element.GETPROPSETTINGS(OverlappingSAv, POINTER) returns settings of POINTER of OverlappingSAv.
			%  SETTINGS = M.GETPROPSETTINGS(OverlappingSAv, POINTER) returns settings of POINTER of OverlappingSAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = OverlappingSAv.getPropProp(pointer);
			
			switch prop
				case OverlappingSAv.TEMPLATE
					prop_settings = 'OverlappingSAv';
				otherwise
					prop_settings = getPropSettings@OverlappingS(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = OverlappingSAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingSAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(OverlappingSAv, POINTER) returns the default value of POINTER of OverlappingSAv.
			%  DEFAULT = M.GETPROPDEFAULT(OverlappingSAv, POINTER) returns the default value of POINTER of OverlappingSAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = OverlappingSAv.getPropProp(pointer);
			
			switch prop
				case OverlappingSAv.ELCLASS
					prop_default = 'OverlappingSAv';
				case OverlappingSAv.NAME
					prop_default = 'Average Overlapping Strength';
				case OverlappingSAv.DESCRIPTION
					prop_default = 'The Average Overlapping Strength (OverlappingSAv) of a graph is the average of the sum of the strengths of a node in all layers.';
				case OverlappingSAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, OverlappingSAv.getPropSettings(prop));
				case OverlappingSAv.ID
					prop_default = 'OverlappingSAv ID';
				case OverlappingSAv.LABEL
					prop_default = 'Average Overlapping Strength label';
				case OverlappingSAv.NOTES
					prop_default = 'Average Overlapping Strength notes';
				case OverlappingSAv.SHAPE
					prop_default = Measure.GLOBAL;
				case OverlappingSAv.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case OverlappingSAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case OverlappingSAv.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'OrdMxWU' 'MultilayerWU' 'OrdMlWU'};
				otherwise
					prop_default = getPropDefault@OverlappingS(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = OverlappingSAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = OverlappingSAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(OverlappingSAv, POINTER) returns the conditioned default value of POINTER of OverlappingSAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(OverlappingSAv, POINTER) returns the conditioned default value of POINTER of OverlappingSAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = OverlappingSAv.getPropProp(pointer);
			
			prop_default = OverlappingSAv.conditioning(prop, OverlappingSAv.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = M.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = M.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of M.
			%  CHECK = Element.CHECKPROP(OverlappingSAv, PROP, VALUE) checks VALUE format for PROP of OverlappingSAv.
			%  CHECK = M.CHECKPROP(OverlappingSAv, PROP, VALUE) checks VALUE format for PROP of OverlappingSAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:OverlappingSAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:OverlappingSAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(OverlappingSAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingSAv.
			%   Error id: €BRAPH2.STR€:OverlappingSAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(OverlappingSAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of OverlappingSAv.
			%   Error id: €BRAPH2.STR€:OverlappingSAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('OverlappingSAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = OverlappingSAv.getPropProp(pointer);
			
			switch prop
				case OverlappingSAv.TEMPLATE % __OverlappingSAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, OverlappingSAv.getPropSettings(prop));
				otherwise
					if prop <= OverlappingS.getPropNumber()
						check = checkProp@OverlappingS(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':OverlappingSAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':OverlappingSAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' OverlappingSAv.getPropTag(prop) ' (' OverlappingSAv.getFormatTag(OverlappingSAv.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with Category.RESULT,
			%  Category.QUERY, and Category.EVANESCENT. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  Category.QUERY.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case OverlappingSAv.M % __OverlappingSAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(OverlappingSAv.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					overlapping_strength = calculateValue@OverlappingS(m, prop);
					l = g.get('LAYERNUMBER');
					
					if l == 0
					    value = {};
					else
					
					    value = {mean(cell2mat(overlapping_strength))};
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= OverlappingS.getPropNumber()
						value = calculateValue@OverlappingS(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
