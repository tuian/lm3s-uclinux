# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200510-09.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2005 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004 Michel Arboi <mikhail@nessus.org>

if (! defined_func('bn_random')) exit(0);

if (description)
{
 script_id(19979);
 script_version("$Revision: 1.2 $");
 script_xref(name: "GLSA", value: "200510-09");
 script_cve_id("CVE-2005-3150");

 desc = 'The remote host is affected by the vulnerability described in GLSA-200510-09
(Weex: Format string vulnerability)


    Ulf Harnhammar discovered a format string bug in Weex that can be
    triggered when it is first run (or when its cache files are rebuilt,
    using the -r option).
  
Impact

    An attacker could setup a malicious FTP server which, when
    accessed using Weex, could trigger the format string bug and end up
    executing arbitrary code with the rights of the user running Weex.
  
Workaround

    There is no known workaround at this time.
  
References:
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2005-3150


Solution: 
    All Weex users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=net-ftp/weex-2.6.1.5-r1"
  

Risk factor : Medium
';
 script_description(english: desc);
 script_copyright(english: "(C) 2005 Michel Arboi <mikhail@nessus.org>");
 script_name(english: "[GLSA-200510-09] Weex: Format string vulnerability");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Weex: Format string vulnerability');
 exit(0);
}

include('qpkg.inc');
if (qpkg_check(package: "net-ftp/weex", unaffected: make_list("ge 2.6.1.5-r1"), vulnerable: make_list("lt 2.6.1.5-r1")
)) { security_warning(0); exit(0); }
