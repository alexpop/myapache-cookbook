# Hard-coded link to the EL6 binary of chef-client 11.16.4
#rpm -Uvh --oldpackage --replacepkgs "/mnt/share/chef/chef-11.16.4-1.el6.x86_64.rpm"

# Pick the right EL binary
major=`cat /etc/redhat-release | cut -d" " -f3 | cut -d "." -f1`
rpm -Uvh --oldpackage --replacepkgs "/mnt/share/chef/chef-12.3.0-1.el$major.x86_64.rpm"
