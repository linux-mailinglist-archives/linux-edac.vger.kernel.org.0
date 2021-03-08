Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0B331403
	for <lists+linux-edac@lfdr.de>; Mon,  8 Mar 2021 18:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCHRCw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Mar 2021 12:02:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2661 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCHRCq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Mar 2021 12:02:46 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvPZv5cwPz67tX9;
        Tue,  9 Mar 2021 00:54:47 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 18:02:45 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.25.24) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 17:02:44 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH v3 4/7] rasdaemon: ras-mc-ctl: Add support for the vendor-specific errors
Date:   Mon, 8 Mar 2021 16:57:29 +0000
Message-ID: <20210308165732.273-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210308165732.273-1-shiju.jose@huawei.com>
References: <20210308165732.273-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.25.24]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
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
 util/ras-mc-ctl.in | 64 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 44847d2..f282eff 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -95,6 +95,9 @@ Usage: $prog [OPTIONS...]
  --summary          Presents a summary of the logged errors.
  --errors           Shows the errors stored at the error database.
  --error-count      Shows the corrected and uncorrected error counts using sysfs.
+ --vendor-errors-summary <platform-id>    Presents a summary of the vendor-specific logged errors.
+ --vendor-errors         <platform-id>    Shows the vendor-specific errors stored in the error database.
+ --vendor-platforms Shows the supported platforms with platform-ids for the vendor-specific errors.
  --help             This help message.
 EOF
 
@@ -142,6 +145,18 @@ if ($conf{opt}{errors}) {
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
@@ -157,6 +172,9 @@ sub parse_cmdline
     $conf{opt}{summary} = 0;
     $conf{opt}{errors} = 0;
     $conf{opt}{error_count} = 0;
+    $conf{opt}{vendor_errors_summary} = 0;
+    $conf{opt}{vendor_errors} = 0;
+    $conf{opt}{vendor_platforms} = 0;
 
     my $rref = \$conf{opt}{report};
     my $mref = \$conf{opt}{mainboard};
@@ -174,7 +192,10 @@ sub parse_cmdline
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
@@ -1503,6 +1524,47 @@ sub errors
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

