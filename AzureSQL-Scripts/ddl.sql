CREATE TABLE Meta.File_Template (
    file_template_id int NOT NULL identity(1001,1),
    file_created_datetime datetime,
    file_expiry_datetime datetime,
 file_description nvarchar(255),
    PRIMARY KEY (file_template_id),
 
);

CREATE TABLE Meta.Data_Type_Master (
    data_type_id int NOT NULL identity(1,1),
    datatype varchar(255),
 data_format varchar (255),
    PRIMARY KEY (data_type_id ),

 );

CREATE TABLE Meta.File_Column_Template (
    file_template_id int NOT NULL,
    file_column_template_id int identity(10001,1),
    column_name varchar(255),
 data_type_id int,
 file_column_length int,
 column_description varchar(255),
 source_column_name varchar(255),
 creation_datetime datetime,
 expiry_datetime datetime,
 PRIMARY KEY (file_column_template_id),
 FOREIGN KEY (file_template_id) REFERENCES Meta.File_Template (file_template_id),
 FOREIGN KEY (data_type_id) REFERENCES Meta.Data_Type_Master (data_type_id)

 );

CREATE TABLE Meta.Domain (
    domain_id  int NOT NULL identity(1,1),
    country varchar (200),
 city varchar(200),
 domain_description varchar(255),
    PRIMARY KEY (domain_id ),
 );
 
CREATE TABLE Meta.File_Master(
    file_master_id int NOT NULL identity(1,1),
    domain_id int NOT NULL,
    file_pattern varchar(255),
 sequence_id int,
 source_ip varchar(255),
 source_dir varchar(255),
    source_archive_dir varchar(255),
 file_creation_datetime datetime,
 file_expiry_datetime datetime,
 target_dir varchar(255),
 target_archive_dir varchar(255),
 file_target_table varchar(255),
 created_user_id varchar (50),
 updated_user_id varchar (50),
 file_template_id int Not Null,
 file_stage_table varchar(300) null,
    PRIMARY KEY (file_master_id),
 FOREIGN KEY (domain_id) REFERENCES Meta.Domain (domain_id),
 FOREIGN KEY (file_template_id) REFERENCES Meta.File_Template (file_template_id)
);

CREATE TABLE Meta.File_Transaction (
    file_trans_id int NOT NULL identity(111,1),
    file_master_id int NOT NULL,
    file_name varchar(255),
 file_status int,
 created_datetime datetime,
 updated_datetime datetime,
 csv_processed_file_path varchar(255),
    PRIMARY KEY (file_trans_id),
 FOREIGN KEY (file_master_id) REFERENCES Meta.File_Master (file_master_id)
);

 CREATE TABLE Meta.File_Contact (
    file_contact_id int NOT NULL identity(1,1),
    file_master_id int,
 contact_email_id varchar (255),
 file_contact_number varchar(20),
 description varchar(255),
    PRIMARY KEY (file_contact_id ),
 FOREIGN KEY (file_master_id) REFERENCES Meta.File_Master (file_master_id)
 );

CREATE TABLE Meta.Contact (
    contact_id int NOT NULL identity(1,1),
    file_master_id int,
 contact_email_id varchar (255),
 description varchar(255),
    PRIMARY KEY (contact_id ),
 FOREIGN KEY (file_master_id) REFERENCES Meta.File_Master (file_master_id)
 );
 
 
 CREATE TABLE Meta.File_Master_History (
    File_Master_Hist_ID  int NOT NULL identity(1,1),
    file_master_id int,
    domain_id int NOT NULL,
    file_pattern varchar(255),
 sequence_id int,
 source_ip varchar(255),
 source_dir varchar(255),
    source_archive_dir varchar(255),
 file_creation_datetime datetime,
 file_expiry_datetime datetime,
 target_dir varchar(255),
 target_archive_dir varchar(255),
 file_target_table varchar(255),
 created_user_id varchar (50),
 updated_user_id varchar (50),
 file_template_id int Not Null,
 file_stage_table varchar (255),
    PRIMARY KEY (File_Master_Hist_ID),
    FOREIGN KEY (file_master_id) REFERENCES Meta.File_Master (file_master_id),
 FOREIGN KEY (domain_id) REFERENCES Meta.Domain (domain_id),
); 


CREATE TABLE Meta.File_Load_Status (
    file_load_status_id int identity(1,1),
    file_trans_id int NOT NULL,
    file_status int,
 created_datetime datetime,
    PRIMARY KEY (file_load_status_id),
 FOREIGN KEY (file_trans_id) REFERENCES Meta.File_Transaction (file_trans_id),
 
);

CREATE TABLE Meta.Load_Status_Master(
    load_status_master_id int identity (1,1),
    file_load_status_id int,
 load_status_code varchar(255),
 load_status_level int,
 load_status_description varchar(255),
    PRIMARY KEY (load_status_master_id),
 FOREIGN KEY (file_load_status_id) REFERENCES Meta.File_Load_status (file_load_status_id)
);

 CREATE TABLE Meta.Load_Process (
    load_process_id int NOT NULL identity(1,1),
    load_process_name varchar(200),
 load_process_description varchar (255),
 created_date datetime,
 updated_date datetime,
 environment varchar(200),
    PRIMARY KEY (Load_Process_id ),
 );

 CREATE TABLE Meta.Process_Configuration (
    process_configuration_id int NOT NULL identity(1,1),
    load_process_id int,
 config_key varchar (255),
 config_key_value varchar(200),
    PRIMARY KEY (process_configuration_id ),
 FOREIGN KEY (load_process_id) REFERENCES Meta.Load_Process (load_process_id),
 );
 
 CREATE TABLE Meta.Process_Status (
    process_status_id int NOT NULL identity(1,1),
    file_load_status_id int,
 Process_status_date datetime,
 process_status_description varchar(255),
    PRIMARY KEY (Process_Status_id ),
 FOREIGN KEY (file_load_status_id) REFERENCES Meta.File_Load_Status (file_load_status_id),
 );
 
 CREATE TABLE Profile.Profile_Master (
    profile_master_id int NOT NULL identity(100001,1),
    profile_name varchar(50),
 profile_function varchar(100),
 function_type varchar(255),
 lookup_name varchar(255),
 lookup_query nvarchar(2000),
 lookup_key varchar (255),
    PRIMARY KEY (profile_master_id )
 );

CREATE TABLE Profile.Profile (
    profile_id int NOT NULL ,
    profile_type varchar(50),
 profile_description varchar(200),
    PRIMARY KEY (profile_id )
 );
CREATE TABLE Profile.Profile_Column (
    profile_column_id int NOT NULL identity(1,1),
 profile_master_id int,
 file_master_id int,
 file_column_template_id int,
    PRIMARY KEY (profile_column_id),
    FOREIGN KEY (file_column_template_id) REFERENCES Meta.File_Column_Template (file_column_template_id),
    FOREIGN KEY (profile_master_id) REFERENCES Profile.Profile_Master (profile_master_id),
 FOREIGN KEY (file_master_id) REFERENCES Meta.File_Master (file_master_id)
 );

CREATE TABLE Profile.Profile_Output (
    profile_output_id int NOT NULL,
    file_trans_id int,
 profile_output_status varchar(100),
 profile_output_date datetime,
    PRIMARY KEY (profile_output_id ),
 FOREIGN KEY (file_trans_id) REFERENCES Meta.File_Transaction (file_trans_id)
 );
CREATE TABLE Profile.Profile_Output_Details (
    profile_output_detail_id int NOT NULL identity(1,1),
    profile_output_id int,
 profile_id  int,
 profile_output_detail_status varchar (100),
 profile_output_key varchar (200),
 profile_output_value varchar (200),
 creation_datetime datetime,
 json_string nvarchar (4000),
    PRIMARY KEY (profile_output_detail_id ),
 FOREIGN KEY (profile_output_id) REFERENCES Profile.Profile_Output (profile_output_id),
 FOREIGN KEY (profile_id) REFERENCES Profile.Profile (profile_id)
 );
CREATE TABLE Profile.Profile_Table (
    profile_table_id  int NOT NULL identity(101,1),
 file_master_id int,
 profile_master_id int,
    PRIMARY KEY (profile_table_id ),
 FOREIGN KEY (file_master_id) REFERENCES Meta.File_Master (file_master_id),
 FOREIGN KEY (profile_master_id) REFERENCES Profile.Profile_Master (profile_master_id)
 );
CREATE TABLE Raw.UK_Quote_Transaction(
 Quote_Id int IDENTITY(1,1) NOT NULL,
 Serial_Number nvarchar(100) NULL,
 Sales_Order nvarchar(100) NULL,
 Sales_Item nvarchar(100) NULL,
 Material nvarchar(max) NULL,
 Quantity nvarchar(max) NULL,
 UoM nvarchar(max) NULL,
 Net_value nvarchar(100) NULL,
 Currency varchar(10) NULL,
 Creation_Date nvarchar(100) NULL,
 Created_By nvarchar(200) NULL,
 Plant nvarchar(50) NULL,
 Document_Type nvarchar(100) NULL,
 Document_Category nvarchar(100) NULL,
 file_trans_Id varchar(10) NULL,
 PRIMARY KEY (Quote_Id)
 );
CREATE TABLE Raw.US_Quote_Transaction(
 Quote_Id int IDENTITY(1,1) NOT NULL,
 Serial_Number nvarchar(100) NULL,
 Sales_Order nvarchar(100) NULL,
 Sales_Item nvarchar(100) NULL,
 Material nvarchar(max) NULL,
 Quantity nvarchar(max) NULL,
 UoM nvarchar(max) NULL,
 Net_value nvarchar(100) NULL,
 Currency varchar(10) NULL,
 Creation_Date nvarchar(100) NULL,
 Created_By nvarchar(200) NULL,
 Plant nvarchar(50) NULL,
 Document_Type nvarchar(100) NULL,
 Document_Category nvarchar(100) NULL,
 file_trans_Id varchar(10) NULL,
   PRIMARY KEY (Quote_Id)
);

CREATE TABLE [Temp].[UK_Quote_Transaction](
	[Serial Number] [nvarchar](100) NULL,
	[Sales Order] [nvarchar](100) NULL,
	[Sales Item] [nvarchar](100) NULL,
	[Material] [nvarchar](max) NULL,
	[Quantity] [nvarchar](max) NULL,
	[UoM] [nvarchar](max) NULL,
	[Net Value] [nvarchar](100) NULL,
	[Currency] [varchar](10) NULL,
	[Creation Date] [nvarchar](100) NULL,
	[Created By] [nvarchar](200) NULL,
	[Plant] [nvarchar](50) NULL,
	[Document Type] [nvarchar](100) NULL,
	[Document Category] [nvarchar](100) NULL
);

CREATE TABLE [Temp].[US_Quote_Transaction](
	[Serial Number] [nvarchar](100) NULL,
	[Sales Order] [nvarchar](100) NULL,
	[Sales Item] [nvarchar](100) NULL,
	[Material] [nvarchar](max) NULL,
	[Quantity] [nvarchar](max) NULL,
	[UoM] [nvarchar](max) NULL,
	[Net Value] [nvarchar](100) NULL,
	[Currency] [varchar](10) NULL,
	[Creation Date] [nvarchar](100) NULL,
	[Created By] [nvarchar](200) NULL,
	[Plant] [nvarchar](50) NULL,
	[Document Type] [nvarchar](100) NULL,
	[Document Category] [nvarchar](100) NULL
);
create table Lookup.US_Quotes_Material(
material_id int not null,
material varchar(255),
Primary key (material_id)
);
create table Lookup.UK_Quotes_Material(
material_id int not null,
material varchar(255),
Primary key (material_id)
);
create table Lookup.US_Quotes_UoM(
UoM_id int not null,
UoM varchar(255),
Primary key (UoM_id)
);
create table Lookup.UK_Quotes_UoM(
UoM_id int not null,
UoM varchar(255),
Primary key (UoM_id)
);
create table Lookup.US_Quotes_Currency(
currency_id int not null,
currency varchar(255),
Primary key (currency_id)
);
create table Lookup.UK_Quotes_Currency(
currency_id int not null,
currency varchar(255),
Primary key (currency_id)
);
create table Lookup.US_Quotes_Plant(
plant_id int not null,
plant varchar(255),
Primary key (plant_id)
);
create table Lookup.UK_Quotes_Plant(
plant_id int not null,
plant varchar(255),
Primary key (plant_id)
);

