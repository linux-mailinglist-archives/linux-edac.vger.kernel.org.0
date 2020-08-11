Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69121241B00
	for <lists+linux-edac@lfdr.de>; Tue, 11 Aug 2020 14:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgHKMeo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Aug 2020 08:34:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2592 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728523AbgHKMeo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 Aug 2020 08:34:44 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5FCA8EC9C821B77EE3E7;
        Tue, 11 Aug 2020 13:34:42 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.25.149) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 11 Aug 2020 13:34:42 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab+huawei@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH 1/1] rasdaemon: ras-mc-ctl: Add ARM processor error information
Date:   Tue, 11 Aug 2020 13:31:46 +0100
Message-ID: <20200811123146.1409-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.25.149]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add supporting ARM processor error in the ras-mc-ctl tool.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index ff38143..dd7d56f 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1123,6 +1123,7 @@ sub summary
     my ($err_type, $label, $mc, $top, $mid, $low, $count, $msg);
     my ($etype, $severity, $etype_string, $severity_string);
     my ($dev_name, $dev);
+    my ($affinity, $mpidr);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1158,6 +1159,22 @@ sub summary
     }
     $query_handle->finish;
 
+    # ARM processor arm_event errors
+    $query = "select affinity, mpidr, count(*) from arm_event group by affinity, mpidr";
+    $query_handle = $dbh->prepare($query);
+    $query_handle->execute();
+    $query_handle->bind_columns(\($affinity, $mpidr, $count));
+    $out = "";
+    while($query_handle->fetch()) {
+        $out .= "\t$count errors\n";
+    }
+    if ($out ne "") {
+        print "ARM processor events summary:\n$out\n";
+    } else {
+        print "No ARM processor errors.\n\n";
+    }
+    $query_handle->finish;
+
     # extlog errors
     $query = "select etype, severity, count(*) from extlog_event group by etype, severity";
     $query_handle = $dbh->prepare($query);
@@ -1235,6 +1252,7 @@ sub errors
     my ($timestamp, $etype, $severity, $etype_string, $severity_string, $fru_id, $fru_text, $cper_data);
     my ($bus_name, $dev_name, $driver_name, $reporter_name);
     my ($dev, $sector, $nr_sector, $error, $rwbs, $cmd);
+    my ($error_count, $affinity, $mpidr, $r_state, $psci_state);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1274,6 +1292,28 @@ sub errors
     }
     $query_handle->finish;
 
+    # ARM processor arm_event errors
+    $query = "select id, timestamp, error_count, affinity, mpidr, running_state, psci_state from arm_event order by id";
+    $query_handle = $dbh->prepare($query);
+    $query_handle->execute();
+    $query_handle->bind_columns(\($id, $timestamp, $error_count, $affinity, $mpidr, $r_state, $psci_state));
+    $out = "";
+    while($query_handle->fetch()) {
+        $out .= "$id $timestamp error: ";
+        $out .= "error_count=$error_count, " if ($error_count);
+        $out .= "affinity_level=$affinity, ";
+        $out .= sprintf "mpidr=0x%x, ", $mpidr;
+        $out .= sprintf "running_state=0x%x, ", $r_state;
+        $out .= sprintf "psci_state=0x%x", $psci_state;
+        $out .= "\n";
+    }
+    if ($out ne "") {
+        print "ARM processor events:\n$out\n";
+    } else {
+        print "No ARM processor errors.\n\n";
+    }
+    $query_handle->finish;
+
     # Extlog errors
     $query = "select id, timestamp, etype, severity, address, fru_id, fru_text, cper_data from extlog_event order by id";
     $query_handle = $dbh->prepare($query);
-- 
2.17.1


