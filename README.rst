Installation of potiro with vagrant
===================================


Installation of VirtualBox and Vagrant
--------------------------------------

.. code-block:: bash

    $ sudo apt-get install virtualbox vagrant


Installation of potiron
-----------------------

potiron will be automatically deployed in an Ubuntu Zesty Server.

.. code-block:: bash

    $ git clone https://github.com/cedricbonhomme/potiron-vagrant.git
    $ cd potiron-vagrant/
    $ vagrant up

Once the VM will be configured by Vagrant, go to the address
http://127.0.0.1:5001.
