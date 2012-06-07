# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200604-07.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004 Michel Arboi <mikhail@nessus.org>

if (! defined_func('bn_random')) exit(0);

if (description)
{
 script_id(21231);
 script_version("$Revision: 1.1 $");
 script_xref(name: "GLSA", value: "200604-07");
 script_cve_id("CVE-2006-0146", "CVE-2006-0147", "CVE-2006-0410", "CVE-2006-0806");

 desc = 'The remote host is affected by the vulnerability described in GLSA-200604-07
(Cacti: Multiple vulnerabilities in included ADOdb)


    Several vulnerabilities have been identified in the copy of ADOdb
    included in Cacti. Andreas Sandblad discovered a dynamic code
    evaluation vulnerability (CVE-2006-0147) and a potential SQL injection
    vulnerability (CVE-2006-0146). Andy Staudacher reported another SQL
    injection vulnerability (CVE-2006-0410), and Gulftech Security
    discovered multiple cross-site-scripting issues (CVE-2006-0806).
  
Impact

    Remote attackers could trigger these vulnerabilities by sending
    malicious queries to the Cacti web application, resulting in arbitrary
    code execution, database compromise through arbitrary SQL execution,
    and malicious HTML or JavaScript code injection.
  
Workaround

    There is no known workaround at this time.
  
References:
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-0146
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-0147
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-0410
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-0806


Solution: 
    All Cacti users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=net-analyzer/cacti-0.8.6h_p20060108-r2"
  

Risk factor : High
';
 script_description(english: desc);
 script_copyright(english: "(C) 2006 Michel Arboi <mikhail@nessus.org>");
 script_name(english: "[GLSA-200604-07] Cacti: Multiple vulnerabilities in included ADOdb");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Cacti: Multiple vulnerabilities in included ADOdb');
 exit(0);
}

include('qpkg.inc');
if (qpkg_check(package: "net-analyzer/cacti", unaffected: make_list("ge 0.8.6h_p20060108-r2"), vulnerable: make_list("lt 0.8.6h_p20060108-r2")
)) { security_hole(0); exit(0); }
