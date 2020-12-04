Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D532CEBF5
	for <lists+linux-edac@lfdr.de>; Fri,  4 Dec 2020 11:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgLDKPa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Dec 2020 05:15:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2205 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbgLDKPa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Dec 2020 05:15:30 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CnT5D6k8jz67LvS;
        Fri,  4 Dec 2020 18:11:44 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 4 Dec 2020 11:14:48 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.97) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 4 Dec 2020 10:14:47 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <xuwei5@huawei.com>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <tanxiaofei@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <salil.mehta@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 1/3] rasdaemon: ras-mc-ctl: Add support for the vendor-specific errors
Date:   Fri, 4 Dec 2020 10:13:36 +0000
Message-ID: <20201204101338.1060-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201204101338.1060-1-shiju.jose@huawei.com>
References: <20201204101338.1060-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.85.97]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add commands to support logging the vendor-specific
error info in the ras-mc-ctl.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 util/ras-mc-ctl.in | 68 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 07b52e9..f457f0a 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -80,6 +80,9 @@ Usage: $prog [OPTIONS...]
  --summary          Presents a summary of the logged errors.
  --errors           Shows the errors stored at the error database.
  --error-count      Shows the corrected and uncorrected error counts using sysfs.
+ --vendor-errors-summary <platform-id>    Presents a summary of the vendor-specific logged errors.
+ --vendor-errors         <platform-id>    Shows the vendor-specific errors stored in the error database.
+ --vendor-platforms List the supported platforms with platform-ids for the vendor-specific errors.
  --help             This help message.
 EOF
 
@@ -127,6 +130,18 @@ if ($conf{opt}{errors}) {
     errors ();
 }
 
+if ($conf{opt}{vendor_errors_summary}) {
+    vendor_errors_summary ();
+}
+
+if ($conf{opt}{vendor_errors}) {
+    vendor_errors ();
+}
+
+if ($conf{opt}{vendor_platforms}) {
+    vendor_platforms ();
+}
+
 exit (0);
 
 sub parse_cmdline
@@ -142,6 +157,9 @@ sub parse_cmdline
     $conf{opt}{summary} = 0;
     $conf{opt}{errors} = 0;
     $conf{opt}{error_count} = 0;
+    $conf{opt}{vendor_errors_summary} = 0;
+    $conf{opt}{vendor_errors} = 0;
+    $conf{opt}{vendor_platforms} = 0;
 
     my $rref = \$conf{opt}{report};
     my $mref = \$conf{opt}{mainboard};
@@ -159,7 +177,10 @@ sub parse_cmdline
                          "layout" =>          \$conf{opt}{display_memory_layout},
                          "summary" =>         \$conf{opt}{summary},
                          "errors" =>          \$conf{opt}{errors},
-                         "error-count" =>     \$conf{opt}{error_count}
+                         "error-count" =>     \$conf{opt}{error_count},
+                         "vendor-errors-summary" =>    \$conf{opt}{vendor_errors_summary},
+                         "vendor-errors" =>   \$conf{opt}{vendor_errors},
+                         "vendor-platforms" =>    \$conf{opt}{vendor_platforms},
             );
 
     usage(1) if !$rc;
@@ -1531,6 +1552,51 @@ sub errors
     undef($dbh);
 }
 
+sub vendor_errors_summary
+{
+    require DBI;
+    my ($num_args, $platform_id);
+
+    $num_args = $#ARGV + 1;
+    $platform_id = 0;
+    if ($num_args ne 0) {
+        $platform_id = $ARGV[0];
+    } else {
+        return;
+    }
+
+    my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
+    # Disable the DBI automatic exception log
+    $dbh->{PrintError} = 0;
+
+    undef($dbh);
+}
+
+sub vendor_errors
+{
+    require DBI;
+    my ($num_args, $platform_id);
+
+    $num_args = $#ARGV + 1;
+    $platform_id = 0;
+    if ($num_args ne 0) {
+        $platform_id = $ARGV[0];
+    } else {
+        return;
+    }
+
+    my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
+    # Disable the DBI automatic exception log
+    $dbh->{PrintError} = 0;
+
+    undef($dbh);
+}
+
+sub vendor_platforms
+{
+        print "\nSupported platforms for the vendor-specific errors:\n";
+}
+
 sub log_msg   { print STDERR "$prog: ", @_ unless $conf{opt}{quiet}; }
 sub log_error { log_msg ("Error: @_"); }
 
-- 
2.17.1

