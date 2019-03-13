push @{$c->{fields}->{eprint}},

{
        'name' => 'creators',
        'type' => 'compound',
        'multiple' => 1,
#        'render_value' => 'localfn_render_person',
        'fields' => [
                {
                'sub_name' => 'name',
                'type' => 'name',
                'hide_honourific' => 1,
                'hide_lineage' => 1,
                'family_first' => 1,
                },
                {
                'sub_name' => 'id',
                'type' => 'text',
                'input_cols' => 20,
                'allow_null' => 1,
                },
                {
                'sub_name' => 'guid',
                'type' => 'text',
                'input_cols' => 20,
                'allow_null' => 1,
                'export_as_xml' => 0,
                },
                {
                'sub_name' => 'orcid',
                'type' => 'text',
                'input_cols' => 20,
                'allow_null' => 1,
                }, 

		# impact specific
        	#{
		#	name => 'imp_pdr_link',
		#	type => 'boolean',
		#	required => 1,
		#	sql_index => 0,
		#},
        ],
        'input_boxes' => 4,
	render_input => \&render_input_field_multi_compound
},

{
        'name' => 'funding',
        'type' => 'compound',
        'multiple' => 1,
        'fields' => [
                {
                'maxlength' => '7',
                'input_cols' => '6',
                # 'type' => 'int',
                'type' => 'text', # text unless you know its an int
                'sub_name' => 'project_code',
                # 'browse_link' => 'project_code' 
                },
                {
                'maxlength' => '3',
                'input_cols' => '3',
                'type' => 'int',
                'sub_name' => 'award_no'
                },
                {
                'input_cols' => '45',
                'type' => 'text',
                'sub_name' => 'project_name'
                },
                {
                'input_cols' => '25',
                'type' => 'text',
                'sub_name' => 'investigator_name'
                },
                {
                'input_cols' => '45',
                'type' => 'text',
                'sub_name' => 'funder_name',
                'browse_link' => 'funder' 
                },
                {
                'maxlength' => '15',
                'input_cols' => '12',
                'type' => 'text',
                'sub_name' => 'funder_code'
                },
                {
                'input_cols' => '45',
                'type' => 'text',
                'sub_name' => 'investigator_dept'
                }
        ],
        'input_boxes' => '2',
	render_input => \&render_input_field_multi_compound
},

{
  name => 'divisions',
  type => 'subject',
  multiple => 1,
  top => 'divisions',
  # browse_link => 'divisions',
},

;
