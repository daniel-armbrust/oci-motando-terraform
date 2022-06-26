#!/bin/bash
#
# scripts/orlinux_init.sh - Prepare the Oracle Linux instance to receive the Motando
# application.
#

# Update the OS and install NGINX.
yum -y update
yum -y install nginx git

# Disable SELinux.
setenforce permissive
sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

#
# /etc/nginx/nginx.conf
#
cat <<EOF >/etc/nginx/nginx.conf
    user nginx;
    worker_processes auto;
    worker_rlimit_nofile 100000;
    error_log /var/log/nginx/error.log;
    pid /run/nginx.pid;

    # Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
    include /usr/share/nginx/modules/*.conf;

    events {
        worker_connections 4000;
    }

    http {
        log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                        '\$status \$body_bytes_sent "\$http_referer" '
                        '"\$http_user_agent" "\$http_x_forwarded_for"';

        disable_symlinks on;

        # https://gist.github.com/denji/8359866
        # https://gist.github.com/plentz/6737338

        access_log                  off;
        sendfile                     on;
        tcp_nopush                   on;
        tcp_nodelay                  on;
        keepalive_timeout            65;
        types_hash_max_size        2048;
        reset_timedout_connection    on;

        server_tokens off;
        add_header X-Frame-Options SAMEORIGIN;
        add_header X-Content-Type-Options nosniff;
        add_header X-XSS-Protection "1; mode=block";

        open_file_cache max=200000 inactive=20s;
        open_file_cache_valid 30s;
        open_file_cache_min_uses 2;
        open_file_cache_errors on;

        client_body_buffer_size  128k;
        client_header_buffer_size 3m;
        large_client_header_buffers 4 256k;

        include             /etc/nginx/mime.types;
        default_type        application/octet-stream;

        server {
            charset      UTF-8;
            listen       80 default_server;
            listen       [::]:80 default_server;
            server_name  motando.ocibook.com.br;
            root         /srv/motando-ocibook-com-br;

            location / {
            index index.html;

            # https://gist.github.com/dd-han/11d39170d968f34b9de0fe4ccf7ca1e6
            # set \$mobile_rewrite variable
            set \$mobile_rewrite do_not_perform;

            if (\$http_user_agent ~* "(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino") {
                set \$mobile_rewrite perform;
            }

            if (\$http_user_agent ~* "^(1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-)") {
                set \$mobile_rewrite perform;
            }

            # check if query arg = yes (example.com?mobile=yes), set variable
            if (\$arg_mobile = 'yes') {
                    add_header Set-Cookie mobile=yes;
                    set \$mobile_rewrite perform;
            }

            # check if cookie mobile=yes, set variable
            if (\$cookie_mobile = 'yes') {
                    set \$mobile_rewrite perform;
            }

            # check if cookie mobile=no, break
            if (\$cookie_mobile = 'no') {
                    set \$mobile_rewrite do_not_perform;
            }

            # check if query arg = no (example.com?mobile=no), break
            if (\$arg_mobile = 'no') {
                    add_header Set-Cookie mobile=no;
                    set \$mobile_rewrite do_not_perform;
            }

            # if \$mobile_rewrite = perform, do the redirect
            if (\$mobile_rewrite = perform) {
                    return 302 https://motando.ocibook.com.br/m\$uri;
                    #rewrite ^ http://m.example.com\$request_uri? redirect;
                    #rewrite ^ https://motando.ocibook.com.br/m\$uri? redirect;
            }
            }

            # Mobile Location
            location /m {
            disable_symlinks off;
            #index index.html;
            }

            #error_page 404 /404.html;
            #    location = /40x.html {
            #}

            #error_page 500 502 503 504 /50x.html;
            #    location = /50x.html {
            #}
        }
    }
EOF


# Remove NGINX default html directory.
test -d /usr/share/nginx/html/ && rm -rf /usr/share/nginx/html/

#
# Motando Deploy
#
mkdir -p /srv/motando-ocibook-com-br
cd /srv/motando-ocibook-com-br/
git clone https://github.com/daniel-armbrust/oci-motando-jquery.git .
rm -rf .git/ .gitignore LICENSE README.md

# HTML Minify
find . -name "*.html" -print | while read html_file ; do 
   sed ':a;N;$!ba;s/>\s*</></g' -i "$html_file"
done

# Enable and Start NGINX.
systemctl start nginx
systemctl enable nginx

# Firewall (open 80/TCP).
firewall-cmd --add-service=http --permanent
firewall-cmd --reload
firewall-cmd --runtime-to-permanent

exit 0