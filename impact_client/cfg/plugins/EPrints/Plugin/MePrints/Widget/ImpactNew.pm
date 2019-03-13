package EPrints::Plugin::MePrints::Widget::ImpactNew;

use EPrints::Plugin::MePrints::Widget;
@ISA = ( 'EPrints::Plugin::MePrints::Widget' );

use strict;
use LWP::Simple qw(get);

sub new
{
	my( $class, %params ) = @_;
	
	my $self = $class->SUPER::new(%params);

	$self->{name} = "Impact - Create";
	$self->{visible} = "all";
	$self->{advertise} = 1;

	# $self->{surround} = 'Simple';
	$self->{render_title} = 1;
	$self->{show_in_controls} = 1;

	$self->{impact_repo} = "http://impact.eprints-hosting.org/";
	return $self;	
}

sub render_content
{
	my( $self ) = @_;

	my $session = $self->{session};
	my $user = $self->{user};

	my $frag = $session->make_doc_fragment;

	my $form = $session->render_form( "GET", $self->{impact_repo} . "/cgi/users/home");
	my $hidden_field = $session->make_element("input", "name"=>"screen", "id"=>"screen", "value"=>"NewEPrint", "type"=>"hidden");
	my $button = $session->make_element( "input",
		name => "impact_submit",
		id => "impact_submit",
		value => "Create",
		type => "submit",
	);

	$form->appendChild( $hidden_field );
	$form->appendChild( $button );
	$frag->appendChild( $form );
	$frag->appendChild( $session->make_text( "Create a new impact record" ) );

	return $frag;
}

1;

