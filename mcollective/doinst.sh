config() {
  NEW="$1"
  OLD="`dirname $NEW`/`basename $NEW .new`"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Keep same perms on rc.mcollective.new:
if [ -e etc/rc.d/rc.mcollective ]; then
  cp -a etc/rc.d/rc.mcollective etc/rc.d/rc.mcollective.new.incoming
  cat etc/rc.d/rc.mcollective.new > etc/rc.d/rc.mcollective.new.incoming
  mv etc/rc.d/rc.mcollective.new.incoming etc/rc.d/rc.mcollective.new
fi

config etc/mcollective/server.cfg.new
config etc/mcollective/client.cfg.new
config etc/mcollective/facts.yaml.new
config etc/mcollective/rpc-help.erb.new
config etc/rc.d/rc.mcollectived.new

