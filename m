Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600492A480D
	for <lists+linux-edac@lfdr.de>; Tue,  3 Nov 2020 15:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgKCO0t (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Nov 2020 09:26:49 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3031 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729762AbgKCO0s (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 3 Nov 2020 09:26:48 -0500
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 48203B142090872E4644;
        Tue,  3 Nov 2020 14:26:47 +0000 (GMT)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.30) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Tue, 3 Nov 2020 14:26:46 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH 3/3] rasdaemon: ras-mc-ctl: Add exception handling
Date:   Tue, 3 Nov 2020 14:22:58 +0000
Message-ID: <20201103142258.1253-4-shiju.jose@huawei.com>
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

Add exception handling in the ras-mc-ctl.

For example, when an event's table is not present in the SQLite DB,
then the DBI would detect exception and ras-mc-ctl exit without
read and log remaining event's information. This would happen
when an event is not enabled in the rasdaemon. Following is the
error log when the devlink_event table is not present in the DB,
"DBD::SQLite::db prepare failed: no such table: devlink_event at ./ras-mc-ctl line 1198.
Can't call method "execute" on an undefined value at ./ras-mc-ctl line 1199"

Also disabled the DBI's automatic error logging by setting
the $dbh->{PrintError} = 0 to avoid duplicate exception logs.

Reported-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 632 +++++++++++++++++++++++++--------------------
 1 file changed, 352 insertions(+), 280 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index eebcc4e..07b52e9 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -34,6 +34,7 @@ use File::Basename;
 use File::Find;
 use Getopt::Long;
 use POSIX;
+use Try::Tiny;
 
 my $dbname      = "@RASSTATEDIR@/@RAS_DB_FNAME@";
 my $prefix      = "@prefix@";
@@ -1126,136 +1127,171 @@ sub summary
     my ($mpidr);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
+    # Disable the DBI automatic exception log
+    $dbh->{PrintError} = 0;
 
     # Memory controller mc_event errors
-    $query = "select err_type, label, mc, top_layer,middle_layer,lower_layer, count(*) from mc_event group by err_type, label, mc, top_layer, middle_layer, lower_layer";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($err_type, $label, $mc, $top, $mid, $low, $count));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "\t$err_type on DIMM Label(s): '$label' location: $mc:$top:$mid:$low errors: $count\n";
-    }
-    if ($out ne "") {
-        print "Memory controller events summary:\n$out\n";
-    } else {
-        print "No Memory errors.\n\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select err_type, label, mc, top_layer,middle_layer,lower_layer, count(*) from mc_event group by err_type, label, mc, top_layer, middle_layer, lower_layer";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($err_type, $label, $mc, $top, $mid, $low, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$err_type on DIMM Label(s): '$label' location: $mc:$top:$mid:$low errors: $count\n";
+        }
+        if ($out ne "") {
+            print "Memory controller events summary:\n$out\n";
+        } else {
+            print "No Memory errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n";
+        log_error ("mc_event table missing from $dbname. Run 'rasdaemon --record'.\n\n");
+    };
 
     # PCIe AER aer_event errors
-    $query = "select err_type, err_msg, count(*) from aer_event group by err_type, err_msg";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($err_type, $msg, $count));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "\t$count $err_type errors: $msg\n";
-    }
-    if ($out ne "") {
-        print "PCIe AER events summary:\n$out\n";
-    } else {
-        print "No PCIe AER errors.\n\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select err_type, err_msg, count(*) from aer_event group by err_type, err_msg";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($err_type, $msg, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$count $err_type errors: $msg\n";
+        }
+        if ($out ne "") {
+            print "PCIe AER events summary:\n$out\n";
+        } else {
+            print "No PCIe AER errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     # ARM processor arm_event errors
-    $query = "select mpidr, count(*) from arm_event group by mpidr";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($mpidr, $count));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= sprintf "\tCPU(mpidr=0x%x) has %d errors\n", $mpidr, $count;
-    }
-    if ($out ne "") {
-        print "ARM processor events summary:\n$out\n";
-    } else {
-        print "No ARM processor errors.\n\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select mpidr, count(*) from arm_event group by mpidr";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($mpidr, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= sprintf "\tCPU(mpidr=0x%x) has %d errors\n", $mpidr, $count;
+        }
+        if ($out ne "") {
+            print "ARM processor events summary:\n$out\n";
+        } else {
+            print "No ARM processor errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     # extlog errors
-    $query = "select etype, severity, count(*) from extlog_event group by etype, severity";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($etype, $severity, $count));
-    $out = "";
-    while($query_handle->fetch()) {
-        $etype_string = get_extlog_type($etype);
-        $severity_string = get_extlog_severity($severity);
-        $out .= "\t$count $etype_string $severity_string errors\n";
-    }
-    if ($out ne "") {
-        print "Extlog records summary:\n$out";
-    } else {
-        print "No Extlog errors.\n\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select etype, severity, count(*) from extlog_event group by etype, severity";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($etype, $severity, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $etype_string = get_extlog_type($etype);
+            $severity_string = get_extlog_severity($severity);
+            $out .= "\t$count $etype_string $severity_string errors\n";
+        }
+        if ($out ne "") {
+            print "Extlog records summary:\n$out";
+        } else {
+            print "No Extlog errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     # devlink errors
-    $query = "select dev_name, count(*) from devlink_event group by dev_name";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($dev_name, $count));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "\t$dev_name has $count errors\n";
-    }
-    if ($out ne "") {
-        print "Devlink records summary:\n$out";
-    } else {
-        print "No devlink errors.\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select dev_name, count(*) from devlink_event group by dev_name";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($dev_name, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$dev_name has $count errors\n";
+        }
+        if ($out ne "") {
+            print "Devlink records summary:\n$out";
+        } else {
+            print "No devlink errors.\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     # Disk errors
-    $query = "select dev, count(*) from disk_errors group by dev";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($dev, $count));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "\t$dev has $count errors\n";
-    }
-    if ($out ne "") {
-        print "Disk errors summary:\n$out";
-    } else {
-        print "No disk errors.\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select dev, count(*) from disk_errors group by dev";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($dev, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$dev has $count errors\n";
+        }
+        if ($out ne "") {
+            print "Disk errors summary:\n$out";
+        } else {
+            print "No disk errors.\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     # Memory failure errors
-    $query = "select action_result, count(*) from memory_failure_event group by action_result";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($action_result, $count));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "\t$action_result errors: $count\n";
-    }
-    if ($out ne "") {
-        print "Memory failure events summary:\n$out\n";
-    } else {
-        print "No Memory failure errors.\n\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select action_result, count(*) from memory_failure_event group by action_result";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($action_result, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$action_result errors: $count\n";
+        }
+        if ($out ne "") {
+            print "Memory failure events summary:\n$out\n";
+        } else {
+            print "No Memory failure errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     # MCE mce_record errors
-    $query = "select error_msg, count(*) from mce_record group by error_msg";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($msg, $count));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "\t$count $msg errors\n";
-    }
-    if ($out ne "") {
-        print "MCE records summary:\n$out";
-    } else {
-        print "No MCE errors.\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select error_msg, count(*) from mce_record group by error_msg";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($msg, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$count $msg errors\n";
+        }
+        if ($out ne "") {
+            print "MCE records summary:\n$out";
+        } else {
+            print "No MCE errors.\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     undef($dbh);
 }
@@ -1272,189 +1308,225 @@ sub errors
     my ($pfn, $page_type, $action_result);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
+    # Disable the DBI automatic exception log
+    $dbh->{PrintError} = 0;
 
     # Memory controller mc_event errors
-    $query = "select id, timestamp, err_count, err_type, err_msg, label, mc, top_layer,middle_layer,lower_layer, address, grain, syndrome, driver_detail from mc_event order by id";
-    $query_handle = $dbh->prepare($query);
-    if (!$query_handle) {
+    try {
+        $query = "select id, timestamp, err_count, err_type, err_msg, label, mc, top_layer,middle_layer,lower_layer, address, grain, syndrome, driver_detail from mc_event order by id";
+        $query_handle = $dbh->prepare($query);
+        if (!$query_handle) {
+            log_error ("mc_event table missing from $dbname. Run 'rasdaemon --record'.\n");
+            exit -1
+        }
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $time, $count, $type, $msg, $label, $mc, $top, $mid, $low, $addr, $grain, $syndrome, $detail));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $time $count $type error(s): $msg at $label location: $mc:$top:$mid:$low, addr $addr, grain $grain, syndrome $syndrome $detail\n";
+        }
+        if ($out ne "") {
+            print "Memory controller events:\n$out\n";
+        } else {
+            print "No Memory errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
         log_error ("mc_event table missing from $dbname. Run 'rasdaemon --record'.\n");
-        exit -1
-    }
-    $query_handle->execute();
-    $query_handle->bind_columns(\($id, $time, $count, $type, $msg, $label, $mc, $top, $mid, $low, $addr, $grain, $syndrome, $detail));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "$id $time $count $type error(s): $msg at $label location: $mc:$top:$mid:$low, addr $addr, grain $grain, syndrome $syndrome $detail\n";
-    }
-    if ($out ne "") {
-        print "Memory controller events:\n$out\n";
-    } else {
-        print "No Memory errors.\n\n";
-    }
-    $query_handle->finish;
+	exit -1
+    };
 
     # PCIe AER aer_event errors
-    $query = "select id, timestamp, dev_name, err_type, err_msg from aer_event order by id";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($id, $time, $devname, $type, $msg));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "$id $time $devname $type error: $msg\n";
-    }
-    if ($out ne "") {
-        print "PCIe AER events:\n$out\n";
-    } else {
-        print "No PCIe AER errors.\n\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select id, timestamp, dev_name, err_type, err_msg from aer_event order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $time, $devname, $type, $msg));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $time $devname $type error: $msg\n";
+        }
+        if ($out ne "") {
+            print "PCIe AER events:\n$out\n";
+        } else {
+           print "No PCIe AER errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     # ARM processor arm_event errors
-    $query = "select id, timestamp, error_count, affinity, mpidr, running_state, psci_state from arm_event order by id";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($id, $timestamp, $error_count, $affinity, $mpidr, $r_state, $psci_state));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "$id $timestamp error: ";
-        $out .= "error_count=$error_count, " if ($error_count);
-        $out .= "affinity_level=$affinity, ";
-        $out .= sprintf "mpidr=0x%x, ", $mpidr;
-        $out .= sprintf "running_state=0x%x, ", $r_state;
-        $out .= sprintf "psci_state=0x%x", $psci_state;
-        $out .= "\n";
-    }
-    if ($out ne "") {
-        print "ARM processor events:\n$out\n";
-    } else {
-        print "No ARM processor errors.\n\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select id, timestamp, error_count, affinity, mpidr, running_state, psci_state from arm_event order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $error_count, $affinity, $mpidr, $r_state, $psci_state));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $timestamp error: ";
+            $out .= "error_count=$error_count, " if ($error_count);
+            $out .= "affinity_level=$affinity, ";
+            $out .= sprintf "mpidr=0x%x, ", $mpidr;
+            $out .= sprintf "running_state=0x%x, ", $r_state;
+            $out .= sprintf "psci_state=0x%x", $psci_state;
+            $out .= "\n";
+        }
+        if ($out ne "") {
+            print "ARM processor events:\n$out\n";
+        } else {
+            print "No ARM processor errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     # Extlog errors
-    $query = "select id, timestamp, etype, severity, address, fru_id, fru_text, cper_data from extlog_event order by id";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($id, $timestamp, $etype, $severity, $addr, $fru_id, $fru_text, $cper_data));
-    $out = "";
-    while($query_handle->fetch()) {
-        $etype_string = get_extlog_type($etype);
-        $severity_string = get_extlog_severity($severity);
-        $out .= "$id $timestamp error: ";
-        $out .= "type=$etype_string, ";
-        $out .= "severity=$severity_string, ";
-        $out .= sprintf "address=0x%08x, ", $addr;
-        $out .= sprintf "fru_id=%s, ", get_uuid_le($fru_id);
-        $out .= "fru_text='$fru_text', ";
-        $out .= get_cper_data_text($cper_data) if ($cper_data);
-        $out .= "\n";
-    }
-    if ($out ne "") {
-        print "Extlog events:\n$out\n";
-    } else {
-        print "No Extlog errors.\n\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select id, timestamp, etype, severity, address, fru_id, fru_text, cper_data from extlog_event order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $etype, $severity, $addr, $fru_id, $fru_text, $cper_data));
+        $out = "";
+        while($query_handle->fetch()) {
+            $etype_string = get_extlog_type($etype);
+            $severity_string = get_extlog_severity($severity);
+            $out .= "$id $timestamp error: ";
+            $out .= "type=$etype_string, ";
+            $out .= "severity=$severity_string, ";
+            $out .= sprintf "address=0x%08x, ", $addr;
+            $out .= sprintf "fru_id=%s, ", get_uuid_le($fru_id);
+            $out .= "fru_text='$fru_text', ";
+            $out .= get_cper_data_text($cper_data) if ($cper_data);
+            $out .= "\n";
+        }
+        if ($out ne "") {
+            print "Extlog events:\n$out\n";
+        } else {
+            print "No Extlog errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     # devlink errors
-    $query = "select id, timestamp, bus_name, dev_name, driver_name, reporter_name, msg from devlink_event order by id";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($id, $timestamp, $bus_name, $dev_name, $driver_name, $reporter_name, $msg));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "$id $timestamp error: ";
-        $out .= "bus_name=$bus_name, ";
-        $out .= "dev_name=$dev_name, ";
-        $out .= "driver_name=$driver_name, ";
-        $out .= "reporter_name=$reporter_name, ";
-        $out .= "message='$msg', ";
-        $out .= "\n";
-    }
-    if ($out ne "") {
-        print "Devlink events:\n$out\n";
-    } else {
-        print "No devlink errors.\n\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select id, timestamp, bus_name, dev_name, driver_name, reporter_name, msg from devlink_event order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $bus_name, $dev_name, $driver_name, $reporter_name, $msg));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $timestamp error: ";
+            $out .= "bus_name=$bus_name, ";
+            $out .= "dev_name=$dev_name, ";
+            $out .= "driver_name=$driver_name, ";
+            $out .= "reporter_name=$reporter_name, ";
+            $out .= "message='$msg', ";
+            $out .= "\n";
+        }
+        if ($out ne "") {
+            print "Devlink events:\n$out\n";
+        } else {
+            print "No devlink errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     # Disk errors
-    $query = "select id, timestamp, dev, sector, nr_sector, error, rwbs, cmd from disk_errors order by id";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($id, $timestamp, $dev, $sector, $nr_sector, $error, $rwbs, $cmd));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "$id $timestamp error: ";
-        $out .= "dev=$dev, ";
-        $out .= "sector=$sector, ";
-        $out .= "nr_sector=$nr_sector, ";
-        $out .= "error='$error', ";
-        $out .= "rwbs='$rwbs', ";
-        $out .= "cmd='$cmd', ";
-        $out .= "\n";
-    }
-    if ($out ne "") {
-        print "Disk errors\n$out\n";
-    } else {
-        print "No disk errors.\n\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select id, timestamp, dev, sector, nr_sector, error, rwbs, cmd from disk_errors order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $dev, $sector, $nr_sector, $error, $rwbs, $cmd));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $timestamp error: ";
+            $out .= "dev=$dev, ";
+            $out .= "sector=$sector, ";
+            $out .= "nr_sector=$nr_sector, ";
+            $out .= "error='$error', ";
+            $out .= "rwbs='$rwbs', ";
+            $out .= "cmd='$cmd', ";
+           $out .= "\n";
+        }
+        if ($out ne "") {
+            print "Disk errors\n$out\n";
+        } else {
+            print "No disk errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     # Memory failure errors
-    $query = "select id, timestamp, pfn, page_type, action_result from memory_failure_event order by id";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($id, $timestamp, $pfn, $page_type, $action_result));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "$id $timestamp error: ";
-        $out .= "pfn=$pfn, page_type=$page_type, action_result=$action_result\n";
-    }
-    if ($out ne "") {
-        print "Memory failure events:\n$out\n";
-    } else {
-        print "No Memory failure errors.\n\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select id, timestamp, pfn, page_type, action_result from memory_failure_event order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $pfn, $page_type, $action_result));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $timestamp error: ";
+            $out .= "pfn=$pfn, page_type=$page_type, action_result=$action_result\n";
+        }
+        if ($out ne "") {
+            print "Memory failure events:\n$out\n";
+        } else {
+            print "No Memory failure errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     # MCE mce_record errors
-    $query = "select id, timestamp, mcgcap, mcgstatus, status, addr, misc, ip, tsc, walltime, cpu, cpuid, apicid, socketid, cs, bank, cpuvendor, bank_name, error_msg, mcgstatus_msg, mcistatus_msg, user_action, mc_location from mce_record order by id";
-    $query_handle = $dbh->prepare($query);
-    $query_handle->execute();
-    $query_handle->bind_columns(\($id, $time, $mcgcap,$mcgstatus, $status, $addr, $misc, $ip, $tsc, $walltime, $cpu, $cpuid, $apicid, $socketid, $cs, $bank, $cpuvendor, $bank_name, $msg, $mcgstatus_msg, $mcistatus_msg, $user_action, $mc_location));
-    $out = "";
-    while($query_handle->fetch()) {
-        $out .= "$id $time error: $msg";
-	$out .= ", CPU $cpuvendor" if ($cpuvendor);
-	$out .= ", bank $bank_name" if ($bank_name);
-	$out .= ", mcg $mcgstatus_msg" if ($mcgstatus_msg);
-	$out .= ", mci $mcistatus_msg" if ($mcistatus_msg);
-	$out .= ", $mc_location" if ($mc_location);
-	$out .= ", $user_action" if ($user_action);
-	$out .= sprintf ", mcgcap=0x%08x", $mcgcap if ($mcgcap);
-	$out .= sprintf ", mcgstatus=0x%08x", $mcgstatus if ($mcgstatus);
-	$out .= sprintf ", status=0x%08x", $status if ($status);
-	$out .= sprintf ", addr=0x%08x", $addr if ($addr);
-	$out .= sprintf ", misc=0x%08x", $misc if ($misc);
-	$out .= sprintf ", ip=0x%08x", $ip if ($ip);
-	$out .= sprintf ", tsc=0x%08x", $tsc if ($tsc);
-	$out .= sprintf ", walltime=0x%08x", $walltime if ($walltime);
-	$out .= sprintf ", cpu=0x%08x", $cpu if ($cpu);
-	$out .= sprintf ", cpuid=0x%08x", $cpuid if ($cpuid);
-	$out .= sprintf ", apicid=0x%08x", $apicid if ($apicid);
-	$out .= sprintf ", socketid=0x%08x", $socketid if ($socketid);
-	$out .= sprintf ", cs=0x%08x", $cs if ($cs);
-	$out .= sprintf ", bank=0x%08x", $bank if ($bank);
-
-	$out .= "\n";
-    }
-    if ($out ne "") {
-        print "MCE events:\n$out\n";
-    } else {
-        print "No MCE errors.\n\n";
-    }
-    $query_handle->finish;
+    try {
+        $query = "select id, timestamp, mcgcap, mcgstatus, status, addr, misc, ip, tsc, walltime, cpu, cpuid, apicid, socketid, cs, bank, cpuvendor, bank_name, error_msg, mcgstatus_msg, mcistatus_msg, user_action, mc_location from mce_record order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $time, $mcgcap,$mcgstatus, $status, $addr, $misc, $ip, $tsc, $walltime, $cpu, $cpuid, $apicid, $socketid, $cs, $bank, $cpuvendor, $bank_name, $msg, $mcgstatus_msg, $mcistatus_msg, $user_action, $mc_location));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $time error: $msg";
+	    $out .= ", CPU $cpuvendor" if ($cpuvendor);
+	    $out .= ", bank $bank_name" if ($bank_name);
+	    $out .= ", mcg $mcgstatus_msg" if ($mcgstatus_msg);
+	    $out .= ", mci $mcistatus_msg" if ($mcistatus_msg);
+	    $out .= ", $mc_location" if ($mc_location);
+	    $out .= ", $user_action" if ($user_action);
+	    $out .= sprintf ", mcgcap=0x%08x", $mcgcap if ($mcgcap);
+	    $out .= sprintf ", mcgstatus=0x%08x", $mcgstatus if ($mcgstatus);
+	    $out .= sprintf ", status=0x%08x", $status if ($status);
+	    $out .= sprintf ", addr=0x%08x", $addr if ($addr);
+	    $out .= sprintf ", misc=0x%08x", $misc if ($misc);
+	    $out .= sprintf ", ip=0x%08x", $ip if ($ip);
+	    $out .= sprintf ", tsc=0x%08x", $tsc if ($tsc);
+	    $out .= sprintf ", walltime=0x%08x", $walltime if ($walltime);
+	    $out .= sprintf ", cpu=0x%08x", $cpu if ($cpu);
+	    $out .= sprintf ", cpuid=0x%08x", $cpuid if ($cpuid);
+	    $out .= sprintf ", apicid=0x%08x", $apicid if ($apicid);
+	    $out .= sprintf ", socketid=0x%08x", $socketid if ($socketid);
+	    $out .= sprintf ", cs=0x%08x", $cs if ($cs);
+	    $out .= sprintf ", bank=0x%08x", $bank if ($bank);
+
+	    $out .= "\n";
+        }
+        if ($out ne "") {
+            print "MCE events:\n$out\n";
+        } else {
+            print "No MCE errors.\n\n";
+        }
+        $query_handle->finish;
+    } catch {
+        print "Exception: $DBI::errstr\n\n";
+    };
 
     undef($dbh);
 }
-- 
2.17.1

