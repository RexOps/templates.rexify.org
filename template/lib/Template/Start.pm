package Template::Start;
use Mojo::Base 'Mojolicious::Controller';

sub index {
   my ($self) = @_;

   my $sth = $self->db->prepare("SELECT * FROM templates");
   $sth->execute;

   my @templates;

   while(my $row = $sth->fetchrow_hashref) {
      push(@templates, $row);
   }

   $self->respond_to(
      json => { json => \@templates },
      html => {template => "start/index"},
   );

}

1;
