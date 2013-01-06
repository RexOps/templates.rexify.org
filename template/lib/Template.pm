package Template;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
   my $self = shift;

   # DB
   $self->plugin("database", {
      dsn => "dbi:SQLite:dbname=db/template.db",
      username => "",
      password => "",
      helper => "db",
   });

   # Router
   my $r = $self->routes;

   # Normal route to controller
   $r->get("/")->to("start#index");
   $r->get("/index")->to("start#index");
}

1;
