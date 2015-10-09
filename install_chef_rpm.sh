# Pick the right EL binary
major=`cat /etc/redhat-release | cut -d" " -f3 | cut -d "." -f1`
rpm -Uvh --oldpackage --replacepkgs "/mnt/share/chef/chef-12.5.1-1.el$major.x86_64.rpm"
