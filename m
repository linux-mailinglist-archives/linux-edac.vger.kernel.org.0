Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280393028B1
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jan 2021 18:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbhAYRVo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jan 2021 12:21:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2426 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730992AbhAYRVV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jan 2021 12:21:21 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPc1V0dmqz67gls;
        Tue, 26 Jan 2021 01:14:54 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 18:20:40 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.115) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 17:20:39 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@openeuler.org>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH v2 7/8] rasdaemon: ras-mc-ctl: Add support for HiSilicon Kunpeng9xx common errors
Date:   Mon, 25 Jan 2021 17:14:54 +0000
Message-ID: <20210125171455.1886-8-shiju.jose@huawei.com>
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

Add support for the HiSilicon Kunpeng9xx platforms common errors.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 util/ras-mc-ctl.in | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 8befc5d..37a5042 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1519,6 +1519,7 @@ sub errors
 # Definitions of the vendor platform IDs.
 use constant {
     HISILICON_KUNPENG_920 => "Kunpeng920",
+    HISILICON_KUNPENG_9XX => "Kunpeng9xx",
 };
 
 sub vendor_errors_summary
@@ -1526,7 +1527,7 @@ sub vendor_errors_summary
     require DBI;
     my ($num_args, $platform_id);
     my ($query, $query_handle, $count, $out);
-    my ($module_id, $sub_module_id, $err_severity, $err_sev);
+    my ($module_id, $sub_module_id, $err_severity, $err_sev, $err_info);
 
     $num_args = $#ARGV + 1;
     $platform_id = 0;
@@ -1601,6 +1602,24 @@ sub vendor_errors_summary
         $query_handle->finish;
     }
 
+    # HiSilicon Kunpeng9xx common errors
+    if ($platform_id eq HISILICON_KUNPENG_9XX) {
+        $query = "select err_info, count(*) from hisi_common_section";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($err_info, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\terrors: $count\n";
+        }
+        if ($out ne "") {
+            print "HiSilicon Kunpeng9xx common error events summary:\n$out\n";
+        } else {
+            print "No HiSilicon Kunpeng9xx common errors.\n\n";
+        }
+        $query_handle->finish;
+    }
+
     undef($dbh);
 }
 
@@ -1610,7 +1629,7 @@ sub vendor_errors
     my ($num_args, $platform_id);
     my ($query, $query_handle, $id, $timestamp, $out);
     my ($version, $soc_id, $socket_id, $nimbus_id, $core_id, $port_id);
-    my ($module_id, $sub_module_id, $err_severity, $err_type, $regs);
+    my ($module_id, $sub_module_id, $err_severity, $err_type, $err_info, $regs);
 
     $num_args = $#ARGV + 1;
     $platform_id = 0;
@@ -1696,6 +1715,26 @@ sub vendor_errors
         $query_handle->finish;
     }
 
+    # HiSilicon Kunpeng9xx common errors
+    if ($platform_id eq HISILICON_KUNPENG_9XX) {
+        $query = "select id, timestamp, err_info, regs_dump from hisi_common_section order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $err_info, $regs));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id. $timestamp ";
+            $out .= "Error Info:$err_info \n" if ($err_info);
+            $out .= "Error Registers: $regs\n\n" if ($regs);
+        }
+        if ($out ne "") {
+            print "HiSilicon Kunpeng9xx common error events:\n$out\n";
+        } else {
+            print "No HiSilicon Kunpeng9xx common errors.\n";
+        }
+        $query_handle->finish;
+    }
+
     undef($dbh);
 }
 
@@ -1703,6 +1742,7 @@ sub vendor_platforms
 {
         print "\nSupported platforms for the vendor-specific errors:\n";
         print "\tHiSilicon Kunpeng920, platform-id=\"", HISILICON_KUNPENG_920, "\"\n";
+        print "\tHiSilicon Kunpeng9xx, platform-id=\"", HISILICON_KUNPENG_9XX, "\"\n";
         print "\n";
 }
 
-- 
2.17.1

