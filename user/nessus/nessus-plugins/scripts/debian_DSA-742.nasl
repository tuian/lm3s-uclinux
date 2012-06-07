# This script was automatically generated from the dsa-742
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2004 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004 Michel Arboi

if (! defined_func('bn_random')) exit(0);

desc = '
Derek Price, the current maintainer of CVS, discovered a buffer
overflow in the CVS server, that serves the popular Concurrent
Versions System, which could lead to the execution of arbitrary code.
For the old stable distribution (woody) this problem has been fixed in
version 1.11.1p1debian-12.
For the stable distribution (sarge) this problem has been fixed in
version 1.12.9-13.
For the unstable distribution (sid) this problem has been fixed in
version 1.12.9-13.
We recommend that you upgrade your cvs package.


Solution : http://www.debian.org/security/2005/dsa-742
Risk factor : High';

if (description) {
 script_id(18646);
 script_version("$Revision: 1.2 $");
 script_xref(name: "DSA", value: "742");
 script_cve_id("CVE-2005-0753");

 script_description(english: desc);
 script_copyright(english: "This script is (C) 2005 Michel Arboi <mikhail@nessus.org>");
 script_name(english: "[DSA742] DSA-742-1 cvs");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-742-1 cvs");
 exit(0);
}

include("debian_package.inc");

w = 0;
if (deb_check(prefix: 'cvs', release: '3.0', reference: '1.11.1p1debian-12')) {
 w ++;
 if (report_verbosity > 0) desc = strcat(desc, '\nThe package cvs is vulnerable in Debian 3.0.\nUpgrade to cvs_1.11.1p1debian-12\n');
}
if (deb_check(prefix: 'cvs', release: '3.1', reference: '1.12.9-13')) {
 w ++;
 if (report_verbosity > 0) desc = strcat(desc, '\nThe package cvs is vulnerable in Debian 3.1.\nUpgrade to cvs_1.12.9-13\n');
}
if (deb_check(prefix: 'cvs', release: '3.1', reference: '1.12.9-13')) {
 w ++;
 if (report_verbosity > 0) desc = strcat(desc, '\nThe package cvs is vulnerable in Debian sarge.\nUpgrade to cvs_1.12.9-13\n');
}
if (deb_check(prefix: 'cvs', release: '3.0', reference: '1.11.1p1debian-12')) {
 w ++;
 if (report_verbosity > 0) desc = strcat(desc, '\nThe package cvs is vulnerable in Debian woody.\nUpgrade to cvs_1.11.1p1debian-12\n');
}
if (w) { security_hole(port: 0, data: desc); }
