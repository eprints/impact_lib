# Impact Case Study plugin

#create new eprint fields
push @{$c->{fields}->{eprint}},
	{
		name => 'imp_summary_short',
		type => 'text',
    		multiple => 0,
    		required => 0,
            	sql_index => 0,
	},
	{
		name => 'imp_title',
		type => 'text',
    		multiple => 0,
    		required => 0,
            	sql_index => 0,
	},
	{
		name => 'imp_additional_funding',
		type => 'boolean',
    		required => 0,
            	sql_index => 0,
	},
	{
		name => 'imp_contact_public_engagement',
		type => 'boolean',
    		required => 0,
            	sql_index => 0,
	},
    	{
		name => 'imp_unfunded',
		type => 'boolean',
		required => 0,
		sql_index => 0,
	},
    	{
		name => 'imp_esteem_prize',
		type => 'longtext',
		multiple => 0,
 		required => 0,
    		sql_index => 0,
        	input_rows => 3,
		render_single_value => "render_paras",
	},
    	{
		name => 'imp_esteem_editor',
		type => 'longtext',
		multiple => 0,
 		required => 0,
    		sql_index => 0,
        	input_rows => 3,
		render_single_value => "render_paras",
	},
    	{
		name => 'imp_esteem_committee_chair',
		type => 'longtext',
		multiple => 0,
 		required => 0,
    		sql_index => 0,
        	input_rows => 3,
		render_single_value => "render_paras",
	},
    	{
		name => 'imp_esteem_advisory_panel',
		type => 'longtext',
		multiple => 0,
 		required => 0,
    		sql_index => 0,
        	input_rows => 3,
		render_single_value => "render_paras",
	},
    	{
		name => 'imp_esteem_other',
		type => 'longtext',
		multiple => 0,
 		required => 0,
    		sql_index => 0,
        	input_rows => 3,
		render_single_value => "render_paras",
	},
    	{
		name => 'imp_fund_glasgow_ke_fund',
		type => 'boolean',
		required => 0,
		sql_index => 0,
	},
    	{
		name => 'imp_fund_esrc_iaa',
		type => 'boolean',
		required => 0,
		sql_index => 0,
	},
    	{
		name => 'imp_fund_epsrc_iaa',
		type => 'boolean',
		required => 0,
		sql_index => 0,
	},
    	{
		name => 'imp_fund_bbsrc_iaa',
		type => 'boolean',
		required => 0,
		sql_index => 0,
	},
   	{
		name => 'imp_fund_stfc_iaa',
		type => 'boolean',
		required => 0,
		sql_index => 0,
	},
    	{
		name => 'imp_fund_chancellors_fund',
		type => 'boolean',
		required => 0,
		sql_index => 0,
	},
    	{
		name => 'imp_fund_other',
		type => 'boolean',
		required => 0,
		sql_index => 0,
	},
	{
		name => 'imp_difference',
		type => 'namedset',
		set_name => "impact_difference",
		multiple => 1,
		required => 0,
    		sql_index => 0,
    		input_rows => 3,
    		input_style => 'medium',
	},
	{
		name => 'imp_difference_other',
		type => 'longtext',
		multiple => 1,
		required => 0,
	    	sql_index => 0,
	    	input_rows => 1,
	    	input_boxes => 1,
		# render_single_value => "render_paras",
	},
	{
		name => 'imp_evidence_link',
		type => 'url',
	    	multiple => 1,
	    	input_boxes => 1,
	    	sql_index => 0,
	},
	{
		name => 'imp_evidence_of_change',
		type => 'longtext',
		multiple => 0,
		required => 0,
		sql_index => 0,
		input_rows => 3,
		render_single_value => "render_paras",
	},
	{
		name => 'imp_external_collaborators',
		type => 'compound',
		multiple => 1,
	    	input_boxes => 1,
	    	sql_index => 0,
	        fields => [
				{
	            			sub_name => 'organisation',
	                		type => 'text',
	                		multiple => 0,
	            		},
	            		{
	            			sub_name => 'name',
	                		type => 'text',
	               			multiple => 0,
	            		},
	            		{
	            			sub_name => 'position',
	                		type => 'text',
	                		multiple => 0,
	            		},
			   ],
		render_input => \&render_input_field_multi_compound
	},
	{
		name => 'imp_pdr_link',
		type => 'boolean',
	    	required => 1,
	        sql_index => 0,
	},
	{
		name => 'imp_web_link',
		type => 'boolean',
	    	required => 1,
	        sql_index => 0,
	},

# a filtered version of the imp_engagment used for sharing
	{
		name=> 'imp_engagement_filtered',
		type => 'compound',
		multiple => 1,
		fields => [
				{
					sub_name => 'activity',
					type => 'namedset',
					set_name => "impact_engagement",
					input_style => 'medium',
					multiple => 0,
				        sql_index => 0,
				},
	            		{
					sub_name => 'description',
					type => 'text',
					multiple => 0,
				        sql_index => 0,
				},
				{
					sub_name => 'nature',
					type => 'namedset',
					multiple => 0,
					set_name => "impact_activity_nature",
					input_style => 'boolean',
				        sql_index => 0,
				},
				{
					sub_name => 'date',
					type => 'date',
					min_resolution => 'year',
				        sql_index => 0,
				},
				{
					sub_name => 'evid_submitted',
					type => 'boolean',
				        sql_index => 0,
				},
			   ],
		input_boxes => 1,
		render_input => \&render_input_field_multi_compound
	},

;

push @{$c->{fields}->{document}},
        {
                name => 'imp_evidence_type',
                type => "set",
                options => [
                        'Guidelines',
                        'Policy Document',
                        'Committee Papers',
                        'Citation',
                        'Other',
                        ],
                sql_index => 0,
        },
        {
                name => 'imp_evidence_type_other',
                type => "text",
                multiple => 1,
                input_boxes => 1,
                sql_index => 0,
        },
;
