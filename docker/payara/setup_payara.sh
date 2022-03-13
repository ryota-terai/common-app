#!/bin/sh

asadmin --user admin --passwordfile /opt/payara/passwordFile add-resources glassfish-resources.xml
asadmin --user admin --passwordfile /opt/payara/passwordFile add-resources glassfish-resources2.xml
asadmin --user admin --passwordfile /opt/payara/passwordFile deploy GISApp.ear
asadmin --user admin --passwordfile /opt/payara/passwordFile deploy COMMONApp.ear
