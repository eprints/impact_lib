push @{$c->{fields}->{eprint}},
{
  name => 'imp_summary',
  type => 'longtext',
  multiple => 0,
  required => 0,
  sql_index => 0,
  input_rows => 3,
  render_single_value => "render_paras",
},

{
  name => 'imp_engagement',
  type => 'compound',
  multiple => 1,
  fields =>
  [
    {
      sub_name => 'activity',
      type => 'namedset',
      set_name => "impact_engagement",
      input_style => 'medium',
      multiple => 0,
      sql_index => 0,
    },
    # ME 19/06/2018 field added
    {
      sub_name => 'short_description',
      type => 'text',
      input_cols => 100,
      multiple => 0,
      sql_index => 0,
    },
    {
      sub_name => 'description',
      type => 'longtext',
      multiple => 0,
      input_rows => 3, # ME 19/06/18 changed from input_cols to input_rows
      input_cols => 98,
      sql_index => 0,
      render_single_value => "render_paras",
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
      multiple => 0,
      min_resolution => 'year',
      sql_index => 0,
    },
    # ME 19/06/18 remove field, no longer required
    #{
    #  sub_name => 'evid_submitted',
    #  type => 'boolean',
    #  sql_index => 0,
    #},
# glasogow specific
#    {
#      sub_name => 'pdr_link',
#      type => 'boolean',
#      sql_index => 0,
#    },
#    {
#      sub_name => 'web_link',
#      type => 'boolean',
#      sql_index => 0,
#    },
  ],
  input_boxes => 1,
  render_input => \&render_input_field_multi_compound
},

;
