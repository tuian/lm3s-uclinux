# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200608-04.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004 Michel Arboi <mikhail@nessus.org>

if (! defined_func('bn_random')) exit(0);

if (description)
{
 script_id(22146);
 script_version("$Revision: 1.1 $");
 script_xref(name: "GLSA", value: "200608-04");
 script_cve_id("CVE-2006-3113", "CVE-2006-3802", "CVE-2006-3803", "CVE-2006-3804", "CVE-2006-3805", "CVE-2006-3806", "CVE-2006-3807", "CVE-2006-3809", "CVE-2006-3810", "CVE-2006-3811", "CVE-2006-3812");

 desc = 'The remote host is affected by the vulnerability described in GLSA-200608-04
(Mozilla Thunderbird: Multiple vulnerabilities)

Impact

    A user can be enticed to open specially crafted URLs, visit webpages
    containing malicious JavaScript or execute a specially crafted script.
    These events could lead to the execution of arbitrary code, or the
    installation of malware on the user\'s computer.
  
Workaround

    There is no known workaround at this time.
  
References:
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3113
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3802
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3803
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3804
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3805
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3806
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3807
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3809
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3810
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3811
    http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3812


Solution: 
    All Mozilla Thunderbird users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=mail-client/mozilla-thunderbird-1.5.0.5"
    All Mozilla Thunderbird binary users should upgrade to the latest
    version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=mail-client/mozilla-thunderbird-bin-1.5.0.5"
  

Risk factor : Medium
';
 script_description(english: desc);
 script_copyright(english: "(C) 2006 Michel Arboi <mikhail@nessus.org>");
 script_name(english: "[GLSA-200608-04] Mozilla Thunderbird: Multiple vulnerabilities");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Mozilla Thunderbird: Multiple vulnerabilities');
 exit(0);
}

include('qpkg.inc');
if (qpkg_check(package: "mail-client/mozilla-thunderbird-bin", unaffected: make_list("ge 1.5.0.5"), vulnerable: make_list("lt 1.5.0.5")
)) { security_warning(0); exit(0); }
if (qpkg_check(package: "mail-client/mozilla-thunderbird", unaffected: make_list("ge 1.5.0.5"), vulnerable: make_list("lt 1.5.0.5")
)) { security_warning(0); exit(0); }
