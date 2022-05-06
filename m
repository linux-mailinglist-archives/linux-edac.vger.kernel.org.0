Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979C151D97D
	for <lists+linux-edac@lfdr.de>; Fri,  6 May 2022 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441826AbiEFNpq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 May 2022 09:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441906AbiEFNpb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 May 2022 09:45:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09C222BC9
        for <linux-edac@vger.kernel.org>; Fri,  6 May 2022 06:41:46 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kvs8n0NdLz684Xd;
        Fri,  6 May 2022 21:38:33 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 15:41:45 +0200
Received: from P_UKIT01-A7bmah.china.huawei.com (10.47.73.106) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 14:41:44 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <luoshengwei@huawei.com>, <panjunchong@hisilicon.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [PATCH 09/10] rasdaemon: ras-mc-ctl: Updated HiSilicon platform name
Date:   Fri, 6 May 2022 14:33:06 +0100
Message-ID: <20220506133307.1799-10-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220506133307.1799-1-shiju.jose@huawei.com>
References: <20220506133307.1799-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.73.106]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

