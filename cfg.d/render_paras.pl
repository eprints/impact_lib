# EPrints Services package
# split field value into paragraphs
$c->{render_paras} = sub {
        my( $session, $field, $value, $object ) = @_;

        my $frag = $session->make_doc_fragment;

        # normalise newlines
        $value =~ s/(\r\n|\n|\r)/\n/gs;

        my @paras = split( /\n\n/, $value );
        foreach my $para( @paras )
        {
                $para =~ s/^\s*\n?//;
                $para =~ s/\n?\s*$//;
                next if $para eq "";

                my $p = $session->make_element( "p", class=>"ep_field_para" ); 

                my @lines = split( /\n/, $para );
                for( my $i=0; $i<scalar( @lines ); $i++ )
                {
                        $p->appendChild( $session->make_text( $lines[$i] ) );
                        $p->appendChild( $session->make_element( "br" ) ) unless $i == $#lines;
                }

                $frag->appendChild( $p );
        }

        return $frag;
}
