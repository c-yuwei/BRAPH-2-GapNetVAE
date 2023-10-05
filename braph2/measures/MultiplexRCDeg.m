classdef MultiplexRCDeg < RCDeg
	%MultiplexRCDeg is the graph Multiplex Rich-Club Degree.
	% It is a subclass of <a href="matlab:help RCDeg">RCDeg</a>.
	%
	% The Multiplex Rich-Club Degree (MultiplexRCDeg) of a node at level k is the sum of 
	%  the edges that connect nodes of degree k or higher in all layers. 
	% The relevance of each layer is controlled by the coefficients c that are 
	%  between 0 and 1; the default coefficients are (1/layernumber).
	%
	% MultiplexRCDeg methods (constructor):
	%  MultiplexRCDeg - constructor
	%
	% MultiplexRCDeg methods:
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
	% MultiplexRCDeg methods (display):
	%  tostring - string with information about the multi rich-club degree
	%  disp - displays information about the multi rich-club degree
	%  tree - displays the tree of the multi rich-club degree
	%
	% MultiplexRCDeg methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multi rich-club degree are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multi rich-club degree
	%
	% MultiplexRCDeg methods (save/load, Static):
	%  save - saves BRAPH2 multi rich-club degree as b2 file
	%  load - loads a BRAPH2 multi rich-club degree from a b2 file
	%
	% MultiplexRCDeg method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multi rich-club degree
	%
	% MultiplexRCDeg method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multi rich-club degree
	%
	% MultiplexRCDeg methods (inspection, Static):
	%  getClass - returns the class of the multi rich-club degree
	%  getSubclasses - returns all subclasses of MultiplexRCDeg
	%  getProps - returns the property list of the multi rich-club degree
	%  getPropNumber - returns the property number of the multi rich-club degree
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
	% MultiplexRCDeg methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexRCDeg methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexRCDeg methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexRCDeg methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexRCDeg; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexRCDeg constants</a>.
	%
	
	properties (Constant) % properties
		MULTIRICHCLUB_COEFFICIENTS = RCDeg.getPropNumber() + 1;
		MULTIRICHCLUB_COEFFICIENTS_TAG = 'MULTIRICHCLUB_COEFFICIENTS';
		MULTIRICHCLUB_COEFFICIENTS_CATEGORY = Category.PARAMETER;
		MULTIRICHCLUB_COEFFICIENTS_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function m = MultiplexRCDeg(varargin)
			%MultiplexRCDeg() creates a multi rich-club degree.
			%
			% MultiplexRCDeg(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexRCDeg(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@RCDeg(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the multi rich-club degree.
			%
			% CLASS = MultiplexRCDeg.GETCLASS() returns the class 'MultiplexRCDeg'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multi rich-club degree M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiplexRCDeg') returns 'MultiplexRCDeg'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiplexRCDeg')
			%  are less computationally efficient.
			
			m_class = 'MultiplexRCDeg';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multi rich-club degree.
			%
			% LIST = MultiplexRCDeg.GETSUBCLASSES() returns all subclasses of 'MultiplexRCDeg'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multi rich-club degree M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiplexRCDeg') returns all subclasses of 'MultiplexRCDeg'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexRCDeg', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multi rich-club degree.
			%
			% PROPS = MultiplexRCDeg.GETPROPS() returns the property list of multi rich-club degree
			%  as a row vector.
			%
			% PROPS = MultiplexRCDeg.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multi rich-club degree M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiplexRCDeg'[, CATEGORY]) returns the property list of 'MultiplexRCDeg'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					RCDeg.getProps() ...
						MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						RCDeg.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						RCDeg.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						RCDeg.getProps(Category.PARAMETER) ...
						MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS ...
						];
				case Category.DATA
					prop_list = [ ...
						RCDeg.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						RCDeg.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						RCDeg.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						RCDeg.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						RCDeg.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						RCDeg.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of multi rich-club degree.
			%
			% N = MultiplexRCDeg.GETPROPNUMBER() returns the property number of multi rich-club degree.
			%
			% N = MultiplexRCDeg.GETPROPNUMBER(CATEGORY) returns the property number of multi rich-club degree
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multi rich-club degree M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiplexRCDeg') returns the property number of 'MultiplexRCDeg'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexRCDeg.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multi rich-club degree/error.
			%
			% CHECK = MultiplexRCDeg.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiplexRCDeg, PROP) checks whether PROP exists for MultiplexRCDeg.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexRCDeg:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexRCDeg:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexRCDeg:WrongInput]
			%  Element.EXISTSPROP(MultiplexRCDeg, PROP) throws error if PROP does NOT exist for MultiplexRCDeg.
			%   Error id: [BRAPH2:MultiplexRCDeg:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexRCDeg.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexRCDeg.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multi rich-club degree/error.
			%
			% CHECK = MultiplexRCDeg.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiplexRCDeg, TAG) checks whether TAG exists for MultiplexRCDeg.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexRCDeg:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexRCDeg:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexRCDeg:WrongInput]
			%  Element.EXISTSTAG(MultiplexRCDeg, TAG) throws error if TAG does NOT exist for MultiplexRCDeg.
			%   Error id: [BRAPH2:MultiplexRCDeg:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplexrcdeg_tag_list = cellfun(@(x) MultiplexRCDeg.getPropTag(x), num2cell(MultiplexRCDeg.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplexrcdeg_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexRCDeg.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexRCDeg, POINTER) returns property number of POINTER of MultiplexRCDeg.
			%  PROPERTY = M.GETPROPPROP(MultiplexRCDeg, POINTER) returns property number of POINTER of MultiplexRCDeg.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplexrcdeg_tag_list = cellfun(@(x) MultiplexRCDeg.getPropTag(x), num2cell(MultiplexRCDeg.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplexrcdeg_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexRCDeg, POINTER) returns tag of POINTER of MultiplexRCDeg.
			%  TAG = M.GETPROPTAG(MultiplexRCDeg, POINTER) returns tag of POINTER of MultiplexRCDeg.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS
						tag = MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS_TAG;
					otherwise
						tag = getPropTag@RCDeg(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexRCDeg, POINTER) returns category of POINTER of MultiplexRCDeg.
			%  CATEGORY = M.GETPROPCATEGORY(MultiplexRCDeg, POINTER) returns category of POINTER of MultiplexRCDeg.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexRCDeg.getPropProp(pointer);
			
			switch prop
				case MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS
					prop_category = MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS_CATEGORY;
				otherwise
					prop_category = getPropCategory@RCDeg(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexRCDeg, POINTER) returns format of POINTER of MultiplexRCDeg.
			%  FORMAT = M.GETPROPFORMAT(MultiplexRCDeg, POINTER) returns format of POINTER of MultiplexRCDeg.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexRCDeg.getPropProp(pointer);
			
			switch prop
				case MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS
					prop_format = MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS_FORMAT;
				otherwise
					prop_format = getPropFormat@RCDeg(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexRCDeg, POINTER) returns description of POINTER of MultiplexRCDeg.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiplexRCDeg, POINTER) returns description of POINTER of MultiplexRCDeg.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexRCDeg.getPropProp(pointer);
			
			switch prop
				case MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS
					prop_description = 'MULTIRICHCLUB_COEFFICIENTS (parameter, RVECTOR) is the multi rich-club degree coefficients';
				case MultiplexRCDeg.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Multiplex Rich-Club Degree.';
				case MultiplexRCDeg.NAME
					prop_description = 'NAME (constant, string) is the name of the Multiplex Rich-Club Degree.';
				case MultiplexRCDeg.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Multiplex Rich-Club Degree.';
				case MultiplexRCDeg.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Multiplex Rich-Club Degree.';
				case MultiplexRCDeg.ID
					prop_description = 'ID (data, string) is a few-letter code of the Multiplex Rich-Club Degree.';
				case MultiplexRCDeg.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Multiplex Rich-Club Degree.';
				case MultiplexRCDeg.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the multiplex rich-club degree.';
				case MultiplexRCDeg.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case MultiplexRCDeg.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case MultiplexRCDeg.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case MultiplexRCDeg.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case MultiplexRCDeg.M
					prop_description = 'M (result, cell) is the Multiplex Rich-Club Degree.';
				otherwise
					prop_description = getPropDescription@RCDeg(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexRCDeg, POINTER) returns settings of POINTER of MultiplexRCDeg.
			%  SETTINGS = M.GETPROPSETTINGS(MultiplexRCDeg, POINTER) returns settings of POINTER of MultiplexRCDeg.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexRCDeg.getPropProp(pointer);
			
			switch prop
				case MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case MultiplexRCDeg.TEMPLATE
					prop_settings = 'MultiplexRCDeg';
				otherwise
					prop_settings = getPropSettings@RCDeg(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexRCDeg.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexRCDeg.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexRCDeg, POINTER) returns the default value of POINTER of MultiplexRCDeg.
			%  DEFAULT = M.GETPROPDEFAULT(MultiplexRCDeg, POINTER) returns the default value of POINTER of MultiplexRCDeg.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexRCDeg.getPropProp(pointer);
			
			switch prop
				case MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS
					prop_default = [0];
				case MultiplexRCDeg.ELCLASS
					prop_default = 'MultiplexRCDeg';
				case MultiplexRCDeg.NAME
					prop_default = 'Multiplex Rich-Club Degree';
				case MultiplexRCDeg.DESCRIPTION
					prop_default = 'The Multiplex Rich-Club Degree (MultiplexRCDeg) of a node at level k is the sum of the edges that connect nodes of degree k or higher in all layers. The relevance of each layer is controlled by the coefficients c that are between 0 and 1; the default coefficients are (1/layernumber).';
				case MultiplexRCDeg.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexRCDeg.getPropSettings(prop));
				case MultiplexRCDeg.ID
					prop_default = 'MultiplexRCDeg ID';
				case MultiplexRCDeg.LABEL
					prop_default = 'Multiplex Rich-Club Degree label';
				case MultiplexRCDeg.NOTES
					prop_default = 'Multiplex Rich-Club Degree notes';
				case MultiplexRCDeg.SHAPE
					prop_default = Measure.NODAL;
				case MultiplexRCDeg.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case MultiplexRCDeg.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case MultiplexRCDeg.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'OrdMxBUD' 'OrdMxBUT'};;
				otherwise
					prop_default = getPropDefault@RCDeg(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexRCDeg.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexRCDeg.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexRCDeg, POINTER) returns the conditioned default value of POINTER of MultiplexRCDeg.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiplexRCDeg, POINTER) returns the conditioned default value of POINTER of MultiplexRCDeg.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexRCDeg.getPropProp(pointer);
			
			prop_default = MultiplexRCDeg.conditioning(prop, MultiplexRCDeg.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexRCDeg, PROP, VALUE) checks VALUE format for PROP of MultiplexRCDeg.
			%  CHECK = M.CHECKPROP(MultiplexRCDeg, PROP, VALUE) checks VALUE format for PROP of MultiplexRCDeg.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexRCDeg:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:MultiplexRCDeg:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexRCDeg, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexRCDeg.
			%   Error id: €BRAPH2.STR€:MultiplexRCDeg:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(MultiplexRCDeg, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexRCDeg.
			%   Error id: €BRAPH2.STR€:MultiplexRCDeg:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiplexRCDeg')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexRCDeg.getPropProp(pointer);
			
			switch prop
				case MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS % __MultiplexRCDeg.MULTIRICHCLUB_COEFFICIENTS__
					check = Format.checkFormat(Format.RVECTOR, value, MultiplexRCDeg.getPropSettings(prop));
				case MultiplexRCDeg.TEMPLATE % __MultiplexRCDeg.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexRCDeg.getPropSettings(prop));
				otherwise
					if prop <= RCDeg.getPropNumber()
						check = checkProp@RCDeg(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexRCDeg:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexRCDeg.getPropTag(prop) ' (' MultiplexRCDeg.getFormatTag(MultiplexRCDeg.getPropFormat(prop)) ').'] ...
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
				case MultiplexRCDeg.M % __MultiplexRCDeg.M__
					rng_settings_ = rng(); rng(m.getPropSeed(MultiplexRCDeg.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					rich_club_degree = calculateValue@RCDeg(m, prop);
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    richclub_threshold = m.get('PARAMETRIC_VALUE'); % klevel
					
					    multirichclub_coefficients = m.get('MULTIRICHCLUB_COEFFICIENTS');
					    if length(multirichclub_coefficients) == ls(1)
					        assert(all(multirichclub_coefficients <= 1) && all(multirichclub_coefficients >= 0), ...
					            [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.WRONG_INPUT], ...
					            ['MultiRichClubDegree coefficients must be between 0 and 1 ' ...
					            'while they are ' tostring(multirichclub_coefficients)])
					        c = multirichclub_coefficients;
					
					    else  % same relevance for each layer
					        c = ones(1, l)/ls(1);
					    end
					
					    multi_rich_club_degree = cell(length(ls), 1);
					    count = 1;
					    for i = 1:1:length(ls)
					        multi_rich_club_degree_partition = zeros(N(1), 1, richclub_threshold);
					        for li = count:1:ls(i) + count - 1
					            ri = rich_club_degree{li};  % to fix when making this measure also parametric
					            % loop over the 3rd dimension of rich club degree (k_level)
					            for k = 1:1:richclub_threshold
					                multi_rich_club_degree_partition(:, :, k) = multi_rich_club_degree_partition(:, :, k) + c(li)*ri(:, :, k);
					            end
					        end
					        count = count + ls(i);
					        multi_rich_club_degree(i) = {multi_rich_club_degree_partition};
					    end
					    value = multi_rich_club_degree;
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= RCDeg.getPropNumber()
						value = calculateValue@RCDeg(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
