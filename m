Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA571629E6D
	for <lists+linux-edac@lfdr.de>; Tue, 15 Nov 2022 17:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKOQEr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Nov 2022 11:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKOQEm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Nov 2022 11:04:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282DE2609
        for <linux-edac@vger.kernel.org>; Tue, 15 Nov 2022 08:04:41 -0800 (PST)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBW8y4x62z689F7;
        Wed, 16 Nov 2022 00:00:02 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
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
Subject: [PATCH v3 09/11] rasdaemon: ras-mc-ctl: Updated HiSilicon platform name
Date:   Tue, 15 Nov 2022 16:04:17 +0000
Message-ID: <20221115160419.355-10-shiju.jose@huawei.com>
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

Updated the HiSilicon platform name as KunPeng9xx.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 75981a0..1cc19b3 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1529,7 +1529,7 @@ sub errors
 
 # Definitions of the vendor platform IDs.
 use constant {
-    HISILICON_KUNPENG_9XX => "Kunpeng9xx",
+    HISILICON_KUNPENG_9XX => "KunPeng9xx",
 };
 
 sub vendor_errors_summary
@@ -1552,7 +1552,7 @@ sub vendor_errors_summary
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
-    # HiSilicon Kunpeng9xx errors
+    # HiSilicon KunPeng9xx errors
     if ($platform_id eq HISILICON_KUNPENG_9XX) {
 	$found_platform = 1;
         $query = "select err_severity, module_id, count(*) from hip08_oem_type1_event_v2 group by err_severity, module_id";
@@ -1569,7 +1569,7 @@ sub vendor_errors_summary
             $out .= "\t$module_id: $count\n";
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng9xx OEM type1 error events summary:\n$out\n";
+            print "HiSilicon KunPeng9xx OEM type1 error events summary:\n$out\n";
         }
         $query_handle->finish;
 
@@ -1587,7 +1587,7 @@ sub vendor_errors_summary
             $out .= "\t$module_id: $count\n";
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng9xx OEM type2 error events summary:\n$out\n";
+            print "HiSilicon KunPeng9xx OEM type2 error events summary:\n$out\n";
         }
         $query_handle->finish;
 
@@ -1605,7 +1605,7 @@ sub vendor_errors_summary
             $out .= "\t$sub_module_id: $count\n";
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng9xx PCIe controller error events summary:\n$out\n";
+            print "HiSilicon KunPeng9xx PCIe controller error events summary:\n$out\n";
         }
         $query_handle->finish;
 
@@ -1623,7 +1623,7 @@ sub vendor_errors_summary
             $out .= "\t$module_id: $count\n";
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng9xx common error events summary:\n$out\n";
+            print "HiSilicon KunPeng9xx common error events summary:\n$out\n";
         }
         $query_handle->finish;
     }
@@ -1660,7 +1660,7 @@ sub vendor_errors
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
-    # HiSilicon Kunpeng9xx errors
+    # HiSilicon KunPeng9xx errors
     if ($platform_id eq HISILICON_KUNPENG_9XX) {
 	$found_platform = 1;
         $query = "select id, timestamp, version, soc_id, socket_id, nimbus_id, module_id, sub_module_id, err_severity, regs_dump from hip08_oem_type1_event_v2 order by id, module_id, err_severity";
@@ -1684,7 +1684,7 @@ sub vendor_errors
 	    }
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng9xx OEM type1 error events:\n$out\n";
+            print "HiSilicon KunPeng9xx OEM type1 error events:\n$out\n";
         }
         $query_handle->finish;
 
@@ -1709,7 +1709,7 @@ sub vendor_errors
 	    }
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng9xx OEM type2 error events:\n$out\n";
+            print "HiSilicon KunPeng9xx OEM type2 error events:\n$out\n";
         }
         $query_handle->finish;
 
@@ -1736,7 +1736,7 @@ sub vendor_errors
 	    }
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng9xx PCIe controller error events:\n$out\n";
+            print "HiSilicon KunPeng9xx PCIe controller error events:\n$out\n";
         }
         $query_handle->finish;
 
@@ -1767,7 +1767,7 @@ sub vendor_errors
 	    }
         }
         if ($out ne "") {
-            print "HiSilicon Kunpeng9xx common error events:\n$out\n";
+            print "HiSilicon KunPeng9xx common error events:\n$out\n";
         }
         $query_handle->finish;
     }
@@ -1784,7 +1784,7 @@ sub vendor_errors
 sub vendor_platforms
 {
         print "\nSupported platforms for the vendor-specific errors:\n";
-        print "\tHiSilicon Kunpeng9xx, platform-id=\"", HISILICON_KUNPENG_9XX, "\"\n";
+        print "\tHiSilicon KunPeng9xx, platform-id=\"", HISILICON_KUNPENG_9XX, "\"\n";
         print "\n";
 }
 
-- 
2.25.1

