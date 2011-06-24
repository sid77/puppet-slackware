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

# Keep same perms on rc.puppet.new:
if [ -e etc/rc.d/rc.puppet ]; then
  cp -a etc/rc.d/rc.puppet etc/rc.d/rc.puppet.new.incoming
  cat etc/rc.d/rc.puppet.new > etc/rc.d/rc.puppet.new.incoming
  mv etc/rc.d/rc.puppet.new.incoming etc/rc.d/rc.puppet.new
fi

# Keep same perms on rc.puppetmaster.new:
if [ -e etc/rc.d/rc.puppetmaster ]; then
  cp -a etc/rc.d/rc.puppetmaster etc/rc.d/rc.puppetmaster.new.incoming
  cat etc/rc.d/rc.puppetmaster.new > etc/rc.d/rc.puppetmaster.new.incoming
  mv etc/rc.d/rc.puppetmaster.new.incoming etc/rc.d/rc.puppetmaster.new
fi

config etc/rc.d/rc.puppet.new
config etc/rc.d/rc.puppet.conf.new
config etc/rc.d/rc.puppetmaster.new
config etc/rc.d/rc.puppetmaster.conf.new
config etc/puppet/auth.conf.new

