# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200502-07.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2005 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004 Michel Arboi <mikhail@nessus.org>

if (! defined_func('bn_random')) exit(0);

if (description)
{
 script_id(16444);
 if(defined_func("script_xref"))script_xref(name:"IAVA", value:"2005-t-0015");
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200502-07");

 desc = 'The remote host is affected by the vulnerability described in GLSA-200502-07
(OpenMotif: Multiple vulnerabilities in libXpm)


    Multiple vulnerabilities, such as buffer overflows, out of bounds
    memory access or directory traversals, have been discovered in libXpm
    that is shipped as a part of the X Window System (see GLSA 200409-34
    and 200411-28). OpenMotif, an application that includes this library,
    suffers from the same issues.
  
Impact

    A carefully-crafted XPM file could crash applications making use of the
    OpenMotif toolkit, potentially allowing the execution of arbitrary code
    with the privileges of the user running the application.
  
Workaround

    There is no known workaround at this time.
  
References:
    http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2004-0687
    http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2004-0688
    http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2004-0914
    http://www.gentoo.org/security/en/glsa/glsa-200409-34.xml
    http://www.gentoo.org/security/en/glsa/glsa-200411-28.xml


Solution: 
    All OpenMotif users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose x11-libs/openmotif
    Note: You should run \'revdep-rebuild\' to ensure that all applications
    linked to OpenMotif are properly rebuilt.
  

Risk factor : Medium
';
 script_description(english: desc);
 script_copyright(english: "(C) 2005 Michel Arboi <mikhail@nessus.org>");
 script_name(english: "[GLSA-200502-07] OpenMotif: Multiple vulnerabilities in libXpm");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'OpenMotif: Multiple vulnerabilities in libXpm');
 exit(0);
}

include('qpkg.inc');
if (qpkg_check(package: "x11-libs/openmotif", unaffected: make_list("ge 2.2.3-r1", "rge 2.1.30-r7"), vulnerable: make_list("lt 2.2.3-r1")
)) { security_warning(0); exit(0); }
