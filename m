Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227BD5F334B
	for <lists+linux-edac@lfdr.de>; Mon,  3 Oct 2022 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJCQSG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Oct 2022 12:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJCQRw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Oct 2022 12:17:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6685132EE4
        for <linux-edac@vger.kernel.org>; Mon,  3 Oct 2022 09:17:44 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mh5Zq1wxXz687qR;
        Tue,  4 Oct 2022 00:17:23 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 3 Oct 2022 18:17:42 +0200
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.147) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 17:17:41 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <luoshengwei@huawei.com>, <panjunchong@hisilicon.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 07/10] rasdaemon: ras-mc-ctl: Add support to display the HiSilicon vendor errors for a specified module
Date:   Mon, 3 Oct 2022 17:17:39 +0100
Message-ID: <20221003161742.1697-8-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20221003161742.1697-1-shiju.jose@huawei.com>
References: <20221003161742.1697-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.152.147]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

Add support to display the HiSilicon vendor errors for a specified module.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 145 +++++++++++++++++++++++++++------------------
 1 file changed, 87 insertions(+), 58 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 959ea6b..296eb87 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -96,8 +96,9 @@ Usage: $prog [OPTIONS...]
  --errors           Shows the errors stored at the error database.
  --error-count      Shows the corrected and uncorrected error counts using sysfs.
  --vendor-errors-summary <platform-id>    Presents a summary of the vendor-specific logged errors.
- --vendor-errors         <platform-id>    Shows the vendor-specific errors stored in the error database.
- --vendor-platforms Shows the supported platforms with platform-ids for the vendor-specific errors.
+ --vendor-errors    <platform-id>    Shows the vendor-specific errors stored in the error database.
+ --vendor-errors    <platform-id> <module-name>    Shows the vendor-specific errors for a specific module stored in the error database.
+ --vendor-platforms List the supported platforms with platform-ids for the vendor-specific errors.
  --help             This help message.
 EOF
 
@@ -1535,12 +1536,14 @@ use constant {
 sub vendor_errors_summary
 {
     require DBI;
-    my ($num_args, $platform_id);
+    my ($num_args, $platform_id, $found_platform);
     my ($query, $query_handle, $count, $out);
     my ($module_id, $sub_module_id, $err_severity, $err_sev);
 
     $num_args = $#ARGV + 1;
     $platform_id = 0;
+    $found_platform = 0;
+
     if ($num_args ne 0) {
         $platform_id = $ARGV[0];
     } else {
@@ -1552,6 +1555,7 @@ sub vendor_errors_summary
 
     # HiSilicon Kunpeng920 errors
     if ($platform_id eq HISILICON_KUNPENG_920) {
+	$found_platform = 1;
         $query = "select err_severity, module_id, count(*) from hip08_oem_type1_event_v2 group by err_severity, module_id";
         $query_handle = $dbh->prepare($query);
         $query_handle->execute();
@@ -1615,6 +1619,7 @@ sub vendor_errors_summary
 
     # HiSilicon Kunpeng9xx common errors
     if ($platform_id eq HISILICON_KUNPENG_9XX) {
+	$found_platform = 1;
         $query = "select err_severity, module_id, count(*) from hisi_common_section_v2 group by err_severity, module_id";
         $query_handle = $dbh->prepare($query);
         $query_handle->execute();
@@ -1636,21 +1641,31 @@ sub vendor_errors_summary
         $query_handle->finish;
     }
 
+    if ($platform_id && !($found_platform)) {
+        print "Platform ID $platform_id is not valid\n";
+    }
+
     undef($dbh);
 }
 
 sub vendor_errors
 {
     require DBI;
-    my ($num_args, $platform_id);
+    my ($num_args, $platform_id, $found_platform, $module, $found_module);
     my ($query, $query_handle, $id, $timestamp, $out);
     my ($version, $soc_id, $socket_id, $totem_id, $nimbus_id, $sub_system_id, $core_id, $port_id);
     my ($module_id, $sub_module_id, $err_severity, $err_type, $pcie_info, $regs);
 
     $num_args = $#ARGV + 1;
     $platform_id = 0;
+    $found_platform = 0;
+    $module = 0;
+    $found_module = 0;
     if ($num_args ne 0) {
         $platform_id = $ARGV[0];
+        if ($num_args gt 1) {
+            $module = $ARGV[1];
+        }
     } else {
         usage(1);
         return;
@@ -1660,27 +1675,29 @@ sub vendor_errors
 
     # HiSilicon Kunpeng920 errors
     if ($platform_id eq HISILICON_KUNPENG_920) {
+	$found_platform = 1;
         $query = "select id, timestamp, version, soc_id, socket_id, nimbus_id, module_id, sub_module_id, err_severity, regs_dump from hip08_oem_type1_event_v2 order by id, module_id, err_severity";
         $query_handle = $dbh->prepare($query);
         $query_handle->execute();
         $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $nimbus_id, $module_id, $sub_module_id, $err_severity, $regs));
         $out = "";
         while($query_handle->fetch()) {
-            $out .= "$id. $timestamp Error Info: ";
-            $out .= "version=$version, ";
-            $out .= "soc_id=$soc_id, " if ($soc_id);
-            $out .= "socket_id=$socket_id, " if ($socket_id);
-            $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
-            $out .= "module_id=$module_id, " if ($module_id);
-            $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
-            $out .= "err_severity=$err_severity, " if ($err_severity);
-            $out .= "Error Registers: $regs " if ($regs);
-            $out .= "\n\n";
+            if ($module eq 0 || ($module_id && uc($module) eq uc($module_id))) {
+                $out .= "$id. $timestamp Error Info: ";
+                $out .= "version=$version, ";
+                $out .= "soc_id=$soc_id, " if ($soc_id);
+                $out .= "socket_id=$socket_id, " if ($socket_id);
+                $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
+                $out .= "module_id=$module_id, " if ($module_id);
+                $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
+                $out .= "err_severity=$err_severity, " if ($err_severity);
+                $out .= "Error Registers: $regs " if ($regs);
+                $out .= "\n\n";
+                $found_module = 1;
+	    }
         }
         if ($out ne "") {
             print "HiSilicon Kunpeng920 OEM type1 error events:\n$out\n";
-        } else {
-            print "No HiSilicon Kunpeng920 OEM type1 errors.\n";
         }
         $query_handle->finish;
 
@@ -1690,21 +1707,22 @@ sub vendor_errors
         $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $nimbus_id, $module_id, $sub_module_id, $err_severity, $regs));
         $out = "";
         while($query_handle->fetch()) {
-            $out .= "$id. $timestamp Error Info: ";
-            $out .= "version=$version, ";
-            $out .= "soc_id=$soc_id, " if ($soc_id);
-            $out .= "socket_id=$socket_id, " if ($socket_id);
-            $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
-            $out .= "module_id=$module_id, " if ($module_id);
-            $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
-            $out .= "err_severity=$err_severity, " if ($err_severity);
-            $out .= "Error Registers: $regs " if ($regs);
-            $out .= "\n\n";
+            if ($module eq 0 || ($module_id && uc($module) eq uc($module_id))) {
+                $out .= "$id. $timestamp Error Info: ";
+                $out .= "version=$version, ";
+                $out .= "soc_id=$soc_id, " if ($soc_id);
+                $out .= "socket_id=$socket_id, " if ($socket_id);
+                $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
+                $out .= "module_id=$module_id, " if ($module_id);
+                $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
+                $out .= "err_severity=$err_severity, " if ($err_severity);
+                $out .= "Error Registers: $regs " if ($regs);
+                $out .= "\n\n";
+                $found_module = 1;
+	    }
         }
         if ($out ne "") {
             print "HiSilicon Kunpeng920 OEM type2 error events:\n$out\n";
-        } else {
-            print "No HiSilicon Kunpeng920 OEM type2 errors.\n";
         }
         $query_handle->finish;
 
@@ -1714,51 +1732,56 @@ sub vendor_errors
         $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $nimbus_id, $sub_module_id, $core_id, $port_id, $err_severity, $err_type, $regs));
         $out = "";
         while($query_handle->fetch()) {
-            $out .= "$id. $timestamp Error Info: ";
-            $out .= "version=$version, ";
-            $out .= "soc_id=$soc_id, " if ($soc_id);
-            $out .= "socket_id=$socket_id, " if ($socket_id);
-            $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
-            $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
-            $out .= "core_id=$core_id, " if ($core_id);
-            $out .= "port_id=$port_id, " if ($port_id);
-            $out .= "err_severity=$err_severity, " if ($err_severity);
-            $out .= "err_type=$err_type, " if ($err_type);
-            $out .= "Error Registers: $regs " if ($regs);
-            $out .= "\n\n";
+            if ($module eq 0 || ($sub_module_id && uc($module) eq uc($sub_module_id))) {
+                $out .= "$id. $timestamp Error Info: ";
+                $out .= "version=$version, ";
+                $out .= "soc_id=$soc_id, " if ($soc_id);
+                $out .= "socket_id=$socket_id, " if ($socket_id);
+                $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
+                $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
+                $out .= "core_id=$core_id, " if ($core_id);
+                $out .= "port_id=$port_id, " if ($port_id);
+                $out .= "err_severity=$err_severity, " if ($err_severity);
+                $out .= "err_type=$err_type, " if ($err_type);
+                $out .= "Error Registers: $regs " if ($regs);
+                $out .= "\n\n";
+                $found_module = 1;
+	    }
         }
         if ($out ne "") {
             print "HiSilicon Kunpeng920 PCIe controller error events:\n$out\n";
-        } else {
-            print "No HiSilicon Kunpeng920 PCIe controller errors.\n";
         }
         $query_handle->finish;
     }
 
     # HiSilicon Kunpeng9xx common errors
     if ($platform_id eq HISILICON_KUNPENG_9XX) {
+	$found_platform = 1;
         $query = "select id, timestamp, version, soc_id, socket_id, totem_id, nimbus_id, sub_system_id, module_id, sub_module_id, core_id, port_id, err_type, pcie_info, err_severity, regs_dump from hisi_common_section_v2 order by id, module_id, err_severity";
         $query_handle = $dbh->prepare($query);
         $query_handle->execute();
         $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $totem_id, $nimbus_id, $sub_system_id, $module_id, $sub_module_id, $core_id, $port_id, $err_type, $pcie_info, $err_severity, $regs));
         $out = "";
         while($query_handle->fetch()) {
-            $out .= "$id. $timestamp Error Info: ";
-            $out .= "version=$version, ";
-            $out .= "soc_id=$soc_id, " if ($soc_id);
-            $out .= "socket_id=$socket_id, " if ($socket_id);
-            $out .= "totem_id=$totem_id, " if ($totem_id);
-            $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
-            $out .= "sub_system_id=$sub_system_id, " if ($sub_system_id);
-            $out .= "module_id=$module_id, " if ($module_id);
-            $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
-            $out .= "core_id=$core_id, " if ($core_id);
-            $out .= "port_id=$port_id, " if ($port_id);
-            $out .= "err_type=$err_type, " if ($err_type);
-            $out .= "pcie_info=$pcie_info, " if ($pcie_info);
-            $out .= "err_severity=$err_severity, " if ($err_severity);
-            $out .= "Error Registers: $regs" if ($regs);
-            $out .= "\n\n";
+            if ($module eq 0 || ($module_id && uc($module) eq uc($module_id))) {
+                $out .= "$id. $timestamp Error Info: ";
+                $out .= "version=$version, ";
+                $out .= "soc_id=$soc_id, " if ($soc_id);
+                $out .= "socket_id=$socket_id, " if ($socket_id);
+                $out .= "totem_id=$totem_id, " if ($totem_id);
+                $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
+                $out .= "sub_system_id=$sub_system_id, " if ($sub_system_id);
+                $out .= "module_id=$module_id, " if ($module_id);
+                $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
+                $out .= "core_id=$core_id, " if ($core_id);
+                $out .= "port_id=$port_id, " if ($port_id);
+                $out .= "err_type=$err_type, " if ($err_type);
+                $out .= "pcie_info=$pcie_info, " if ($pcie_info);
+                $out .= "err_severity=$err_severity, " if ($err_severity);
+                $out .= "Error Registers: $regs" if ($regs);
+                $out .= "\n\n";
+                $found_module = 1;
+	    }
         }
         if ($out ne "") {
             print "HiSilicon Kunpeng9xx common error events:\n$out\n";
@@ -1768,6 +1791,12 @@ sub vendor_errors
         $query_handle->finish;
     }
 
+    if ($platform_id && !($found_platform)) {
+        print "Platform ID $platform_id is not valid\n";
+    } elsif ($module && !($found_module)) {
+        print "No error record for the module $module\n";
+    }
+
     undef($dbh);
 }
 
-- 
2.25.1

