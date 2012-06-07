# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200507-19.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2005 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004 Michel Arboi <mikhail@nessus.org>

if (! defined_func('bn_random')) exit(0);

if (description)
{
 script_id(19281);
 script_version("$Revision: 1.2 $");
 script_xref(name: "GLSA", value: "200507-19");

 desc = 'The remote host is affected by the vulnerability described in GLSA-200507-19
(zlib: Buffer overflow)


    zlib improperly handles invalid data streams which could lead to a
    buffer overflow.
  
Impact

    By creating a specially crafted compressed data stream, attackers
    can overwrite data structures for applications that use zlib, resulting
    in arbitrary code execution or a Denial of Service.
  
Workaround

    There is no known workaround at this time.
  
References:
    http://archives.neohapsis.com/archives/fulldisclosure/2005-07/0489.html
    http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2005-1849


Solution: 
    All zlib users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=sys-libs/zlib-1.2.3"
  

Risk factor : High
';
 script_description(english: desc);
 script_copyright(english: "(C) 2005 Michel Arboi <mikhail@nessus.org>");
 script_name(english: "[GLSA-200507-19] zlib: Buffer overflow");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'zlib: Buffer overflow');
 exit(0);
}

include('qpkg.inc');
if (qpkg_check(package: "sys-libs/zlib", unaffected: make_list("ge 1.2.3"), vulnerable: make_list("lt 1.2.3")
)) { security_hole(0); exit(0); }
