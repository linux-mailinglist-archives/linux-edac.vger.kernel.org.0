Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4AA629E6C
	for <lists+linux-edac@lfdr.de>; Tue, 15 Nov 2022 17:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKOQEq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Nov 2022 11:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbiKOQEm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Nov 2022 11:04:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65407558B
        for <linux-edac@vger.kernel.org>; Tue, 15 Nov 2022 08:04:40 -0800 (PST)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBWCY1xLgz6HJX5;
        Wed, 16 Nov 2022 00:02:17 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 15 Nov 2022 17:04:38 +0100
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.156.200) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 16:04:38 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <luoshengwei@huawei.com>, <panjunchong@hisilicon.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 08/11] rasdaemon: ras-mc-ctl: Relocate reading and display Kunpeng920 errors to under Kunpeng9xx
Date:   Tue, 15 Nov 2022 16:04:16 +0000
Message-ID: <20221115160419.355-9-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20221115160419.355-1-shiju.jose@huawei.com>
References: <20221115160419.355-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.156.200]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Relocate reading and display Kunpeng920 errors to under Kunpeng9xx.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 296eb87..75981a0 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1529,7 +1529,6 @@ sub errors
 
 # Definitions of the vendor platform IDs.
 use constant {
-    HISILICON_KUNPENG_920 => "Kunpeng920",
     HISILICON_KUNPENG_9XX => "Kunpeng9xx",
 };
 
@@ -1553,8 +1552,8 @@ sub vendor_errors_summary
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
-    # HiSilicon Kunpeng920 errors
-    if ($platform_id eq HISILICON_KUNPENG_920) {
+    # HiSilicon Kunpeng9xx errors
+    if ($platform_id eq HISILICON_KUNPENG_9XX) {
 	$found_platform = 1;
         $query = "select err_severity, module_id, count(*) from hip08_oem_type1_event_v2 group by err_severity, module_id";
         $query_handle = $dbh->prepare($query);
@@ -1570,9 +1569,7 @@ sub vendor_errors_summary
             $out .= "\t$module_id: $count\n";
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng920 OEM type1 error events summary:\n$out\n";
-        } else {
-            print "No HiSilicon Kunpeng920 OEM type1 errors.\n\n";
+            print "HiSilicon Kunpeng9xx OEM type1 error events summary:\n$out\n";
         }
         $query_handle->finish;
 
@@ -1590,9 +1587,7 @@ sub vendor_errors_summary
             $out .= "\t$module_id: $count\n";
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng920 OEM type2 error events summary:\n$out\n";
-        } else {
-            print "No HiSilicon Kunpeng920 OEM type2 errors.\n\n";
+            print "HiSilicon Kunpeng9xx OEM type2 error events summary:\n$out\n";
         }
         $query_handle->finish;
 
@@ -1610,16 +1605,10 @@ sub vendor_errors_summary
             $out .= "\t$sub_module_id: $count\n";
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng920 PCIe controller error events summary:\n$out\n";
-        } else {
-            print "No HiSilicon Kunpeng920 PCIe controller errors.\n\n";
+            print "HiSilicon Kunpeng9xx PCIe controller error events summary:\n$out\n";
         }
         $query_handle->finish;
-    }
 
-    # HiSilicon Kunpeng9xx common errors
-    if ($platform_id eq HISILICON_KUNPENG_9XX) {
-	$found_platform = 1;
         $query = "select err_severity, module_id, count(*) from hisi_common_section_v2 group by err_severity, module_id";
         $query_handle = $dbh->prepare($query);
         $query_handle->execute();
@@ -1635,8 +1624,6 @@ sub vendor_errors_summary
         }
         if ($out ne "") {
             print "HiSilicon Kunpeng9xx common error events summary:\n$out\n";
-        } else {
-            print "No HiSilicon Kunpeng9xx common errors.\n\n";
         }
         $query_handle->finish;
     }
@@ -1673,8 +1660,8 @@ sub vendor_errors
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
-    # HiSilicon Kunpeng920 errors
-    if ($platform_id eq HISILICON_KUNPENG_920) {
+    # HiSilicon Kunpeng9xx errors
+    if ($platform_id eq HISILICON_KUNPENG_9XX) {
 	$found_platform = 1;
         $query = "select id, timestamp, version, soc_id, socket_id, nimbus_id, module_id, sub_module_id, err_severity, regs_dump from hip08_oem_type1_event_v2 order by id, module_id, err_severity";
         $query_handle = $dbh->prepare($query);
@@ -1697,7 +1684,7 @@ sub vendor_errors
 	    }
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng920 OEM type1 error events:\n$out\n";
+            print "HiSilicon Kunpeng9xx OEM type1 error events:\n$out\n";
         }
         $query_handle->finish;
 
@@ -1722,7 +1709,7 @@ sub vendor_errors
 	    }
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng920 OEM type2 error events:\n$out\n";
+            print "HiSilicon Kunpeng9xx OEM type2 error events:\n$out\n";
         }
         $query_handle->finish;
 
@@ -1749,14 +1736,10 @@ sub vendor_errors
 	    }
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng920 PCIe controller error events:\n$out\n";
+            print "HiSilicon Kunpeng9xx PCIe controller error events:\n$out\n";
         }
         $query_handle->finish;
-    }
 
-    # HiSilicon Kunpeng9xx common errors
-    if ($platform_id eq HISILICON_KUNPENG_9XX) {
-	$found_platform = 1;
         $query = "select id, timestamp, version, soc_id, socket_id, totem_id, nimbus_id, sub_system_id, module_id, sub_module_id, core_id, port_id, err_type, pcie_info, err_severity, regs_dump from hisi_common_section_v2 order by id, module_id, err_severity";
         $query_handle = $dbh->prepare($query);
         $query_handle->execute();
@@ -1785,8 +1768,6 @@ sub vendor_errors
         }
         if ($out ne "") {
             print "HiSilicon Kunpeng9xx common error events:\n$out\n";
-        } else {
-            print "No HiSilicon Kunpeng9xx common errors.\n";
         }
         $query_handle->finish;
     }
@@ -1803,7 +1784,6 @@ sub vendor_errors
 sub vendor_platforms
 {
         print "\nSupported platforms for the vendor-specific errors:\n";
-        print "\tHiSilicon Kunpeng920, platform-id=\"", HISILICON_KUNPENG_920, "\"\n";
         print "\tHiSilicon Kunpeng9xx, platform-id=\"", HISILICON_KUNPENG_9XX, "\"\n";
         print "\n";
 }
-- 
2.25.1

