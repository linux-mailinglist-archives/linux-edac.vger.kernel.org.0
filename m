Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055DE3028A6
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jan 2021 18:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbhAYRTn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jan 2021 12:19:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2423 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbhAYRTe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jan 2021 12:19:34 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPbzL0tcWz67glm;
        Tue, 26 Jan 2021 01:13:02 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 18:18:48 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.115) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 17:18:47 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@openeuler.org>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH v2 4/8] rasdaemon: ras-mc-ctl: Fix for exception when an event is not enabled
Date:   Mon, 25 Jan 2021 17:14:51 +0000
Message-ID: <20210125171455.1886-5-shiju.jose@huawei.com>
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

When an event is not enabled in the build and thus the event's table
is not present in the SQLite DB, then the DBI would detect exception
and ras-mc-ctl exit without read and log remaining event's information.
Following is the error log when the devlink_event is not enabled,
"DBD::SQLite::db prepare failed: no such table: devlink_event at ./ras-mc-ctl line 1198.
Can't call method "execute" on an undefined value at ./ras-mc-ctl line 1199"

Add an extra check, whether an event is enabled in the build,
before try reading the tables.

Reported-by: Xiaofei Tan <tanxiaofei@huawei.com>
Suggested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 configure.ac       |   7 +
 util/ras-mc-ctl.in | 506 ++++++++++++++++++++++++---------------------
 2 files changed, 278 insertions(+), 235 deletions(-)

diff --git a/configure.ac b/configure.ac
index a6251d4..9893bb4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -42,6 +42,7 @@ AC_SUBST([SQLITE3_LIBS])
 
 AC_ARG_ENABLE([aer],
     AS_HELP_STRING([--enable-aer], [enable PCIe AER events (currently experimental)]))
+AC_SUBST([enable_aer])
 
 AS_IF([test "x$enable_aer" = "xyes" || test "x$enable_all" == "xyes"], [
   AC_DEFINE(HAVE_AER,1,"have PCIe AER events collect")
@@ -63,6 +64,7 @@ AM_COND_IF([WITH_NON_STANDARD], [USE_NON_STANDARD="yes"], [USE_NON_STANDARD="no"
 
 AC_ARG_ENABLE([arm],
     AS_HELP_STRING([--enable-arm], [enable ARM events (currently experimental)]))
+AC_SUBST([enable_arm])
 
 AS_IF([test "x$enable_arm" = "xyes" || test "x$enable_all" == "xyes"], [
   AC_DEFINE(HAVE_ARM,1,"have ARM events collect")
@@ -73,6 +75,7 @@ AM_COND_IF([WITH_ARM], [USE_ARM="yes"], [USE_ARM="no"])
 
 AC_ARG_ENABLE([mce],
     AS_HELP_STRING([--enable-mce], [enable MCE events (currently experimental)]))
+AC_SUBST([enable_mce])
 
 AS_IF([test "x$enable_mce" = "xyes" || test "x$enable_all" == "xyes"], [
   AC_DEFINE(HAVE_MCE,1,"have PCIe MCE events collect")
@@ -83,6 +86,7 @@ AM_COND_IF([WITH_MCE], [USE_MCE="yes"], [USE_MCE="no"])
 
 AC_ARG_ENABLE([extlog],
     AS_HELP_STRING([--enable-extlog], [enable EXTLOG events (currently experimental)]))
+AC_SUBST([enable_extlog])
 
 AS_IF([test "x$enable_extlog" = "xyes" || test "x$enable_all" == "xyes"], [
   AC_DEFINE(HAVE_EXTLOG,1,"have EXTLOG events collect")
@@ -93,6 +97,7 @@ AM_COND_IF([WITH_EXTLOG], [USE_EXTLOG="yes"], [USE_EXTLOG="no"])
 
 AC_ARG_ENABLE([devlink],
     AS_HELP_STRING([--enable-devlink], [enable devlink health events (currently experimental)]))
+AC_SUBST([enable_devlink])
 
 AS_IF([test "x$enable_devlink" = "xyes" || test "x$enable_all" == "xyes"], [
   AC_DEFINE(HAVE_DEVLINK,1,"have devlink health events collect")
@@ -103,6 +108,7 @@ AM_COND_IF([WITH_DEVLINK], [USE_DEVLINK="yes"], [USE_DEVLINK="no"])
 
 AC_ARG_ENABLE([diskerror],
     AS_HELP_STRING([--enable-diskerror], [enable disk I/O error events (currently experimental)]))
+AC_SUBST([enable_diskerror])
 
 AS_IF([test "x$enable_diskerror" = "xyes" || test "x$enable_all" == "xyes"], [
   AC_DEFINE(HAVE_DISKERROR,1,"have disk I/O errors collect")
@@ -113,6 +119,7 @@ AM_COND_IF([WITH_DISKERROR], [USE_DISKERROR="yes"], [USE_DISKERROR="no"])
 
 AC_ARG_ENABLE([memory_failure],
     AS_HELP_STRING([--enable-memory-failure], [enable memory failure events (currently experimental)]))
+AC_SUBST([enable_memory_failure])
 
 AS_IF([test "x$enable_memory_failure" = "xyes" || test "x$enable_all" == "xyes"], [
   AC_DEFINE(HAVE_MEMORY_FAILURE,1,"have memory failure events collect")
diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index eebcc4e..97b1fa4 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -65,6 +65,14 @@ $conf{mbconfig} = "$sysconfdir/ras/mainboard";
 
 my $status      = 0;
 
+my $enable_aer = "@enable_aer@";
+my $enable_arm = "@enable_arm@";
+my $enable_mce = "@enable_mce@";
+my $enable_extlog = "@enable_extlog@";
+my $enable_devlink = "@enable_devlink@";
+my $enable_diskerror = "@enable_diskerror@";
+my $enable_mem_failure = "@enable_memory_failure@";
+
 my $usage       = <<EOF;
 Usage: $prog [OPTIONS...]
  --quiet            Quiet operation.
@@ -1144,118 +1152,132 @@ sub summary
     $query_handle->finish;
 
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
+    if ($enable_aer eq "yes") {
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
     }
-    $query_handle->finish;
 
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
+    if ($enable_arm eq "yes") {
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
     }
-    $query_handle->finish;
 
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
+    if ($enable_extlog eq "yes") {
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
     }
-    $query_handle->finish;
 
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
+    if ($enable_devlink eq "yes") {
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
     }
-    $query_handle->finish;
 
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
+    if ($enable_diskerror eq "yes") {
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
     }
-    $query_handle->finish;
 
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
+    if ($enable_mem_failure eq "yes") {
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
     }
-    $query_handle->finish;
 
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
+    if ($enable_mce eq "yes") {
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
     }
-    $query_handle->finish;
 
     undef($dbh);
 }
@@ -1294,167 +1316,181 @@ sub errors
     $query_handle->finish;
 
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
+    if ($enable_aer eq "yes") {
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
+            print "No PCIe AER errors.\n\n";
+        }
+        $query_handle->finish;
     }
-    $query_handle->finish;
 
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
+    if ($enable_arm eq "yes") {
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
     }
-    $query_handle->finish;
 
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
+    if ($enable_extlog eq "yes") {
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
     }
-    $query_handle->finish;
 
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
+    if ($enable_devlink eq "yes") {
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
     }
-    $query_handle->finish;
 
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
+    if ($enable_diskerror eq "yes") {
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
+            $out .= "\n";
+        }
+        if ($out ne "") {
+            print "Disk errors\n$out\n";
+        } else {
+            print "No disk errors.\n\n";
+        }
+        $query_handle->finish;
     }
-    $query_handle->finish;
 
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
+    if ($enable_mem_failure eq "yes") {
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
     }
-    $query_handle->finish;
 
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
+    if ($enable_mce eq "yes") {
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
     }
-    $query_handle->finish;
 
     undef($dbh);
 }
-- 
2.17.1

