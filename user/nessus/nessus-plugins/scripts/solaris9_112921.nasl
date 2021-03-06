#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(13521);
 script_version ("$Revision: 1.8 $");
 script_bugtraq_id(7184, 7185);
 script_cve_id("CVE-2003-0072", "CVE-2003-0082");
 name["english"] = "Solaris 9 (sparc) : 112921-07";
 
 script_name(english:name["english"]);
 
 desc["english"] = "
The remote host is missing Sun Security Patch number 112921-07
( libkadm5 Patch).

You should install this patch for your system to be up-to-date.

Solution : http://sunsolve.sun.com/search/document.do?assetkey=1-21-112921-07-1
Risk factor : High";


 script_description(english:desc["english"]);
 
 summary["english"] = "Check for patch 112921-07"; 
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

e =  solaris_check_patch(release:"5.9", arch:"sparc", patch:"112921-07", obsoleted_by:"", package:"SUNWcstl SUNWcstlx SUNWkdcu SUNWkrbu SUNWkrbux");

if ( e < 0 ) security_hole(0);
else if ( e > 0 )
{
	set_kb_item(name:"CVE-2003-0072", value:TRUE);
	set_kb_item(name:"CVE-2003-0082", value:TRUE);
	set_kb_item(name:"BID-7184", value:TRUE);
	set_kb_item(name:"BID-7185", value:TRUE);
}
