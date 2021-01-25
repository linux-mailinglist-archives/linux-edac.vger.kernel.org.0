Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9FF3028B4
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jan 2021 18:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbhAYRWK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jan 2021 12:22:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2424 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbhAYRUB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jan 2021 12:20:01 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPc2p6CNxz67ggd;
        Tue, 26 Jan 2021 01:16:02 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 18:19:19 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.115) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 17:19:19 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@openeuler.org>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH v2 5/8] rasdaemon: ras-mc-ctl: Add support for the vendor-specific errors
Date:   Mon, 25 Jan 2021 17:14:52 +0000
Message-ID: <20210125171455.1886-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210125171455.1886-1-shiju.jose@huawei.com>
References: <20210125171455.1886-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.85.115]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
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
index 97b1fa4..6820823 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -87,6 +87,9 @@ Usage: $prog [OPTIONS...]
  --summary          Presents a summary of the logged errors.
  --errors           Shows the errors stored at the error database.
  --error-count      Shows the corrected and uncorrected error counts using sysfs.
+ --vendor-errors-summary <platform-id>    Presents a summary of the vendor-specific logged errors.
+ --vendor-errors         <platform-id>    Shows the vendor-specific errors stored in the error database.
+ --vendor-platforms Shows the supported platforms with platform-ids for the vendor-specific errors.
  --help             This help message.
 EOF
 
@@ -134,6 +137,18 @@ if ($conf{opt}{errors}) {
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
@@ -149,6 +164,9 @@ sub parse_cmdline
     $conf{opt}{summary} = 0;
     $conf{opt}{errors} = 0;
     $conf{opt}{error_count} = 0;
+    $conf{opt}{vendor_errors_summary} = 0;
+    $conf{opt}{vendor_errors} = 0;
+    $conf{opt}{vendor_platforms} = 0;
 
     my $rref = \$conf{opt}{report};
     my $mref = \$conf{opt}{mainboard};
@@ -166,7 +184,10 @@ sub parse_cmdline
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
@@ -1495,6 +1516,47 @@ sub errors
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

