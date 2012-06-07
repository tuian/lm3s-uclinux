#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(12687);
 script_version ("$Revision: 1.4 $");
 script_bugtraq_id(3382, 641);
 name["english"] = "Solaris 2.5.1 (sparc) : 104489-15";
 
 script_name(english:name["english"]);
 
 desc["english"] = "
The remote host is missing Sun Security Patch number 104489-15
( ToolTalk patch).

You should install this patch for your system to be up-to-date.

Solution : http://sunsolve.sun.com/search/document.do?assetkey=1-21-104489-15-1
Risk factor : High";


 script_description(english:desc["english"]);
 
 summary["english"] = "Check for patch 104489-15"; 
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e =  solaris_check_patch(release:"5.5.1", arch:"sparc", patch:"104489-15", obsoleted_by:"", package:"SUNWtltk SUNWtltkd SUNWtltkm");

if ( e < 0 ) security_hole(0);
else if ( e > 0 )
{
	set_kb_item(name:"BID-3382", value:TRUE);
	set_kb_item(name:"BID-641", value:TRUE);
}
