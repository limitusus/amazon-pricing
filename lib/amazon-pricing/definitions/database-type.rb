#--
# Amazon Web Services Pricing Ruby library
#
# Ruby Gem Name::  amazon-pricing
# Author::    Joe Kinsella (mailto:joe.kinsella@gmail.com)
# Copyright:: Copyright (c) 2011-2013 CloudHealth
# License::   Distributes under the same terms as Ruby
# Home::      http://github.com/CloudHealth/amazon-pricing
#++

require 'amazon-pricing/definitions/category-type'

module AwsPricing
  class DatabaseType < CategoryType

    @@Database_Name_Lookup = {
      'mysql_standard'          => 'MySQL Community Edition',
      'mysql_multiaz'           => 'MySQL Community Edition (Multi-AZ)',
      'postgresql_standard'     => 'PostgreSql Community Edition(Beta)',
      'postgresql_multiaz'      => 'PostgreSql Community Edition(Beta) (Multi-AZ)',
      'oracle_se1_standard'     => 'Oracle Database Standard Edition One',
      'oracle_se1_multiaz'      => 'Oracle Database Standard Edition One (Multi-AZ)',
      'oracle_se1_byol'         => 'Oracle Database Standard Edition One (BYOL)',
      'oracle_se1_byol_multiaz' => 'Oracle Database Standard Edition One (BYOL Multi-AZ)',
      'oracle_se_byol'          => 'Oracle Database Standard Edition (BYOL)',
      'oracle_se_byol_multiaz'  => 'Oracle Database Standard Edition (BYOL Multi-AZ)',
      'oracle_ee_byol'          => 'Oracle Database Enterprise Edition (BYOL)',
      'oracle_ee_byol_multiaz'  => 'Oracle Database Enterprise Edition (BYOL Multi-AZ)',
      'sqlserver_ex'            => 'Microsoft SQL Server Express Edition',
      'sqlserver_web'           => 'Microsoft SQL Server Web Edition',
      'sqlserver_se_standard'   => 'Microsoft SQL Server Standard Edition',
      'sqlserver_se_multiaz'    => 'Microsoft SQL Server Standard Edition (Multi-AZ)',
      'sqlserver_se_byol'       => 'Microsoft SQL Server Standard Edition (BYOL)',
      'sqlserver_se_byol_multiaz' => 'Microsoft SQL Server Standard Edition (BYOL Multi-AZ)',
      'sqlserver_ee_standard'     => 'Microsoft SQL Server Enterprise Edition',
      'sqlserver_ee_multiaz'      => 'Microsoft SQL Server Enterprise Edition (Multi-AZ)',
      'sqlserver_ee_byol'         => 'Microsoft SQL Server Enterprise Edition (BYOL)',
      'sqlserver_ee_byol_multiaz' => 'Microsoft SQL Server Enterprise Edition (BYOL Multi-AZ)',
      'aurora_standard'         => 'Amazon Aurora',
      'mariadb_standard'        => 'MariaDB',
      'mariadb_multiaz'         => 'MariaDB (Multi-AZ)',

      # Oracle SE2 BYOL prices are copied from Enterprise BYOL prices and not collected
      # (so no need to add rds-price-list.rb)
      'oracle_se2_byol'         => 'Oracle Database Standard Edition Two (BYOL)',
      'oracle_se2_byol_multiaz' => 'Oracle Database Standard Edition Two (BYOL Multi-AZ)',
    }

    @@Display_Name_To_Qualified_Database_Name = @@Database_Name_Lookup.invert

    @@ProductDescription = {
      'mysql'                    => 'mysql_standard',
      'mysql_multiaz'            => 'mysql_multiaz',
      'postgres'                 => 'postgresql_standard',
      'postgres_multiaz'         => 'postgresql_multiaz',
      'postgresql'               => 'postgresql_standard',
      'postgresql_multiaz'       => 'postgresql_multiaz',
      'oracle-se1(li)'           => 'oracle_se1_standard',
      'oracle-se1(byol)'         => 'oracle_se1_byol',
      'oracle-se1(li)_multiaz'   => 'oracle_se1_multiaz',
      'oracle-se1(byol)_multiaz' => 'oracle_se1_byol_multiaz',
      'oracle-se(byol)'          => 'oracle_se_byol',
      'oracle-ee(byol)'          => 'oracle_ee_byol',
      'oracle-se(byol)_multiaz'  => 'oracle_se_byol_multiaz',
      'oracle-ee(byol)_multiaz'  => 'oracle_ee_byol_multiaz',
      'sqlserver-ee(byol)'       => 'sqlserver_ee_byol',
      'sqlserver-ee(byol)_multiaz' => 'sqlserver_ee_byol_multiaz',
      'sqlserver-ee(li)'         => 'sqlserver_ee_standard',
      'sqlserver-ee(li)_multiaz' => 'sqlserver_ee_multiaz',
      'sqlserver-ex(li)'         => 'sqlserver_ex',
      'sqlserver-se(byol)'       => 'sqlserver_se_byol',
      'sqlserver-se(byol)_multiaz' => 'sqlserver_se_byol_multiaz',
      'sqlserver-se(li)'         => 'sqlserver_se_standard',
      'sqlserver-se(li)_multiaz' => 'sqlserver_se_multiaz',
      'sqlserver-web(li)'        => 'sqlserver_web',
      'aurora'                   => 'aurora_standard',
      'mariadb'                  => 'mariadb_standard',
      'mariadb_multiaz'          => 'mariadb_multiaz',

      # Oracle SE2 BYOL prices are copied from Enterprise BYOL prices and not collected
      # (so no need to add rds-price-list.rb)
      'oracle-se2(byol)'         => 'oracle_se2_byol',
      'oracle-se2(byol)_multiaz' => 'oracle_se2_byol_multiaz',
    }

    @@DB_Deploy_Types = {
      :mysql        => [:standard, :multiaz],
      :postgresql   => [:standard, :multiaz],
      :oracle_se1   => [:standard, :multiaz, :byol, :byol_multiaz],
      :oracle_se    => [:byol, :byol_multiaz],
      :oracle_ee    => [:byol, :byol_multiaz],
      :sqlserver_se => [:standard, :multiaz, :byol, :byol_multiaz],
      :sqlserver_ee => [:byol, :byol_multiaz, :standard, :multiaz],
      :aurora       => [:standard],
      :mariadb      => [:standard, :multiaz],

      # oracle_se2 prices are copied, not collected
      :oracle_se2   => [:byol, :byol_multiaz],
    }

  	def self.display_name(name)
	    @@Database_Name_Lookup[name]
  	end

  	def self.get_database_name
      [:mysql, :postgresql, :oracle_se1, :oracle_se, :oracle_ee, :sqlserver_ex, :sqlserver_web,
        :sqlserver_se, :sqlserver_ee, :aurora, :mariadb,
        :oracle_se2 # oracle_se2 prices are copied, not collected
      ]
  	end

  	def self.get_available_types(db)
  	  @@DB_Deploy_Types[db]
  	end

  	def self.db_mapping(product, is_multi_az)
      if is_multi_az
        display_name(@@ProductDescription["#{product}_multiaz"])
      else
        display_name(@@ProductDescription["#{product}"])
	    end
    end

    def self.display_name_to_qualified_database_name(display_name)
      database_name = @@Display_Name_To_Qualified_Database_Name[display_name]
      if database_name.nil?
        raise "Unknown display_name '#{display_name}'.  Valid names are #{@@Display_Name_To_Qualified_Database_Name.keys.join(', ')}"
      end
      database_name
    end

    def self.display_name_to_database_name(display_name)
      database_name = self.display_name_to_qualified_database_name(display_name)
      database_name.gsub('_standard', '').gsub('_multiaz', '').gsub('_byol', '')
    end

    def self.display_name_is_multi_az?(display_name)
      database_name = self.display_name_to_qualified_database_name(display_name)
      database_name.include? 'multiaz'
    end

    def self.display_name_is_byol?(display_name)
      database_name = self.display_name_to_qualified_database_name(display_name)
      database_name.include? 'byol'
    end

  	def display_name
	    self.class.display_name(name)
	  end
  end
end
