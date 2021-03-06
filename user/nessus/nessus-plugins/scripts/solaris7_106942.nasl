#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(13091);
 script_version ("$Revision: 1.7 $");
 script_bugtraq_id(5356, 6484, 6883, 7123, 7455);
 name["english"] = "Solaris 7 (sparc) : 106942-29";
 
 script_name(english:name["english"]);
 
 desc["english"] = "
The remote host is missing Sun Security Patch number 106942-29
( libnsl, rpc.nisd and nis_cachemgr Patch).

You should install this patch for your system to be up-to-date.

Solution : http://sunsolve.sun.com/search/document.do?assetkey=1-21-106942-29-1
Risk factor : High";


 script_description(english:desc["english"]);
 
 summary["english"] = "Check for patch 106942-29"; 
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2005 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e =  solaris_check_patch(release:"5.7", arch:"sparc", patch:"106942-29", obsoleted_by:"", package:"SUNWarc SUNWcsl SUNWcslx SUNWhea SUNWnisr SUNWnisu SUNWscpu SUNWscpux SUNWsra");

if ( e < 0 ) security_hole(0);
else if ( e > 0 )
{
	set_kb_item(name:"BID-5356", value:TRUE);
	set_kb_item(name:"BID-6484", value:TRUE);
	set_kb_item(name:"BID-6883", value:TRUE);
	set_kb_item(name:"BID-7123", value:TRUE);
	set_kb_item(name:"BID-7455", value:TRUE);
}
