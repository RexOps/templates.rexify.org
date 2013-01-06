package Template;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
   my $self = shift;


   my @cfg = ("/etc/rex/template-server.conf", "/usr/local/etc/rex/template-server.conf", "template-server.conf");
   my $cfg;
   for my $file (@cfg) {
      if(-f $file) {
         $cfg = $file;
         last;
      }
   }
   $self->plugin('Config', file => $cfg);

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
