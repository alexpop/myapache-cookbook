#
# Cookbook Name:: myapache-cookbook
# Recipe:: audit_recipe_dev
#

# Attribute to prevent System Requirements checks
if node['myapache-cookbook']['check']['system_requirements']
  # Get the available space in the /opt directory by shelling out
  disk_free_cmd = "df /opt | awk '$3 ~ /[0-9]+/ { print $3 }'"
  disk_free_mb = Mixlib::ShellOut.new(disk_free_cmd).run_command.stdout.to_i / 1024

  # The `node` object is not available in the audit DSL.
  # Using local variables to access the ohai collected cpu and memory details
  cpu_total = node['cpu']['total']
  memory_free_mb = node['memory']['free'].gsub(/kB$/i, '').to_i / 1024

  # Define the CPU, Memory and Disk tests
  control_group "System Requirements" do
    control "CPU" do
      it "should have at least two cores" do
        expect(cpu_total).to be >= 1
      end
    end
    control "Memory" do
      it "should be at least 400MB free" do
        expect(memory_free_mb).to be >= 400
      end
    end
    control "Disk" do
      it "should have at least 1GB available in /opt" do
        expect(disk_free_mb).to be >= 1024
      end
    end
  end
else
  Chef::Log.info("*** Skipping system requirements checks")
end