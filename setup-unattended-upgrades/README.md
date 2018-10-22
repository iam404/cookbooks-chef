# unattended-upgrades Cookbook

Configure unattented upgrades on Ubuntu system.

# Default Attributes

* `['unattended-upgrades']['admin_email'] = 'root@localtest.me' `
* `['unattended-upgrades']['autofix_dpkg'] = true `
* `['unattended-upgrades']['install_on_shutdown'] = false`
* `['unattended-upgrades']['mail_only_on_error'] = false`
* `['unattended-upgrades']['automatic_reboot'] = false`
* `['unattended-upgrades']['allowed_origins'] = { 'security'  => true, 'updates'   => false, 'proposed'  => false, 'backports' => false }`
