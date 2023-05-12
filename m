Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACC7700427
	for <lists+linux-edac@lfdr.de>; Fri, 12 May 2023 11:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbjELJn3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 May 2023 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbjELJmu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 12 May 2023 05:42:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FF9124BF
        for <linux-edac@vger.kernel.org>; Fri, 12 May 2023 02:42:04 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHkJT72RDz67qpK;
        Fri, 12 May 2023 17:40:09 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 10:41:51 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <tanxiaofei@huawei.com>, <fenglei47@h-partners.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH 4/4] rasdaemon: ras-mc-ctl: Add handling of run-time errors reported when querying HiSilicon KunPeng9xx OEM errors
Date:   Fri, 12 May 2023 17:41:29 +0800
Message-ID: <20230512094129.1468-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230512094129.1468-1-shiju.jose@huawei.com>
References: <20230512094129.1468-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add try-catch for handling the run-time errors reported when querying
the HiSilicon KunPeng9xx OEM errors.
Reason:
For example, when an error table is not present in the SQLite DB,
then the DBI report error "no such table" and the ras-mc-ctl would exit
without query and log the other error types.
In the rasdaemon, for the vendor specific errors, the error table in the
SQLite database would be created, if not already done, when the corresponding
error is reported for the first time.

Reported-by: Lei Feng <fenglei47@h-partners.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 421 ++++++++++++++++++++++++++-------------------
 1 file changed, 245 insertions(+), 176 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index dc326d3..a24eb49 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -34,6 +34,7 @@ use File::Basename;
 use File::Find;
 use Getopt::Long;
 use POSIX;
+use Try::Tiny;
 
 my $dbname      = "@RASSTATEDIR@/@RAS_DB_FNAME@";
 my $prefix      = "@prefix@";
@@ -1562,81 +1563,115 @@ sub vendor_errors_summary
     }
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
+    # Disable the DBI automatic error log
+    $dbh->{PrintError} = 0;
 
     # HiSilicon KunPeng9xx errors
     if ($platform_id eq HISILICON_KUNPENG_9XX) {
-	$found_platform = 1;
-        $query = "select err_severity, module_id, count(*) from hip08_oem_type1_event_v2$conf{opt}{since} group by err_severity, module_id";
-        $query_handle = $dbh->prepare($query);
-        $query_handle->execute();
-        $query_handle->bind_columns(\($err_severity, $module_id, $count));
-        $out = "";
-        $err_sev = "";
-        while($query_handle->fetch()) {
-            if ($err_severity ne $err_sev) {
-                $out .= "$err_severity errors:\n";
-                $err_sev = $err_severity;
+        $found_platform = 1;
+        try {
+            $query = "select err_severity, module_id, count(*) from hip08_oem_type1_event_v2$conf{opt}{since} group by err_severity, module_id";
+            $query_handle = $dbh->prepare($query);
+            $query_handle->execute();
+            $query_handle->bind_columns(\($err_severity, $module_id, $count));
+            $out = "";
+            $err_sev = "";
+            while($query_handle->fetch()) {
+                if ($err_severity ne $err_sev) {
+                    $out .= "$err_severity errors:\n";
+                    $err_sev = $err_severity;
+                }
+                $out .= "\t$module_id: $count\n";
             }
-            $out .= "\t$module_id: $count\n";
-        }
-        if ($out ne "") {
-            print "HiSilicon KunPeng9xx OEM type1 error events summary:\n$out\n";
-        }
-        $query_handle->finish;
-
-        $query = "select err_severity, module_id, count(*) from hip08_oem_type2_event_v2$conf{opt}{since} group by err_severity, module_id";
-        $query_handle = $dbh->prepare($query);
-        $query_handle->execute();
-        $query_handle->bind_columns(\($err_severity, $module_id, $count));
-        $out = "";
-        $err_sev = "";
-        while($query_handle->fetch()) {
-            if ($err_severity ne $err_sev) {
-                $out .= "$err_severity errors:\n";
-                $err_sev = $err_severity;
+            if ($out ne "") {
+                print "HiSilicon KunPeng9xx OEM type1 error events summary:\n$out\n";
             }
-            $out .= "\t$module_id: $count\n";
-        }
-        if ($out ne "") {
-            print "HiSilicon KunPeng9xx OEM type2 error events summary:\n$out\n";
-        }
-        $query_handle->finish;
-
-        $query = "select err_severity, sub_module_id, count(*) from hip08_pcie_local_event_v2$conf{opt}{since} group by err_severity, sub_module_id";
-        $query_handle = $dbh->prepare($query);
-        $query_handle->execute();
-        $query_handle->bind_columns(\($err_severity, $sub_module_id, $count));
-        $out = "";
-        $err_sev = "";
-        while($query_handle->fetch()) {
-            if ($err_severity ne $err_sev) {
-                $out .= "$err_severity errors:\n";
-                $err_sev = $err_severity;
+            $query_handle->finish;
+        } catch {
+            if ($DBI::errstr =~ "no such table") {
+                print "No HiSilicon KunPeng9xx OEM type1 errors\n\n";
+            }  else {
+                print "Warning: $DBI::errstr when querying HiSilicon KunPeng9xx OEM type1 errors\n\n";
             }
-            $out .= "\t$sub_module_id: $count\n";
-        }
-        if ($out ne "") {
-            print "HiSilicon KunPeng9xx PCIe controller error events summary:\n$out\n";
-        }
-        $query_handle->finish;
-
-        $query = "select err_severity, module_id, count(*) from hisi_common_section_v2$conf{opt}{since} group by err_severity, module_id";
-        $query_handle = $dbh->prepare($query);
-        $query_handle->execute();
-        $query_handle->bind_columns(\($err_severity, $module_id, $count));
-        $out = "";
-        $err_sev = "";
-        while($query_handle->fetch()) {
-            if ($err_severity ne $err_sev) {
-                $out .= "$err_severity errors:\n";
-                $err_sev = $err_severity;
+        };
+
+        try {
+	    $query = "select err_severity, module_id, count(*) from hip08_oem_type2_event_v2$conf{opt}{since} group by err_severity, module_id";
+            $query_handle = $dbh->prepare($query);
+            $query_handle->execute();
+            $query_handle->bind_columns(\($err_severity, $module_id, $count));
+            $out = "";
+            $err_sev = "";
+            while($query_handle->fetch()) {
+                if ($err_severity ne $err_sev) {
+                    $out .= "$err_severity errors:\n";
+                    $err_sev = $err_severity;
+                }
+                $out .= "\t$module_id: $count\n";
             }
-            $out .= "\t$module_id: $count\n";
-        }
-        if ($out ne "") {
-            print "HiSilicon KunPeng9xx common error events summary:\n$out\n";
-        }
-        $query_handle->finish;
+            if ($out ne "") {
+                print "HiSilicon KunPeng9xx OEM type2 error events summary:\n$out\n";
+            }
+            $query_handle->finish;
+        } catch {
+            if ($DBI::errstr =~ "no such table") {
+                print "No HiSilicon KunPeng9xx OEM type2 errors\n\n";
+            }  else {
+                print "Warning: $DBI::errstr when querying HiSilicon KunPeng9xx OEM type2 errors\n\n";
+            }
+        };
+
+        try {
+            $query = "select err_severity, sub_module_id, count(*) from hip08_pcie_local_event_v2$conf{opt}{since} group by err_severity, sub_module_id";
+            $query_handle = $dbh->prepare($query);
+            $query_handle->execute();
+            $query_handle->bind_columns(\($err_severity, $sub_module_id, $count));
+            $out = "";
+            $err_sev = "";
+            while($query_handle->fetch()) {
+                if ($err_severity ne $err_sev) {
+                    $out .= "$err_severity errors:\n";
+                    $err_sev = $err_severity;
+                }
+                $out .= "\t$sub_module_id: $count\n";
+            }
+            if ($out ne "") {
+                print "HiSilicon KunPeng9xx PCIe controller error events summary:\n$out\n";
+            }
+            $query_handle->finish;
+        } catch {
+            if ($DBI::errstr =~ "no such table") {
+                print "No HiSilicon KunPeng9xx PCIe controller errors\n\n";
+            }  else {
+                print "Warning: $DBI::errstr when querying HiSilicon KunPeng9xx PCIe controller errors\n\n";
+            }
+        };
+
+        try {
+            $query = "select err_severity, module_id, count(*) from hisi_common_section_v2$conf{opt}{since} group by err_severity, module_id";
+            $query_handle = $dbh->prepare($query);
+            $query_handle->execute();
+            $query_handle->bind_columns(\($err_severity, $module_id, $count));
+            $out = "";
+            $err_sev = "";
+            while($query_handle->fetch()) {
+                if ($err_severity ne $err_sev) {
+                    $out .= "$err_severity errors:\n";
+                    $err_sev = $err_severity;
+                }
+                $out .= "\t$module_id: $count\n";
+            }
+            if ($out ne "") {
+                print "HiSilicon KunPeng9xx common error events summary:\n$out\n";
+            }
+            $query_handle->finish;
+        } catch {
+            if ($DBI::errstr =~ "no such table") {
+                print "No HiSilicon KunPeng9xx common errors\n\n";
+            }  else {
+                print "Warning: $DBI::errstr when querying HiSilicon KunPeng9xx common errors\n\n";
+            }
+        };
     }
 
     if ($platform_id && !($found_platform)) {
@@ -1670,117 +1705,151 @@ sub vendor_errors
     }
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
+    # Disable the DBI automatic error log
+    $dbh->{PrintError} = 0;
 
     # HiSilicon KunPeng9xx errors
     if ($platform_id eq HISILICON_KUNPENG_9XX) {
-	$found_platform = 1;
-        $query = "select id, timestamp, version, soc_id, socket_id, nimbus_id, module_id, sub_module_id, err_severity, regs_dump from hip08_oem_type1_event_v2$conf{opt}{since} order by id, module_id, err_severity";
-        $query_handle = $dbh->prepare($query);
-        $query_handle->execute();
-        $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $nimbus_id, $module_id, $sub_module_id, $err_severity, $regs));
-        $out = "";
-        while($query_handle->fetch()) {
-            if ($module eq 0 || ($module_id && uc($module) eq uc($module_id))) {
-                $out .= "$id. $timestamp Error Info: ";
-                $out .= "version=$version, ";
-                $out .= "soc_id=$soc_id, " if ($soc_id);
-                $out .= "socket_id=$socket_id, " if ($socket_id);
-                $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
-                $out .= "module_id=$module_id, " if ($module_id);
-                $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
-                $out .= "err_severity=$err_severity, " if ($err_severity);
-                $out .= "Error Registers: $regs " if ($regs);
-                $out .= "\n\n";
-                $found_module = 1;
-	    }
-        }
-        if ($out ne "") {
-            print "HiSilicon KunPeng9xx OEM type1 error events:\n$out\n";
-        }
-        $query_handle->finish;
-
-        $query = "select id, timestamp, version, soc_id, socket_id, nimbus_id, module_id, sub_module_id, err_severity, regs_dump from hip08_oem_type2_event_v2$conf{opt}{since} order by id, module_id, err_severity";
-        $query_handle = $dbh->prepare($query);
-        $query_handle->execute();
-        $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $nimbus_id, $module_id, $sub_module_id, $err_severity, $regs));
-        $out = "";
-        while($query_handle->fetch()) {
-            if ($module eq 0 || ($module_id && uc($module) eq uc($module_id))) {
-                $out .= "$id. $timestamp Error Info: ";
-                $out .= "version=$version, ";
-                $out .= "soc_id=$soc_id, " if ($soc_id);
-                $out .= "socket_id=$socket_id, " if ($socket_id);
-                $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
-                $out .= "module_id=$module_id, " if ($module_id);
-                $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
-                $out .= "err_severity=$err_severity, " if ($err_severity);
-                $out .= "Error Registers: $regs " if ($regs);
-                $out .= "\n\n";
-                $found_module = 1;
-	    }
-        }
-        if ($out ne "") {
-            print "HiSilicon KunPeng9xx OEM type2 error events:\n$out\n";
-        }
-        $query_handle->finish;
-
-        $query = "select id, timestamp, version, soc_id, socket_id, nimbus_id, sub_module_id, core_id, port_id, err_severity, err_type, regs_dump from hip08_pcie_local_event_v2$conf{opt}{since} order by id, sub_module_id, err_severity";
-        $query_handle = $dbh->prepare($query);
-        $query_handle->execute();
-        $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $nimbus_id, $sub_module_id, $core_id, $port_id, $err_severity, $err_type, $regs));
-        $out = "";
-        while($query_handle->fetch()) {
-            if ($module eq 0 || ($sub_module_id && uc($module) eq uc($sub_module_id))) {
-                $out .= "$id. $timestamp Error Info: ";
-                $out .= "version=$version, ";
-                $out .= "soc_id=$soc_id, " if ($soc_id);
-                $out .= "socket_id=$socket_id, " if ($socket_id);
-                $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
-                $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
-                $out .= "core_id=$core_id, " if ($core_id);
-                $out .= "port_id=$port_id, " if ($port_id);
-                $out .= "err_severity=$err_severity, " if ($err_severity);
-                $out .= "err_type=$err_type, " if ($err_type);
-                $out .= "Error Registers: $regs " if ($regs);
-                $out .= "\n\n";
-                $found_module = 1;
-	    }
-        }
-        if ($out ne "") {
-            print "HiSilicon KunPeng9xx PCIe controller error events:\n$out\n";
-        }
-        $query_handle->finish;
-
-        $query = "select id, timestamp, version, soc_id, socket_id, totem_id, nimbus_id, sub_system_id, module_id, sub_module_id, core_id, port_id, err_type, pcie_info, err_severity, regs_dump from hisi_common_section_v2$conf{opt}{since} order by id, module_id, err_severity";
-        $query_handle = $dbh->prepare($query);
-        $query_handle->execute();
-        $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $totem_id, $nimbus_id, $sub_system_id, $module_id, $sub_module_id, $core_id, $port_id, $err_type, $pcie_info, $err_severity, $regs));
-        $out = "";
-        while($query_handle->fetch()) {
-            if ($module eq 0 || ($module_id && uc($module) eq uc($module_id))) {
-                $out .= "$id. $timestamp Error Info: ";
-                $out .= "version=$version, ";
-                $out .= "soc_id=$soc_id, " if ($soc_id);
-                $out .= "socket_id=$socket_id, " if ($socket_id);
-                $out .= "totem_id=$totem_id, " if ($totem_id);
-                $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
-                $out .= "sub_system_id=$sub_system_id, " if ($sub_system_id);
-                $out .= "module_id=$module_id, " if ($module_id);
-                $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
-                $out .= "core_id=$core_id, " if ($core_id);
-                $out .= "port_id=$port_id, " if ($port_id);
-                $out .= "err_type=$err_type, " if ($err_type);
-                $out .= "pcie_info=$pcie_info, " if ($pcie_info);
-                $out .= "err_severity=$err_severity, " if ($err_severity);
-                $out .= "Error Registers: $regs" if ($regs);
-                $out .= "\n\n";
-                $found_module = 1;
-	    }
-        }
-        if ($out ne "") {
-            print "HiSilicon KunPeng9xx common error events:\n$out\n";
-        }
-        $query_handle->finish;
+        $found_platform = 1;
+        try {
+	    $query = "select id, timestamp, version, soc_id, socket_id, nimbus_id, module_id, sub_module_id, err_severity, regs_dump from hip08_oem_type1_event_v2$conf{opt}{since} order by id, module_id, err_severity";
+            $query_handle = $dbh->prepare($query);
+            $query_handle->execute();
+            $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $nimbus_id, $module_id, $sub_module_id, $err_severity, $regs));
+            $out = "";
+            while($query_handle->fetch()) {
+                if ($module eq 0 || ($module_id && uc($module) eq uc($module_id))) {
+                    $out .= "$id. $timestamp Error Info: ";
+                    $out .= "version=$version, ";
+                    $out .= "soc_id=$soc_id, " if ($soc_id);
+                    $out .= "socket_id=$socket_id, " if ($socket_id);
+                    $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
+                    $out .= "module_id=$module_id, " if ($module_id);
+                    $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
+                    $out .= "err_severity=$err_severity, " if ($err_severity);
+                    $out .= "Error Registers: $regs " if ($regs);
+                    $out .= "\n\n";
+                    $found_module = 1;
+	        }
+            }
+            if ($out ne "") {
+                print "HiSilicon KunPeng9xx OEM type1 error events:\n$out\n";
+            }
+            $query_handle->finish;
+        } catch {
+            if ($DBI::errstr =~ "no such table") {
+                print "No HiSilicon KunPeng9xx OEM type1 errors\n\n";
+            }  else {
+                print "Warning: $DBI::errstr when querying HiSilicon KunPeng9xx OEM type1 errors\n\n";
+            }
+        };
+
+        try {
+            $query = "select id, timestamp, version, soc_id, socket_id, nimbus_id, module_id, sub_module_id, err_severity, regs_dump from hip08_oem_type2_event_v2$conf{opt}{since} order by id, module_id, err_severity";
+            $query_handle = $dbh->prepare($query);
+            $query_handle->execute();
+            $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $nimbus_id, $module_id, $sub_module_id, $err_severity, $regs));
+            $out = "";
+            while($query_handle->fetch()) {
+                if ($module eq 0 || ($module_id && uc($module) eq uc($module_id))) {
+                    $out .= "$id. $timestamp Error Info: ";
+                    $out .= "version=$version, ";
+                    $out .= "soc_id=$soc_id, " if ($soc_id);
+                    $out .= "socket_id=$socket_id, " if ($socket_id);
+                    $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
+                    $out .= "module_id=$module_id, " if ($module_id);
+                    $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
+                    $out .= "err_severity=$err_severity, " if ($err_severity);
+                    $out .= "Error Registers: $regs " if ($regs);
+                    $out .= "\n\n";
+                    $found_module = 1;
+	        }
+            }
+            if ($out ne "") {
+                print "HiSilicon KunPeng9xx OEM type2 error events:\n$out\n";
+            }
+            $query_handle->finish;
+        } catch {
+            if ($DBI::errstr =~ "no such table") {
+                print "No HiSilicon KunPeng9xx OEM type2 errors\n\n";
+            }  else {
+                print "Warning: $DBI::errstr when querying HiSilicon KunPeng9xx OEM type2 errors\n\n";
+            }
+        };
+
+        try {
+            $query = "select id, timestamp, version, soc_id, socket_id, nimbus_id, sub_module_id, core_id, port_id, err_severity, err_type, regs_dump from hip08_pcie_local_event_v2$conf{opt}{since} order by id, sub_module_id, err_severity";
+            $query_handle = $dbh->prepare($query);
+            $query_handle->execute();
+            $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $nimbus_id, $sub_module_id, $core_id, $port_id, $err_severity, $err_type, $regs));
+            $out = "";
+            while($query_handle->fetch()) {
+                if ($module eq 0 || ($sub_module_id && uc($module) eq uc($sub_module_id))) {
+                    $out .= "$id. $timestamp Error Info: ";
+                    $out .= "version=$version, ";
+                    $out .= "soc_id=$soc_id, " if ($soc_id);
+                    $out .= "socket_id=$socket_id, " if ($socket_id);
+                    $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
+                    $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
+                    $out .= "core_id=$core_id, " if ($core_id);
+                    $out .= "port_id=$port_id, " if ($port_id);
+                    $out .= "err_severity=$err_severity, " if ($err_severity);
+                    $out .= "err_type=$err_type, " if ($err_type);
+                    $out .= "Error Registers: $regs " if ($regs);
+                    $out .= "\n\n";
+                    $found_module = 1;
+	        }
+            }
+            if ($out ne "") {
+                print "HiSilicon KunPeng9xx PCIe controller error events:\n$out\n";
+            }
+            $query_handle->finish;
+        } catch {
+            if ($DBI::errstr =~ "no such table") {
+                print "No HiSilicon KunPeng9xx PCIe controller errors\n\n";
+            }  else {
+                print "Warning: $DBI::errstr when querying HiSilicon KunPeng9xx PCIe controller errors\n\n";
+            }
+        };
+
+        try {
+            $query = "select id, timestamp, version, soc_id, socket_id, totem_id, nimbus_id, sub_system_id, module_id, sub_module_id, core_id, port_id, err_type, pcie_info, err_severity, regs_dump from hisi_common_section_v2$conf{opt}{since} order by id, module_id, err_severity";
+            $query_handle = $dbh->prepare($query);
+            $query_handle->execute();
+            $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $totem_id, $nimbus_id, $sub_system_id, $module_id, $sub_module_id, $core_id, $port_id, $err_type, $pcie_info, $err_severity, $regs));
+            $out = "";
+            while($query_handle->fetch()) {
+                if ($module eq 0 || ($module_id && uc($module) eq uc($module_id))) {
+                    $out .= "$id. $timestamp Error Info: ";
+                    $out .= "version=$version, ";
+                    $out .= "soc_id=$soc_id, " if ($soc_id);
+                    $out .= "socket_id=$socket_id, " if ($socket_id);
+                    $out .= "totem_id=$totem_id, " if ($totem_id);
+                    $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
+                    $out .= "sub_system_id=$sub_system_id, " if ($sub_system_id);
+                    $out .= "module_id=$module_id, " if ($module_id);
+                    $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
+                    $out .= "core_id=$core_id, " if ($core_id);
+                    $out .= "port_id=$port_id, " if ($port_id);
+                    $out .= "err_type=$err_type, " if ($err_type);
+                    $out .= "pcie_info=$pcie_info, " if ($pcie_info);
+                    $out .= "err_severity=$err_severity, " if ($err_severity);
+                    $out .= "Error Registers: $regs" if ($regs);
+                    $out .= "\n\n";
+                    $found_module = 1;
+	        }
+            }
+            if ($out ne "") {
+                print "HiSilicon KunPeng9xx common error events:\n$out\n";
+            }
+            $query_handle->finish;
+        } catch {
+            if ($DBI::errstr =~ "no such table") {
+                print "No HiSilicon KunPeng9xx common errors\n\n";
+            }  else {
+                print "Warning: $DBI::errstr when querying HiSilicon KunPeng9xx common errors\n\n";
+            }
+        };
     }
 
     if ($platform_id && !($found_platform)) {
-- 
2.25.1

