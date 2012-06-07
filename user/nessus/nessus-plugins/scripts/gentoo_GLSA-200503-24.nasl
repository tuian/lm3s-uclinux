# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200503-24.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2005 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004 Michel Arboi <mikhail@nessus.org>

if (! defined_func('bn_random')) exit(0);

if (description)
{
 script_id(17580);
 script_version("$Revision: 1.2 $");
 script_xref(name: "GLSA", value: "200503-24");

 desc = 'The remote host is affected by the vulnerability described in GLSA-200503-24
(LTris: Buffer overflow)


    LTris is vulnerable to a buffer overflow when reading the global
    highscores file.
  
Impact

    By modifying the global highscores file a malicious user could
    trick another user to execute arbitrary code.
  
Workaround

    There is no known workaround at this time.
  

Solution: 
    All LTris users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=games-puzzle/ltris-1.0.10"
  

Risk factor : Medium
';
 script_description(english: desc);
 script_copyright(english: "(C) 2005 Michel Arboi <mikhail@nessus.org>");
 script_name(english: "[GLSA-200503-24] LTris: Buffer overflow");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'LTris: Buffer overflow');
 exit(0);
}

include('qpkg.inc');
if (qpkg_check(package: "games-puzzle/ltris", unaffected: make_list("ge 1.0.10"), vulnerable: make_list("lt 1.0.10")
)) { security_warning(0); exit(0); }
