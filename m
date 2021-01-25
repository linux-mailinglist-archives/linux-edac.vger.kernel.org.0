Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39173028A3
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jan 2021 18:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbhAYRTO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jan 2021 12:19:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2422 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbhAYRSx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jan 2021 12:18:53 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPc1W0hvHz67gTc;
        Tue, 26 Jan 2021 01:14:55 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 18:18:12 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.115) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 17:18:11 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@openeuler.org>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH v2 3/8] rasdaemon: ras-mc-ctl: Add memory failure events
Date:   Mon, 25 Jan 2021 17:14:50 +0000
Message-ID: <20210125171455.1886-4-shiju.jose@huawei.com>
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

Add supporting memory failure errors (memory_failure_event)
to the ras-mc-ctl tool.

Sample Log,
ras-mc-ctl --summary
...
Memory failure events summary:
        Delayed errors: 4
        Failed errors: 1
...

ras-mc-ctl --errors
...
Memory failure events:
1 2020-10-28 23:20:41 -0800 error: pfn=0x204000000, page_type=free buddy page, action_result=Delayed
2 2020-10-28 23:31:38 -0800 error: pfn=0x204000000, page_type=free buddy page, action_result=Delayed
3 2020-10-28 23:54:54 -0800 error: pfn=0x205000000, page_type=free buddy page, action_result=Delayed
4 2020-10-29 00:12:25 -0800 error: pfn=0x204000000, page_type=free buddy page, action_result=Delayed
5 2020-10-29 00:26:36 -0800 error: pfn=0x204000000, page_type=free buddy page, action_result=Failed

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index d8abdbd..eebcc4e 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1120,7 +1120,7 @@ sub summary
 {
     require DBI;
     my ($query, $query_handle, $out);
-    my ($err_type, $label, $mc, $top, $mid, $low, $count, $msg);
+    my ($err_type, $label, $mc, $top, $mid, $low, $count, $msg, $action_result);
     my ($etype, $severity, $etype_string, $severity_string);
     my ($dev_name, $dev);
     my ($mpidr);
@@ -1225,6 +1225,22 @@ sub summary
     }
     $query_handle->finish;
 
+    # Memory failure errors
+    $query = "select action_result, count(*) from memory_failure_event group by action_result";
+    $query_handle = $dbh->prepare($query);
+    $query_handle->execute();
+    $query_handle->bind_columns(\($action_result, $count));
+    $out = "";
+    while($query_handle->fetch()) {
+        $out .= "\t$action_result errors: $count\n";
+    }
+    if ($out ne "") {
+        print "Memory failure events summary:\n$out\n";
+    } else {
+        print "No Memory failure errors.\n\n";
+    }
+    $query_handle->finish;
+
     # MCE mce_record errors
     $query = "select error_msg, count(*) from mce_record group by error_msg";
     $query_handle = $dbh->prepare($query);
@@ -1253,6 +1269,7 @@ sub errors
     my ($bus_name, $dev_name, $driver_name, $reporter_name);
     my ($dev, $sector, $nr_sector, $error, $rwbs, $cmd);
     my ($error_count, $affinity, $mpidr, $r_state, $psci_state);
+    my ($pfn, $page_type, $action_result);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1384,6 +1401,23 @@ sub errors
     }
     $query_handle->finish;
 
+    # Memory failure errors
+    $query = "select id, timestamp, pfn, page_type, action_result from memory_failure_event order by id";
+    $query_handle = $dbh->prepare($query);
+    $query_handle->execute();
+    $query_handle->bind_columns(\($id, $timestamp, $pfn, $page_type, $action_result));
+    $out = "";
+    while($query_handle->fetch()) {
+        $out .= "$id $timestamp error: ";
+        $out .= "pfn=$pfn, page_type=$page_type, action_result=$action_result\n";
+    }
+    if ($out ne "") {
+        print "Memory failure events:\n$out\n";
+    } else {
+        print "No Memory failure errors.\n\n";
+    }
+    $query_handle->finish;
+
     # MCE mce_record errors
     $query = "select id, timestamp, mcgcap, mcgstatus, status, addr, misc, ip, tsc, walltime, cpu, cpuid, apicid, socketid, cs, bank, cpuvendor, bank_name, error_msg, mcgstatus_msg, mcistatus_msg, user_action, mc_location from mce_record order by id";
     $query_handle = $dbh->prepare($query);
-- 
2.17.1

