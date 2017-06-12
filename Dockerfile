# Image with Linux Oracle instant client. 

FROM php-56-rhel7
MAINTAINER Yun In Su <ora01000@time-gate.com>

# ADD . /tmp/

USER root
# RUN yum install -y libaio.x86_64 glibc.x86_64
# RUN yum -y localinstall /tmp/oracle* --nogpgcheck
COPY ./glibc-2.17-157.el7_3.1.x86_64.rpm /tmp
COPY ./libaio-0.3.109-13.el7.x86_64.rpm /tmp

# COPY ./openshift.repo /etc/yum.repos.d
# COPY ./redhat.repo /etc/yum.repos.d
# COPY ./pki /etc
# COPY ./rhsm /etc

COPY ./php56-php-devel-5.6.30-2.el7.remi.x86_64.rpm /tmp
COPY ./oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm /tmp
COPY ./oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm /tmp
COPY ./rh-php56-php-devel-5.6.25-1.el7.x86_64.rpm /tmp
COPY ./rh-php56-php-pecl-jsonc-devel-1.3.6-3.el7.x86_64.rpm /tmp

# RUN yum clean all && yum repolist
# RUN yum -y install glibc.x86_64 && yum clean all
# RUN yum -y install libaio.x86_64 && yum clean all
# RUN rpm -ivh --force /tmp/php56-php-devel-5.6.30-2.el7.remi.x86_64.rpm

RUN rpm -ivh --force /tmp/glibc-2.17-157.el7_3.1.x86_64.rpm
RUN rpm -ivh --force /tmp/libaio-0.3.109-13.el7.x86_64.rpm
RUN rpm -ivh --force /tmp/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
RUN rpm -ivh --force /tmp/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm
# RUN rpm -ivh --force /tmp/rh-php56-php-devel-5.6.25-1.el7.x86_64.rpm
# RUN rpm -ivh --force /tmp/rh-php56-php-pecl-jsonc-devel-1.3.6-3.el7.x86_64.rpm
RUN yum -y localinstall /tmp/rh-php* --nogpgcheck

RUN mkdir -p /usr/lib/oracle/12.1/client64/network/admin
RUN pecl install oci8-2.0.12
COPY ./tnsnames.ora /usr/lib/oracle/12.1/client64/network/admin/tnsnames.ora
COPY ./php.ini /opt/rh/rh-php56/register.content/etc/opt/rh/rh-php56/php.ini
COPY ./php.ini /etc/opt/rh/rh-php56/php.ini


ENV ORACLE_HOME=/usr/lib/oracle/12.1/client64
ENV PATH=$PATH:$ORACLE_HOME/bin:/opt/rh/rh-php56/root/usr/lib64/php/modules
ENV LD_LIBRARY_PATH=$ORACLE_HOME/lib:/opt/rh/rh-php56/root/usr/lib64/php/modules
ENV TNS_ADMIN=$ORACLE_HOME/network/admin

USER 1001

RUN echo "-----------------------------------"
RUN echo $STI_SCRIPTS_PATH
CMD $STI_SCRIPTS_PATH/usage

