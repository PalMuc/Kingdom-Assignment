require 'helper'

class BlackBoxTest < Test::Unit::TestCase
  def test_without_parameters
    #This test does not make a whole lot of sense...
    result = %x[bin/kingdom-assignment]
    expected = "Usage: kingdom-assignment input_file.xml output_file.csv database_server database_user password database_name email_for_ncbi_lookup
The command line parameters are:
1. The output of the BLASTplus alignment in XML format
2. The name of the output table in CSV format
3. The address of the MySQL database server
4. The name of the database user
5. The password of the database user, use NOPASSWORD if you have not set a database password.
6. The name of the NCBI taxonomy database
7. Your email address, needed for NCBI server access. You don't have to register your email address with the NCBI first
"
    assert_equal expected, result
  end
  def test_small
    %x[bin/kingdom-assignment test/data/in_3.xml test/data/out_3.csv localhost root NOPASSWORD ncbi_taxonomy ncbi@volton.otherinbox.com]
    result = File.open("test/data/out_3.csv").read
    target = File.open("test/data/target_3.csv").read

    assert_not_nil result
    assert_not_nil target

    assert_equal target, result, "Output of out_3.xml invalid"
  end
  
end

