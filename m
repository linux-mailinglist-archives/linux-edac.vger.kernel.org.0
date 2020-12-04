Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D342CEBFC
	for <lists+linux-edac@lfdr.de>; Fri,  4 Dec 2020 11:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgLDKQs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Dec 2020 05:16:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2207 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgLDKQr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Dec 2020 05:16:47 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CnT7z70K6z67KBJ;
        Fri,  4 Dec 2020 18:14:07 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 4 Dec 2020 11:16:06 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.97) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 4 Dec 2020 10:16:05 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <xuwei5@huawei.com>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <tanxiaofei@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <salil.mehta@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 3/3] rasdaemon: ras-mc-ctl: Add support for HiSilicon KunPeng9xx common errors
Date:   Fri, 4 Dec 2020 10:13:38 +0000
Message-ID: <20201204101338.1060-4-shiju.jose@huawei.com>
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

Add support for the HiSilicon KunPeng9xx platforms common errors.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 util/ras-mc-ctl.in | 52 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 711e4b0..0885de1 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1555,6 +1555,7 @@ sub errors
 # Definitions of the vendor platform IDs.
 use constant {
     HISILICON_KUNPENG_920 => "KunPeng920",
+    HISILICON_KUNPENG_9XX => "KunPeng9xx",
 };
 
 sub vendor_errors_summary
@@ -1562,7 +1563,7 @@ sub vendor_errors_summary
     require DBI;
     my ($num_args, $platform_id);
     my ($query, $query_handle, $count, $out);
-    my ($module_id, $sub_module_id, $err_severity, $err_sev);
+    my ($module_id, $sub_module_id, $err_severity, $err_sev, $err_info);
 
     $num_args = $#ARGV + 1;
     $platform_id = 0;
@@ -1651,6 +1652,28 @@ sub vendor_errors_summary
         };
     }
 
+    # HiSilicon KunPeng9xx common errors
+    if ($platform_id eq HISILICON_KUNPENG_9XX) {
+        try {
+            $query = "select err_info, count(*) from hisi_common_section";
+            $query_handle = $dbh->prepare($query);
+            $query_handle->execute();
+            $query_handle->bind_columns(\($err_info, $count));
+            $out = "";
+            while($query_handle->fetch()) {
+                $out .= "\terrors: $count\n";
+            }
+            if ($out ne "") {
+                print "HiSilicon KunPeng9xx common error events summary:\n$out\n";
+            } else {
+                print "No HiSilicon KunPeng9xx common errors.\n\n";
+            }
+            $query_handle->finish;
+        } catch {
+            print "Exception: $DBI::errstr\n\n";
+        };
+    }
+
     undef($dbh);
 }
 
@@ -1660,7 +1683,7 @@ sub vendor_errors
     my ($num_args, $platform_id);
     my ($query, $query_handle, $id, $timestamp, $out);
     my ($version, $soc_id, $socket_id, $nimbus_id, $core_id, $port_id);
-    my ($module_id, $sub_module_id, $err_severity, $err_type, $regs);
+    my ($module_id, $sub_module_id, $err_severity, $err_type, $err_info, $regs);
 
     $num_args = $#ARGV + 1;
     $platform_id = 0;
@@ -1760,6 +1783,30 @@ sub vendor_errors
         };
     }
 
+    # HiSilicon KunPeng9xx common errors
+    if ($platform_id eq HISILICON_KUNPENG_9XX) {
+        try {
+            $query = "select id, timestamp, err_info, regs_dump from hisi_common_section order by id";
+            $query_handle = $dbh->prepare($query);
+            $query_handle->execute();
+            $query_handle->bind_columns(\($id, $timestamp, $err_info, $regs));
+            $out = "";
+            while($query_handle->fetch()) {
+                $out .= "$id. $timestamp ";
+                $out .= "Error Info:$err_info \n" if ($err_info);
+                $out .= "Error Registers: $regs\n\n" if ($regs);
+            }
+            if ($out ne "") {
+                print "HiSilicon KunPeng9xx common error events:\n$out\n";
+            } else {
+                print "No HiSilicon KunPeng9xx common errors.\n";
+            }
+            $query_handle->finish;
+        } catch {
+            print "Exception: $DBI::errstr\n\n";
+        };
+    }
+
     undef($dbh);
 }
 
@@ -1767,6 +1814,7 @@ sub vendor_platforms
 {
         print "\nSupported platforms for the vendor-specific errors:\n";
         print "\tHiSilicon KunPeng920, platform-id=\"", HISILICON_KUNPENG_920, "\"\n";
+        print "\tHiSilicon KunPeng9xx, platform-id=\"", HISILICON_KUNPENG_9XX, "\"\n";
         print "\n";
 }
 
-- 
2.17.1

