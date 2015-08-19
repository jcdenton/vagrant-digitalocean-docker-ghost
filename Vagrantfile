ENV['VAGRANT_DEFAULT_PROVIDER'] ||= 'digital_ocean'
ENV['GHOST_BLOG_NAME'] ||= 'ghost-blog'

Vagrant.configure('2') do |config|
  config.env.enable
  config.vm.define ENV['VAGRANT_MACHINE_NAME'] do end

  config.vm.provider :digital_ocean do |provider, override|
    provider.image = 'docker'
    provider.region = 'lon1'
    provider.size = '512mb'
    provider.token = ENV['DIGITALOCEAN_API_KEY']

    override.ssh.private_key_path = ENV['DIGITALOCEAN_SSH_KEY_NAME']
    override.vm.box = 'digital_ocean'
    override.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'
  end

  config.vm.provision 'docker' do |docker|
    docker.pull_images 'jwilder/nginx-proxy'
    docker.run 'jwilder/nginx-proxy',
               args: '-d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro -t --name nginx-proxy'
  end

  config.vm.provision :shell, :inline => <<-EOB
    if [[ ! $(grep docker_utils.sh ~/.bashrc) ]]; then
      echo 'source /vagrant/docker_utils.sh' >> ~/.bashrc;
    fi

    # for the ones who didn't choose the domain yet
    GHOST_BLOG_HOST=#{ENV['GHOST_BLOG_HOST']}
    if [[ ! $GHOST_BLOG_HOST ]]; then GHOST_BLOG_HOST=$(curl -s icanhazip.com); fi

    docker pull ghost
    source /vagrant/docker_utils.sh
    addGhostBlog #{ENV['GHOST_BLOG_NAME']} $GHOST_BLOG_HOST
  EOB
end
