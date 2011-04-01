# Kingdom Assignment

Description goes here.

## License
This program is licensed under the GNU Lesser General Public License.
See License.txt for more information.

## Prerequisites
In order to install this gem you need to have several programs
installed:

 * Ruby either in version 1.8.7 or 1.9.2. The use of [JRuby](http://www.jruby.org/) (a Java implementation of Ruby) is recommended.
 * Git
 * cURL
 * MySQL
 
 In the following, the installation procedure is given for **Mac OS X** and **Ubuntu Linux 10.10**. The commands for Ubuntu also have been tested to work for **Debian Squeeze** although you should substitute apt-get by aptitude.

### Installing Git
An installer for Mac OS X can be obtained from the [official website](http://git-scm.com/). For any Linux distribution it is recommended that you use your system's package manager to install Git. Look for a package called git or git-core. For Ubuntu 10.10 the command is:

    sudo apt-get install git
    
### Installing cURL
Mac OS X comes with curl by default, on a Linux system, cURL can be obtained via the system's package manager. For Ubuntu 10.10 the command is:

    sudo apt-get install curl
    
### Installing JRuby
Very few distributions offer packages for the most recent version of JRuby.
The easiest way to install the most recent version of JRuby is via the [Ruby Version Manager](http://rvm.beginrescueend.com/) by Wayne E. Seguin.

Before you install RVM, make sure you have git and curl installed on your system.

RVM can be installed by calling:

    bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )

This will install RVM to .rvm in your home folder and print several instructions specific to your platform on how to finish the installation. Please pay close attention to the "dependencies" section and look for the part where it says something like this:

    # For Ruby (MRI & ree)  you should install the following OS dependencies:
    ruby: /usr/bin/apt-get install build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev

These are the requirements for building the normal C version of Ruby. However, many of those tools are also required for building the Java version of Ruby so it is advisable that you install all of these prerequisites. Please do not copy the commands from this file, look at the output of the RVM installer.

    sudo apt-get install build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev

If installing any of these packages gives you an error, consider updating your packages by using your system's update manager.

Next you need to install the tools that are specifically required for installing JRuby. The output of RVM might look like this:

    # For JRuby (if you wish to use it) you will need:
      jruby: /usr/bin/apt-get install curl g++ openjdk-6-jre-headless
      jruby-head: /usr/bin/apt-get install ant openjdk-6-jdk

It is recommended that you use the latest stable version of JRuby, not jruby-head. Accordingly, on Ubuntu 10.10 you have to install the following packages in order to use JRuby with RVM:

    apt-get install curl g++ openjdk-6-jre-headless
    
Next, you have to make sure that RVM is loaded when you start a new shell. Look for the part where it says: "You must now complete the install by loading RVM in new shells."

On Ubuntu 10.10 you can edit your .bashrc by calling:

    gedit .bashrc
    
On Mac OS X, you can type:

    open -a TextEdit .bash_profile

At the very end of this file add the following line:
    
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
    
Now save the file, close your editor and close your shell. Start a new shell and type:
    
    type rvm | head -1
    
If you see something like "rvm is a function" the installation was
successful. If you run into problems, read the
[documentation](http://rvm.beginrescueend.com/rvm/install/).

**The following command is not part of the installation procedure!**
You can always delete RVM and start from scratch by typing:

    rvm implode
     
Please note that this will delete all versions of Ruby you installed with RVM as well as all of the gems you installed. It will not reverse the changes you made to your shell's load configuration.

Now you can install JRuby by calling:
    
    rvm install jruby
    
Please note that everything RVM installs is placed in the folder .rvm in your home directory. Therefore, it is not necessary to use sudo when calling rvm.

In order to use JRuby instead of your system's Ruby version you must type
    
    rvm use jruby
    
every time you open a new shell. You can check which version you are currently using with:

    ruby -v
    
If you want to switch back to the version of Ruby that came with your system, type:

    rvm use system
    
In order to use JRuby as the default Ruby implementation on your system you can type:

    rvm --default use jruby
    
Now JRuby will be called when you type ruby in a new shell.

### Installing MySQL
Kingdom Assignment uses a MySQL database in order to store information from the [NCBI taxonomy database](ftp://ftp.ncbi.nih.gov/pub/taxonomy/) efficiently.

The database does not have to be hosted on the system that is running Kingdom Assignment, but it is advantageous for performance reasons.

The correct installation procedure for MySQL varies widely among different platforms. For many systems (like Mac OS X) binaries can be obtained from the [official website](http://www.mysql.com/downloads/mysql/). In the following, the setup under Ubuntu 10.10 is explained.

    sudo apt-get install mysql-server

On Mac OS X, you can install the MySQL preference pane and start the server from there. The MySQL binaries are at /usr/local/mysql/bin/. In order to be able to execute the following examples without having to prefix this path every time, you can add aliases to your bash configuration:

    open -a TextEdit .bash_profile
    
Now add the following lines at the end:

    alias mysql=/usr/local/mysql/bin/mysql
    alias mysqladmin=/usr/local/mysql/bin/mysqladmin
    
Refer to the ReadMe file that comes with the MySQL installer if you are using tclsh instead of bash.

### Starting the database
Usually the MySQL setup creates an administrator account named "root" with
an empty password. If your administrator name is different or you have
set a password, you must adjust the commands in the next section accordingly.
You can now start MySQL by typing
    
    sudo service mysql start

## NCBI taxonomy database
In this step you will download the latetst taxonomy database and transfer it to the MySQL database.

### Setting up the taxonomy database
Now set up the database for the NCBI taxonomy:

    curl http://biosql.org/DIST/biosql-1.0.1.tar.gz -o biosql-1.0.1.tar.gz
    tar -xzvf biosql-1.0.1.tar.gz
    mysql -u root -e "CREATE DATABASE ncbi_taxonomy"
   
Next, you need to set up the Bio-SQL schema. Unfortunately, BioSQL 1.0.1 is only compatible with MySQL <= 5.1 because it still uses TYPE=INNODB when creating tables. You can check if an [updated version is available](http://www.biosql.org/) or use the following command to fix the issue:

    sed 's/TYPE=INNODB/ENGINE=INNODB/g' biosql-1.0.1/sql/biosqldb-mysql.sql > biosql-1.0.1/sql/biosqldb-mysql5-5.sql

You can apply the schema with:

    mysql -u root ncbi_taxonomy -p < biosql-1.0.1/sql/biosqldb-mysql5-5.sql

Now you need to download the latest taxonomy dump from NCBI an use a schript provided by BioSQL to load it into the database:

    curl ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz -o taxdump.tar.gz
    mkdir taxdata
    tar -xzvf taxdump.tar.gz -C taxdata
    perl biosql-1.0.1/scripts/load_ncbi_taxonomy.pl --dbname ncbi_taxonomy --dbuser root --directory taxdata
    
Loading all the taxonomy data into the database will take up to an hour.
If the last command gives you an error like:

    install_driver(mysql) failed: Can't locate DBD/mysql.pm

You need to install the MySQL database driver for Perl first.
On Mac OS X, use the following commands:

    export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/
    sudo perl -MCPAN -e 'install DBI'
    sudo perl -MCPAN -e 'force ("install","DBD::mysql")'

On Ubuntu 10.10, you can install the corresponding package:

    sudo apt-get install libdbd-mysql-perl

Now, you can try executing a query to make sure everything worked as intendend:

    mysql -u root -D ncbi_taxonomy -e "SELECT taxon_id FROM taxon_name WHERE name='Homo sapiens';"

This should result in an output like this, giving you the NCBI taxonomy id of *Homo sapiens*. Please note that this id varies between different versions of the taxaonomy database:

    +---------------+
    | ncbi_taxon_id |
    +---------------+
    |          7869 |
    +---------------+


 There are additional parameters to this script you can use if needed
 (taken from load\_ncbi\_taxonomy.pl):
 
    --dbname     # name of database to use
    --dsn        # the DSN of the database to connect to
    --driver     # "mysql", "Pg", "Oracle" (default "mysql")
    --host       # optional: host to connect with
    --port       # optional: port to connect with
    --dbuser     # optional: user name to connect with
    --dbpass     # optional: password to connect with
    --download   # optional: whether to download new NCBI taxonomy data
    --directory  # optional: where to store/look for the data
    --schema     # optional: Pg only, load using given schema

## Installing Kingdom Assignment
This gem is distributed in source form for the time being, so you must build it yourself in order to use it. Don't worry, it's not hard:

First you must download the source code of this gem by going to a folder of your choice and typing:

    git clone git://github.com/PalMuc/Kingdom-Assignment.git

This will will clone a copy of this repository in a folder named Kingdom-Assignment. Go to this folder by typing:

    cd Kingdom-Assignment

Kingdom assignment is delivered as a Ruby gem. In order to build and install it, you first have to install another gem called bundler. Type:

    rvm jruby gem install bundler

In order to install the other gems Kingdom Assignment depends on, first switch to JRuby:
    
    rvm use jruby

Now go to the folder called kingdom-assignment and type:

    bundle install

Before you build an updated version of Kingdom Assignment, you should
delete previous builds by typing:

    rm pkg/kingdom-assignment-*.gem

After that, create a new Ruby gem by typing:

    rake install
    
Finally you can install the gem by typing:

    rvm jruby gem install pkg/kingdom-assignment-*.gem
    
Kingdom Assignment is now in your global path, meaning that from any point in the system you can use it by typing

    kingdom-assignment
    
on the command line. Please note that in order to do that you have to switch to JRuby as mentioned before.

## Using Kingdom Assignment

    kingdom-assignment out_3.xml output_file.csv localhost root NOPASSWORD ncbi_taxonomy your_email_address_for_the_NCBI

# Acknowledgements
Development of this program was supported by the [Molecular Geo- and Palaeobiology Lab](http://www.mol-palaeo.de/) of the Department of Earth and Environmental Sciences and the initiative "[Gleichstellung in Forschung und Lehre](http://www.frauenbeauftragte.uni-muenchen.de/foerdermoegl/lmu1/tg73/index.html)" of the Ludwig-Maximilians-University Munich (LMU).
