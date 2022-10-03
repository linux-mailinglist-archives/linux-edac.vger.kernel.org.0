Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457BD5F3348
	for <lists+linux-edac@lfdr.de>; Mon,  3 Oct 2022 18:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJCQSE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Oct 2022 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJCQRw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Oct 2022 12:17:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B09356F4
        for <linux-edac@vger.kernel.org>; Mon,  3 Oct 2022 09:17:43 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mh5XQ5RxSz67y6K;
        Tue,  4 Oct 2022 00:15:18 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 3 Oct 2022 18:17:40 +0200
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.147) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 17:17:40 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <luoshengwei@huawei.com>, <panjunchong@hisilicon.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 04/10] rasdaemon: ras-mc-ctl: Modify error statistics for HiSilicon KunPeng9xx common errors
Date:   Mon, 3 Oct 2022 17:17:36 +0100
Message-ID: <20221003161742.1697-5-shiju.jose@huawei.com>
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

Modify the error statistics for the HiSilicon KunPeng9xx platforms common errors
to display the statistics and error info based on the module and the error severity.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index b22dd60..08eb287 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1537,7 +1537,7 @@ sub vendor_errors_summary
     require DBI;
     my ($num_args, $platform_id);
     my ($query, $query_handle, $count, $out);
-    my ($module_id, $sub_module_id, $err_severity, $err_sev, $err_info);
+    my ($module_id, $sub_module_id, $err_severity, $err_sev);
 
     $num_args = $#ARGV + 1;
     $platform_id = 0;
@@ -1614,13 +1614,18 @@ sub vendor_errors_summary
 
     # HiSilicon Kunpeng9xx common errors
     if ($platform_id eq HISILICON_KUNPENG_9XX) {
-        $query = "select err_info, count(*) from hisi_common_section";
+        $query = "select err_severity, module_id, count(*) from hisi_common_section_v2 group by err_severity, module_id";
         $query_handle = $dbh->prepare($query);
         $query_handle->execute();
-        $query_handle->bind_columns(\($err_info, $count));
+        $query_handle->bind_columns(\($err_severity, $module_id, $count));
         $out = "";
+        $err_sev = "";
         while($query_handle->fetch()) {
-            $out .= "\terrors: $count\n";
+            if ($err_severity ne $err_sev) {
+                $out .= "$err_severity errors:\n";
+                $err_sev = $err_severity;
+            }
+            $out .= "\t$module_id: $count\n";
         }
         if ($out ne "") {
             print "HiSilicon Kunpeng9xx common error events summary:\n$out\n";
@@ -1638,8 +1643,8 @@ sub vendor_errors
     require DBI;
     my ($num_args, $platform_id);
     my ($query, $query_handle, $id, $timestamp, $out);
-    my ($version, $soc_id, $socket_id, $nimbus_id, $core_id, $port_id);
-    my ($module_id, $sub_module_id, $err_severity, $err_type, $err_info, $regs);
+    my ($version, $soc_id, $socket_id, $totem_id, $nimbus_id, $sub_system_id, $core_id, $port_id);
+    my ($module_id, $sub_module_id, $err_severity, $err_type, $pcie_info, $regs);
 
     $num_args = $#ARGV + 1;
     $platform_id = 0;
@@ -1727,15 +1732,28 @@ sub vendor_errors
 
     # HiSilicon Kunpeng9xx common errors
     if ($platform_id eq HISILICON_KUNPENG_9XX) {
-        $query = "select id, timestamp, err_info, regs_dump from hisi_common_section order by id";
+        $query = "select id, timestamp, version, soc_id, socket_id, totem_id, nimbus_id, sub_system_id, module_id, sub_module_id, core_id, port_id, err_type, pcie_info, err_severity, regs_dump from hisi_common_section_v2 order by id, module_id, err_severity";
         $query_handle = $dbh->prepare($query);
         $query_handle->execute();
-        $query_handle->bind_columns(\($id, $timestamp, $err_info, $regs));
+        $query_handle->bind_columns(\($id, $timestamp, $version, $soc_id, $socket_id, $totem_id, $nimbus_id, $sub_system_id, $module_id, $sub_module_id, $core_id, $port_id, $err_type, $pcie_info, $err_severity, $regs));
         $out = "";
         while($query_handle->fetch()) {
-            $out .= "$id. $timestamp ";
-            $out .= "Error Info:$err_info \n" if ($err_info);
-            $out .= "Error Registers: $regs\n\n" if ($regs);
+            $out .= "$id. $timestamp Error Info: ";
+            $out .= "version=$version, ";
+            $out .= "soc_id=$soc_id, " if ($soc_id);
+            $out .= "socket_id=$socket_id, " if ($socket_id);
+            $out .= "totem_id=$totem_id, " if ($totem_id);
+            $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
+            $out .= "sub_system_id=$sub_system_id, " if ($sub_system_id);
+            $out .= "module_id=$module_id, " if ($module_id);
+            $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
+            $out .= "core_id=$core_id, " if ($core_id);
+            $out .= "port_id=$port_id, " if ($port_id);
+            $out .= "err_type=$err_type, " if ($err_type);
+            $out .= "pcie_info=$pcie_info, " if ($pcie_info);
+            $out .= "err_severity=$err_severity, " if ($err_severity);
+            $out .= "Error Registers: $regs" if ($regs);
+            $out .= "\n\n";
         }
         if ($out ne "") {
             print "HiSilicon Kunpeng9xx common error events:\n$out\n";
-- 
2.25.1

