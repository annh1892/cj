#!/bin/bash

# enable xdebug if ENV variable TK_XDEBUG_ENABLED == 1
_init_xdebug() {
  local _xdebug_enableb=0
  [[ -n "${TK_XDEBUG_ENABLED:-}" ]]   && _xdebug_enableb=$TK_XDEBUG_ENABLED

  echo ":: initializing xdebug config (_xdebug_enableb=${_xdebug_enableb})"

  if [[ $_xdebug_enableb == 1 ]] ; then
    echo -e "zend_extension=xdebug.so\nxdebug.remote_enable = on" > /etc/php/7.0/mods-available/xdebug.ini
    ln -svf /etc/php/7.0/mods-available/xdebug.ini /etc/php/7.0/cli/conf.d/20-xdebug.ini
    ln -svf /etc/php/7.0/mods-available/xdebug.ini /etc/php/7.0/fpm/conf.d/20-xdebug.ini
  fi
}

# if ENV variable TK_IS_WORKER == 1
# -> only start worker process (dont start nginx, php-fpm)
_init_worker() {
  local _is_worker=${TK_IS_WORKER:-0}
  echo ":: initializing worker config (_is_worker=${_is_worker})"

  if [[ $_is_worker == 1 ]] ; then
    sed -i 's#autostart=.*#autostart=false#g' /etc/supervisord.conf  # dont start nginx, php-fpm
    # include worker config
    [[ -d /etc/supervisor.d ]] || mkdir -v /etc/supervisor.d
    grep -q include /etc/supervisord.conf \
    || echo -e "[include]\nfiles = /etc/supervisor.d/*.conf\n" >> /etc/supervisord.conf
  fi
}


# config td-agent to send log to remote server
# td-agent config:
#   TK_TDAGENT_CENTRAL=fluentd.example.com
#
_init_tdagent(){
  local _tdagent_central=${TK_TDAGENT_CENTRAL:-uat.fluentd.tiki.services}
  local _f_conf="/etc/td-agent/td-agent.conf"
  echo ":: initializing td-agent config (central server: ${_tdagent_central})"

  sed -i "s#host 1.2.3.4#host ${_tdagent_central}#g" $_f_conf
}

# Run helper function if passed as parameters
# Otherwise start supervisord
if [[ -n "$@" ]]; then
  $@
else
  _init_xdebug  # for corveralls.io ...
  _init_worker
  _init_tdagent
fi
