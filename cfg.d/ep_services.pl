################################################################################################################################
# This is the rendering function for rendering multi_compound fields vertically. 
# It is specified as the value for render_input in eprint_fields.pl.
################################################################################################################################
sub render_input_field_multi_compound
{
    my( $self, $session, $value, $dataset, $staff, $hidden_fields, $obj, $basename ) = @_;

    my $elements = $self->get_input_elements( $session, $value, $staff, $obj, $basename );
    my $table = $session->make_element( "table", border=>0, cellpadding=>0, cellspacing=>0, class=>"ep_form_input_grid_multi_compound" );
    my %tableStash = ();

    my $y = 0;
    my $x = 0;

    my $numElements = 0;
    my $numRowsEach = 0;
    my $numFields = 0;
    my $numLabelDifference = 0;
    my $autocomplete = 1;
    my $stashKey = 0;

    foreach my $row ( @{$elements} ) {
        # COUNT THE ELEMENTS
        # THIS WILL INCLUDE ELEMENTS FOR ANY AUTOCOMPLETE AND AN ELEMENT FOR THE MORE ROWS
        $numElements++;
        if( $numRowsEach > $numFields ) {
            $numFields = $numRowsEach;
        }
        $numRowsEach = 0;
        foreach my $item ( @{$row} ) {
            $numRowsEach++;
        }
    }
    # SUBTRACT 1 FOR THE MORE_ROWS ELEMENT
    $numElements = $numElements - 1;

    # IF THERE IS A LOOKUP, WE NEED TO DIVIDE BY 2 TO GET THE NUMBER OF ACTUAL ELEMENTS, AS EACH LOOKUP COUNTS AS AN ELEMENT
    if( defined $self->{input_lookup_url} ) {
        $numElements = $numElements / 2;
        $numLabelDifference = 2;
        $autocomplete = 2;
    }
    
    # SUBTRACT THE INDEX AND ARROWS ROWS FROM THE NUMBER OF FIELDS TO GET THE NUMBER OF LABELS EXPECTED
    my $numLabels = $numFields - 2;
    my $labelsIndex = 0;
    
    $y = 0;
    my $total_rows = scalar( @{$elements} );

    foreach my $row ( @{$elements} ) {

        my $x = 0;
        my $labelsIndex = 0;
        my $col_titles = $self->get_input_col_titles( $session, $staff );
        my $labelStop = 0;
        our $td_index_STASH;
        our $td_label_STASH;
        our $td_field_STASH;

        my $rownum = 0;
        foreach my $item ( @{$row} ) {
        
            my $row_class = "multi_compound_row";
               $row_class .= " multi_compound_row_${rownum}" if $y < ($total_rows-1); # not last row

            my $tr = $session->make_element( "tr", class => $row_class );
            my %opts = ( valign=>"top", id=>$basename."_cell_".$x++."_".$y );
            my $doingArrows = 0;

            foreach my $prop ( keys %{$item} ) {
                if( $item->{$prop} eq "ep_form_input_grid_arrows" ) {
                    $doingArrows = 1;
                }
                next if( $prop eq "el" );
                next if( $prop eq "colspan" );
                $opts{$prop} = $item->{$prop};
            }   

            # FIRST FILTER -- DO NOT APPLY LABELS TO AUTOCOMPLETE, ONLY TO ROWS CONTAINING FIELDS
            # HOW DO WE KNOW THAT THIS IS AN AUTOCOMPLETE ROW
            # ASSUMES THAT AUTOCOMPLETE ELEMENT ALWAYS FOLLOWS DATA ELEMENT
            
            my $doingLabels = 0;
            if( $autocomplete > 1 ) {
                #unless( $y % 2 ) {
                    $doingLabels = 1;
                    #}
            } else {
                $doingLabels = 1;
            }
        
            my $td_index = $session->make_element( "td" );
            my $td_label;
            my $testcounter=0;
            if( $doingLabels ) {
#print STDERR "counter:", $testcounter++;
                $td_label = $session->make_element( "td", class=>"multi_compound_label" );
            } else {
                $td_label = $session->make_element( "td" );
            }
            my $td_arrows = $session->make_element( "td" );
            
            # HERE, WE ONLY WANT TO PUT LABELS INTO ACTUAL FIELDS
            # IF THERE IS AN AUTOCOMPLETE, THEN THAT IS EVERY OTHER ELEMENT EXCEPT THE LAST ONE
            # IF THERE IS NO AUTOCOMPLETE, THEN THAT IS EVERY ELEMENT EXCEPT THE LAST ONE
            # WE KNOW HOW MANY ACTUAL ELEMENTS THERE ARE
            # AND WE KNOW WHETHER THERE IS AN AUTOCOMPLETE

            # SECOND FILTER -- DO NOT APPLY LABELS TO MORE_ROWS
            if( $y < ( $numElements * $autocomplete )) {
            
                if( $doingLabels ) {
                    # FINALLY, WHERE THE LABELS SHOULD APPEAR IS OFFSET FROM THE ARRAY INDICES BY 1
                    # PLUS, AT THIS POINT X HAS ALREADY BEEN INCREMENTED

                    if( $x - 2 == $labelsIndex ) {
                        if( defined( @{$col_titles}[$labelsIndex] ) ) {
                            # IF THIS IS THE LAST FIELD IN THE SET (THAT IS, THE FIELD BEFORE THE ARROWS)
                            # THEN WE WANT TO STASH THE LABEL AND USE IT IN THE ARROWS ROW
                            if( $x - 1 == $numLabels ) {
                                $td_label_STASH = @{$col_titles}[$labelsIndex];
#                                print STDERR "stashed:",$td_label_STASH->toString(), "\n";
                            # IF THIS IS NOT THE LAST FIELD, THEN WE WANT TO GO AHEAD AND USE THE LABEL
                            } else {
                
                            #    my $label = EPrints::Utils::tree_to_utf8( @{$col_titles}[$labelsIndex] );
                                $td_label->appendChild( @{$col_titles}[$labelsIndex] );
                            }
                        }
                        # IF WE'RE DOING LABELS, THEN IF WE'RE DOING THE FIRST LABEL WE WANT TO 
                        # PUT THE STASHED INDEX IN THE LEFT-MOST COLUMN
                        if( $labelsIndex == 0 ) {
                            $td_index->appendChild( $td_index_STASH );
                        }
                        # ONLY INCREMENT THE TITLES INDEX IF WE'VE ACTUALLY DONE A TITLE
                        $labelsIndex++;
                    }
                }
            }

            my $td_field;
            if( $doingArrows ) {
                $td_field = $session->make_element( "td", %opts, style=>"border-bottom: dashed #bbf 1px; padding-bottom: 15px; text-align: left; font-weight: bold;" );
            } else {
                $td_field = $session->make_element( "td", %opts );
            }
            if( defined $item->{el} ) {
                # IF THIS IS THE LAST FIELD IN THE SET (THAT IS, THE FIELD BEFORE THE ARROWS)
                # THEN WE WANT TO STASH THE FIELD AND USE IT IN THE ARROWS ROW
                if( $x - 1 == $numLabels ) {
                    if( defined $item->{el} ) {
                        $td_field_STASH = $item->{el};
                    }
                # IF THIS IS NOT THE LAST FIELD, THEN WE WANT TO GO AHEAD AND USE THE ELEMENT
                } else {

                    # IF THIS IS THE ARROWS ROW
                    # USE THE STASHED LABEL FOR THE ROW ABOVE IN THE LABEL CELL
                    # PUT THE ARROWS IN THE ARROWS CELL
                    # PUT THE STASHED FIELD FOR THE ROW ABOVE IN THE FIELD CELL

                    if( $doingArrows ) {

                        $td_index = $session->make_element( "td", style=>"border-bottom: dashed #bbf 1px; padding-bottom: 15px;" );
                        # $td_label = $session->make_element( "td", style=>"border-bottom: dashed #bbf 1px; border-left: 1px dashed #BBBBFF; padding-bottom: 15px; text-align: right; font-weight: bold;" );
                        $td_label = $session->make_element( "td", style=>"border-bottom: dashed #bbf 1px; border-left: 1px dashed #BBBBFF; padding-bottom: 15px; text-align: left; font-weight: bold;" );
                        $td_arrows = $session->make_element( "td", style=>"border-bottom: dashed #bbf 1px; padding-bottom: 15px;" );

                        $td_label->appendChild( $td_label_STASH );
                        $td_field->appendChild( $td_field_STASH );
                        $td_arrows->appendChild( $item->{el} );

                    } else {

                        # IF THIS IS THE INDEX ROW THEN WE WANT TO STASH THE ELEMENT FOR USE NEXT TIME ROUND
                        if( $x - 1 == 0 ) {
                            $td_index_STASH = $item->{el};
                        # OTHERWISE JUST USE THE ELEMENT AS NATURE INTENDED
                        } else {
                            $td_field->appendChild( $item->{el} );
                        }
                    }
                }
            }

            $tr->appendChild( $td_index );
            $tr->appendChild( $td_label );
            $tr->appendChild( $td_field );
            $tr->appendChild( $td_arrows );

            $table->appendChild( $tr );
            $rownum++;
        }
        $y++;
    }


##Block of code that make autocomplete work
    my $extra_params = URI->new( 'http:' );
    $extra_params->query( $self->{input_lookup_params} );
    my @params = (
        $extra_params->query_form,
        field => $self->name
    );
    if( defined $obj )
    {
        push @params, dataobj => $obj->id;
    }
    if( defined $self->{dataset} )
    {
        push @params, dataset => $self->{dataset}->id;
    }
    $extra_params->query_form( @params );
    $extra_params = "&" . $extra_params->query;

    my $componentid = substr($basename, 0, length($basename)-length($self->{name})-1);
    my $url = EPrints::Utils::js_string( $self->{input_lookup_url} );
    my $params = EPrints::Utils::js_string( $extra_params );
    $table->appendChild( $session->make_javascript( <<EOJ ) );
new Metafield ('$componentid', '$self->{name}', {
    input_lookup_url: $url,
    input_lookup_params: $params
});
EOJ
##end Block - autocomplete


    return $table;

}


