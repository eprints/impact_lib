push @{$c->{fields}->{eprint}},

{
        'name' => 'link',
        'type' => 'compound',
        'multiple' => 1,
        'fields' => [
              {
                'sub_name' => 'link',
                'type' => 'text',
              },
              {
                'sub_name' => 'info',
                'type' => 'longtext',
                'input_cols' => 50,
                'input_rows' => 5,
                'allow_null' => 1,
              },
        ],
        'input_boxes' => 2,
        'render_value' => 'render_external_links',
	'render_input' => \&render_input_field_multi_compound
},
;

$c->{render_external_links} = sub
{
        my( $session, $field, $value ) = @_;

        my $f = $field->get_property( "fields_cache" );
        my $fmap = {};  
        foreach my $field_conf ( @{$f} )
        {
                my $fieldname = $field_conf->{name};
                my $field = $field->{dataset}->get_field( $fieldname );
                $fmap->{$field_conf->{sub_name}} = $field;
        }

        my $ul = $session->make_element( "ul", "class" => "ep_external_links" );
        foreach my $row ( @{$value} )
        {
                my $li = $session->make_element( "li" );
                my $link = $session->render_link( $row->{link} );

                my $text = $row->{link};
                if( length( $text ) > 100 ) { $text = substr( $text, 0, 100 )."..."; }

                my $desc = $row->{info};
                if( length( $desc ) > 100 ) { $desc = substr( $desc, 0, 100 )."..."; }

                $link->appendChild( $session->make_text( $text ) );
                $li->appendChild( $link );
                $li->appendChild( $session->make_element( "br" ) );
                $li->appendChild( $session->make_text( $desc ) );

                $ul->appendChild( $li );
        }

        return $ul;
}
