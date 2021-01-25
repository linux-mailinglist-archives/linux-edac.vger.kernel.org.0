Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F44E3028B3
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jan 2021 18:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbhAYRWA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jan 2021 12:22:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2425 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbhAYRUw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jan 2021 12:20:52 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPc0t2qdkz67glx;
        Tue, 26 Jan 2021 01:14:22 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 18:20:08 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.115) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 17:20:07 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@openeuler.org>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH v2 6/8] rasdaemon: ras-mc-ctl: Add support for HiSilicon Kunpeng920 errors
Date:   Mon, 25 Jan 2021 17:14:53 +0000
Message-ID: <20210125171455.1886-7-shiju.jose@huawei.com>
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

Add support for the HiSilicon Kunpeng920 errors.
Supported error formats: OEM type 1, OEM typ2 and PCIe controller
error formats.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 util/ras-mc-ctl.in | 149 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 6820823..8befc5d 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1516,10 +1516,17 @@ sub errors
     undef($dbh);
 }
 
+# Definitions of the vendor platform IDs.
+use constant {
+    HISILICON_KUNPENG_920 => "Kunpeng920",
+};
+
 sub vendor_errors_summary
 {
     require DBI;
     my ($num_args, $platform_id);
+    my ($query, $query_handle, $count, $out);
+    my ($module_id, $sub_module_id, $err_severity, $err_sev);
 
     $num_args = $#ARGV + 1;
     $platform_id = 0;
@@ -1531,6 +1538,69 @@ sub vendor_errors_summary
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
+    # HiSilicon Kunpeng920 errors
+    if ($platform_id eq HISILICON_KUNPENG_920) {
+        $query = "select err_severity, module_id, count(*) from hip08_oem_type1_event_v2 group by err_severity, module_id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($err_severity, $module_id, $count));
+        $out = "";
+        $err_sev = "";
+        while($query_handle->fetch()) {
+            if ($err_severity ne $err_sev) {
+                $out .= "$err_severity errors:\n";
+                $err_sev = $err_severity;
+            }
+            $out .= "\t$module_id: $count\n";
+        }
+        if ($out ne "") {
+            print "HiSilicon Kunpeng920 OEM type1 error events summary:\n$out\n";
+        } else {
+            print "No HiSilicon Kunpeng920 OEM type1 errors.\n\n";
+        }
+        $query_handle->finish;
+
+        $query = "select err_severity, module_id, count(*) from hip08_oem_type2_event_v2 group by err_severity, module_id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($err_severity, $module_id, $count));
+        $out = "";
+        $err_sev = "";
+        while($query_handle->fetch()) {
+            if ($err_severity ne $err_sev) {
+                $out .= "$err_severity errors:\n";
+                $err_sev = $err_severity;
+            }
+            $out .= "\t$module_id: $count\n";
+        }
+        if ($out ne "") {
+            print "HiSilicon Kunpeng920 OEM type2 error events summary:\n$out\n";
+        } else {
+            print "No HiSilicon Kunpeng920 OEM type2 errors.\n\n";
+        }
+        $query_handle->finish;
+
+        $query = "select err_severity, sub_module_id, count(*) from hip08_pcie_local_event_v2 group by err_severity, sub_module_id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($err_severity, $sub_module_id, $count));
+        $out = "";
+        $err_sev = "";
+        while($query_handle->fetch()) {
+            if ($err_severity ne $err_sev) {
+                $out .= "$err_severity errors:\n";
+                $err_sev = $err_severity;
+            }
+            $out .= "\t$sub_module_id: $count\n";
+        }
+        if ($out ne "") {
+            print "HiSilicon Kunpeng920 PCIe controller error events summary:\n$out\n";
+        } else {
+            print "No HiSilicon Kunpeng920 PCIe controller errors.\n\n";
+        }
+        $query_handle->finish;
+    }
+
     undef($dbh);
 }
 
@@ -1538,6 +1608,9 @@ sub vendor_errors
 {
     require DBI;
     my ($num_args, $platform_id);
+    my ($query, $query_handle, $id, $timestamp, $out);
+    my ($version, $soc_id, $socket_id, $nimbus_id, $core_id, $port_id);
+    my ($module_id, $sub_module_id, $err_severity, $err_type, $regs);
 
     $num_args = $#ARGV + 1;
     $platform_id = 0;
@@ -1549,12 +1622,88 @@ sub vendor_errors
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
+    # HiSilicon Kunpeng920 errors
+    if ($platform_id eq HISILICON_KUNPENG_920) {
+        $query = "select id, timestamp, version, soc_id, socket_id, nimbus_id, module_id, sub_module_id, err_severity, regs_dump from hip08_oem_type1_event_v2 order by id, module_id, err_severity";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $nimbus_id, $module_id, $sub_module_id, $err_severity, $regs));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id. $timestamp Error Info: ";
+            $out .= "version=$version, ";
+            $out .= "soc_id=$soc_id, " if ($soc_id);
+            $out .= "socket_id=$socket_id, " if ($socket_id);
+            $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
+            $out .= "module_id=$module_id, " if ($module_id);
+            $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
+            $out .= "err_severity=$err_severity, \n" if ($err_severity);
+            $out .= "Error Registers: $regs\n\n" if ($regs);
+        }
+        if ($out ne "") {
+            print "HiSilicon Kunpeng920 OEM type1 error events:\n$out\n";
+        } else {
+            print "No HiSilicon Kunpeng920 OEM type1 errors.\n";
+        }
+        $query_handle->finish;
+
+        $query = "select id, timestamp, version, soc_id, socket_id, nimbus_id, module_id, sub_module_id, err_severity, regs_dump from hip08_oem_type2_event_v2 order by id, module_id, err_severity";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $nimbus_id, $module_id, $sub_module_id, $err_severity, $regs));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id. $timestamp Error Info: ";
+            $out .= "version=$version, ";
+            $out .= "soc_id=$soc_id, " if ($soc_id);
+            $out .= "socket_id=$socket_id, " if ($socket_id);
+            $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
+            $out .= "module_id=$module_id, " if ($module_id);
+            $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
+            $out .= "err_severity=$err_severity, \n" if ($err_severity);
+            $out .= "Error Registers: $regs\n\n" if ($regs);
+        }
+        if ($out ne "") {
+            print "HiSilicon Kunpeng920 OEM type2 error events:\n$out\n";
+        } else {
+            print "No HiSilicon Kunpeng920 OEM type2 errors.\n";
+        }
+        $query_handle->finish;
+
+        $query = "select id, timestamp, version, soc_id, socket_id, nimbus_id, sub_module_id, core_id, port_id, err_severity, err_type, regs_dump from hip08_pcie_local_event_v2 order by id, sub_module_id, err_severity";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $nimbus_id, $sub_module_id, $core_id, $port_id, $err_severity, $err_type, $regs));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id. $timestamp Error Info: ";
+            $out .= "version=$version, ";
+            $out .= "soc_id=$soc_id, " if ($soc_id);
+            $out .= "socket_id=$socket_id, " if ($socket_id);
+            $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
+            $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
+            $out .= "core_id=$core_id, " if ($core_id);
+            $out .= "port_id=$port_id, " if ($port_id);
+            $out .= "err_severity=$err_severity, " if ($err_severity);
+            $out .= "err_type=$err_type, \n" if ($err_type);
+            $out .= "Error Registers: $regs\n\n" if ($regs);
+        }
+        if ($out ne "") {
+            print "HiSilicon Kunpeng920 PCIe controller error events:\n$out\n";
+        } else {
+            print "No HiSilicon Kunpeng920 PCIe controller errors.\n";
+        }
+        $query_handle->finish;
+    }
+
     undef($dbh);
 }
 
 sub vendor_platforms
 {
         print "\nSupported platforms for the vendor-specific errors:\n";
+        print "\tHiSilicon Kunpeng920, platform-id=\"", HISILICON_KUNPENG_920, "\"\n";
+        print "\n";
 }
 
 sub log_msg   { print STDERR "$prog: ", @_ unless $conf{opt}{quiet}; }
-- 
2.17.1

