# ESMOS Odoo Production - V2
FROM odoo:17.0

USER root

RUN apt-get update && apt-get install -y git

RUN pip3 install num2words xlwt

RUN mkdir -p /etc/odoo /mnt/extra-addons /var/lib/odoo/filestore

RUN git clone --depth 1 --branch 17.0 \
    https://github.com/OCA/helpdesk.git \
    /tmp/oca-helpdesk && \
    cp -r /tmp/oca-helpdesk/helpdesk_mgmt /mnt/extra-addons/ && \
    cp -r /tmp/oca-helpdesk/helpdesk_mgmt_project /mnt/extra-addons/ && \
    cp -r /tmp/oca-helpdesk/helpdesk_mgmt_sale /mnt/extra-addons/ && \
    cp -r /tmp/oca-helpdesk/helpdesk_mgmt_merge /mnt/extra-addons/ && \
    cp -r /tmp/oca-helpdesk/helpdesk_ticket_related /mnt/extra-addons/ && \
    cp -r /tmp/oca-helpdesk/helpdesk_type /mnt/extra-addons/ && \
    rm -rf /tmp/oca-helpdesk

RUN touch /etc/odoo/odoo.conf
RUN echo "[options]" > /etc/odoo/odoo.conf && \
    echo "addons_path = /usr/lib/python3/dist-packages/odoo/addons,/mnt/extra-addons" >> /etc/odoo/odoo.conf && \
    echo "data_dir = /var/lib/odoo" >> /etc/odoo/odoo.conf && \
    echo "limit_time_cpu = 600" >> /etc/odoo/odoo.conf && \
    echo "limit_time_real = 1200" >> /etc/odoo/odoo.conf && \
    echo "db_maxconn = 64" >> /etc/odoo/odoo.conf && \
    echo "workers = 2" >> /etc/odoo/odoo.conf && \
    echo "max_cron_threads = 1" >> /etc/odoo/odoo.conf && \
    echo "admin_passwd = 214Odoo"

RUN chown -R odoo:odoo /etc/odoo /mnt/extra-addons /var/lib/odoo/filestore
RUN chmod 755 /etc/odoo /mnt/extra-addons /var/lib/odoo/filestore

USER odoo