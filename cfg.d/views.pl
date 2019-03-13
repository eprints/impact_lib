$c->{browse_views} = [
{
	id => "funder",
	menus => [
			{
				fields => [ "funding_funder_name" ],
                		hideempty => 1,
			}
		],
	order => "funding_funder_name",
	include => 1,
},
{
	id => "collaborators",
	menus => [
			{
				fields => [ "imp_external_collaborators_organisation" ],
                		hideempty => 1,
			}
		],
	order => "imp_external_collaborators_organisation",
	include => 1,
},
{
	id => "creators",
	menus => [
			{
				fields => [ "creators_name" ],
                		hideempty => 1,
			}
		],
	order => "creators_name",
	include => 1,
},
{
	id => "pdr_link",
	menus => [
			{
				fields => [ "creators_orcid" ],
                		hideempty => 1,
				allow_null => 0,
			},
		],
	filters => [
		{
			meta_fields => [ "imp_pdr_link" ],
			value => "TRUE",
			describe => 0,
		}
	],
	citation => 'feed',
	order => "creators_name",
	include => 1,
},
{
	id => "web_link",
	menus => [
			{
				fields => [ "creators_orcid" ],
                		hideempty => 1,
				allow_null => 0,
			},
		],
	filters => [
		{
			meta_fields => [ "imp_web_link" ],
			value => "TRUE",
			describe => 0,
		},
	],
	citation => 'feed',
	order => "creators_name",
	include => 1,
},

];
