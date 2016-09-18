#!/bin/bash

# Set up colors
separator="\e[38;5;36m"
gray="\e[90m"
dataValue="\e[38;5;31m"
default="\e[38;5;231m"
reset="\e[0;49;39m"
banner="\e[38;5;36m"
error="\e[38;5;196m"
success="\e[38;5;2m"
bold="\e[1m"
normal="\e[22m"

OsVersionFull="$(cat /etc/centos-release)"
OsVersion="$(echo "$OsVersionFull" | head -n 1)"
IpPath="$(which ip 2>/dev/null)"
IpAddress="$(${IpPath} route get 8.8.8.8 | head -1 | cut -d' ' -f8)"
Kernel="$(uname -rs)"
Dmesg="$(dmesg)"
Dmi="$(echo "$Dmesg" | grep "DMI:")"
if [[ "$Dmi" = *"VirtualBox"* ]] ; then
    Platform="$(echo "$Dmi" | sed 's/^.*VirtualBox/VirtualBox/' | sed 's/ .*//')"
fi
ProcessCount="$(ps -Afl | wc -l)"
ProcessMax="$(ulimit -u)"
PhpVersion="$(/usr/bin/php -v 2>/dev/null | grep -oE '^PHP\s[0-9]+\.[0-9]+\.[0-9]+' | awk '{ print $2}')"
HttpdPath="$(which httpd 2>/dev/null)"
[[ ! -f $HttpdPath ]] && HttpdPath="/usr/sbin/apache2ctl"
[[ ! -f $HttpdPath ]] && HttpdPath="/usr/sbin/apache2"
if [[ (-f $HttpdPath) && (-x $HttpdPath) ]] ; then
    HttpdVersion="$(${HttpdPath} -v 2>/dev/null | grep "Server version" | sed -e 's/.*[^0-9]\([0-9].[0-9]\+.[0-9]\+\)[^0-9]*$/\1/')"
fi
MySqlVersion=""
MySqlDistribution=""
MySqlPath="$(which mysql 2>/dev/null)"
if [[ (-f $MySqlPath) && (-x $MySqlPath) ]] ; then
    MySqlString="$(${MySqlPath} --version 2>/dev/null)"
    MySqlVersion="$(echo "$MySqlString" | awk '{print $3}')"
    MySqlDistribution="$(echo "$MySqlString" | awk '{print $5}' | tr -d ',')"
fi
RubyVersion="$(ruby -v)"
NodeVersion="$(node --version)"
GruntVersion="$(grunt --version)"
GulpVersion="$(gulp --version)"
SassVersion="$(sass --version)"
CompassVersion="$(compass --version | head -n1)"

if [[ $server_type == 'wordpress' ]] ; then

    WPcliVersion="$(wp --version)"
    WPInstalled="$(wp core version --path='/vagrant')"
    if [[ -z "$WPInstalled" ]] ; then
        WPVersion="Not installed"
        WPVersion=$gray$WPVersion
        WPInstalled=false
    else
        WPVersion="${WPInstalled}"
        WPInstalled=true
        WPCoreCheckUpdate="$(wp core check-update --format=count ==path='/vagrant')"
        if [[ $WPCoreCheckUpdate > 0 ]] ; then
            WPCoreUpdate=true
        else
            WPCoreUpdate=false
        fi
        WPDatabaseRevision="$(wp core version --extra --path='/vagrant' | grep 'Database')"
        WPTotalPlugins="$(wp plugin list --format=count --path='/vagrant')"
        WPPluginUpdates="$(wp plugin list --field=update --path='/vagrant' | grep 'available' | wc -l)"
        WPTotalThemes="$(wp theme list --format=count --path='/vagrant')"
        WPThemeUpdates="$(wp theme list --field=update --path='/vagrant' | grep 'available' | wc -l)"
    fi

    awk '{print "      " $0}' /opt/wordpress.ascii

elif [[ $server_type == 'drupal' ]] ; then

    awk '{print "      " $0}' /opt/drupal.ascii

fi

echo -e "$gray"
echo " 888     888   d8888 .d8888b. 8888888b.      d8888888b    88888888888888"
echo " 888     888  d88888d88P  Y88b888   Y88b    d888888888b   888    888    "
echo " 888     888 d88P888888    888888    888   d88P88888888b  888    888    "
echo " Y88b   d88Pd88P 888888       888   d88P  d88P 888888Y88b 888    888    "
echo "  Y88b d88Pd88P  888888  888888888888PP  d88P  888888 Y88b888    888    "
echo "   Y88o88Pd88P   888888    888888 T88b  d88P   888888  Y88888    888    "
echo "    Y888Pd8888888888Y88b  d88P888  T88bd8888888888888   Y8888    888    "
echo "     Y8Pd88P     888  Y8888P88888   T8888P     888888    Y888    888    "

echo -e "$separator------------------------------------------------------------------------"
echo -e "$default IP Address$gray....... $default: $dataValue$IpAddress"
echo -e "$default Platform$gray......... $default: $dataValue$Platform"
echo -e "$default Processes$gray........ $default: $dataValue$ProcessCount$gray running processes of $dataValue$ProcessMax$gray maximum processes"
echo -e "$separator------------------------------------------------------------------------"
echo -e "$default Release$gray.......... $default: $dataValue$OsVersion"
echo -e "$default Kernel$gray........... $default: $dataValue$Kernel"
echo -e "$default Apache$gray........... $default: $dataValue$HttpdVersion"
echo -e "$default MySQL$gray............ $default: $dataValue$MySqlVersion$gray Distribution: $dataValue$MySqlDistribution"
echo -e "$default PHP$gray.............. $default: $dataValue$PhpVersion"
echo -e "$separator------------------------------------------------------------------------"
echo -e "$default Ruby$gray............. $default: $dataValue${RubyVersion:5:9}"
echo -e "$default Node$gray............. $default: $dataValue${NodeVersion:1}"
echo -e "$default Grunt$gray............ $default: $dataValue${GruntVersion:11}"
echo -e "$default Gulp$gray............. $default: $dataValue${GulpVersion:23}"
echo -e "$default Sass$gray............. $default: $dataValue${SassVersion:5}"
echo -e "$default Compass$gray.......... $default: $dataValue${CompassVersion:8}"
echo -e "$separator------------------------------------------------------------------------"

if [[ $server_type == 'wordpress' ]] ; then

    echo -e "$default WP-CLI$gray........... $default: $dataValue${WPcliVersion:7}"
    if [[ $WPCoreUpdate = true ]] ; then
    echo -e "$default WordPress$gray........ $default: $dataValue${WPVersion}$gray (${error}Update Available!{$gray})"
    else
    echo -e "$default WordPress$gray........ $default: $dataValue${WPVersion}$gray (${success}This is the latest version${gray})"
    fi
    if [[ $WPInstalled = true ]] ; then
    echo -e "$default Database Revision$gray $default: $dataValue${WPDatabaseRevision:19}"
    fi
    if [[ $WPTotalPlugins > 0 ]] ; then
    echo -e "$default Plugins$gray.......... $default: $dataValue$WPTotalPlugins$gray plugins installed, $dataValue$WPPluginUpdates$gray updates available"
    fi
    if [[ $WPTotalThemes > 0 ]] ; then
    echo -e "$default Themes$gray........... $default: $dataValue$WPTotalThemes$gray themes installed, $dataValue$WPThemeUpdates$gray updates available"
    fi
    echo -e "$separator------------------------------------------------------------------------"

fi

echo -e "$reset"
