Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4FB2A47FF
	for <lists+linux-edac@lfdr.de>; Tue,  3 Nov 2020 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgKCO0P (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Nov 2020 09:26:15 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729726AbgKCO0P (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 3 Nov 2020 09:26:15 -0500
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 2E361F33BF006CF69B44;
        Tue,  3 Nov 2020 14:26:14 +0000 (GMT)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.30) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Tue, 3 Nov 2020 14:26:13 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH 2/3] rasdaemon: ras-mc-ctl: Add memory failure events
Date:   Tue, 3 Nov 2020 14:22:57 +0000
Message-ID: <20201103142258.1253-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201103142258.1253-1-shiju.jose@huawei.com>
References: <20201103142258.1253-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.85.30]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
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

