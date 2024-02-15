Return-Path: <linux-edac+bounces-590-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA8D8561C4
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 12:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF55F1C23136
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 11:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C7112C7E9;
	Thu, 15 Feb 2024 11:33:49 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E80A12AACF;
	Thu, 15 Feb 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996829; cv=none; b=Q3vuM64uhxQqSy/tnMifoW/oiNlj5uRewLut8lpJ0vrFxk7hUis6PuFRJUNo6RhR965loyQvVA/sK9aAe9HSydI7xciDsJeJ5sf1eTr0rU8AEKfCNWov3BuGObY3EeyOXVg4lQOeiH0h2uSsH9BtRdwqISCgjwBoJ0oBdSqgPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996829; c=relaxed/simple;
	bh=kD1F6aYq2F1dlCdMhj3gXZXhptA4In+JFu/kQwtPS/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j97RZ+uvheJMFq0bENjErONg7mUQ3vcWk91jxQdJWvvFj0ndIG50awg5Xn+CLqB43IOyTiav0TQlEtFqP1Tq4EieLRQZa5qxY8A/SktA9J16pE4vOmiX/y6CpNFI5VqcV8nDNAwSYiU4nkodWMgTfVTQVzUHsJZlfZcFGleY64g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCX71TTWz6J9xX;
	Thu, 15 Feb 2024 19:29:43 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 68E68141DD2;
	Thu, 15 Feb 2024 19:33:45 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:33:44 +0000
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 1/8] rasdaemon: ras-mc-ctl: Add support for CXL AER uncorrectable trace events
Date: Thu, 15 Feb 2024 19:32:27 +0800
Message-ID: <20240215113235.1498-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240215113235.1498-1-shiju.jose@huawei.com>
References: <20240215113235.1498-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for CXL AER uncorrectable events to the ras-mc-ctl tool.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 134 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 227a77d..630edde 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -43,6 +43,7 @@ my $modprobe    = find_prog ("modprobe")  or exit (1);
 
 my $has_aer = 0;
 my $has_arm = 0;
+my $has_cxl = 0;
 my $has_devlink = 0;
 my $has_disk_errors = 0;
 my $has_extlog = 0;
@@ -51,6 +52,7 @@ my $has_mce = 0;
 
 @WITH_AER_TRUE@$has_aer = 1;
 @WITH_ARM_TRUE@$has_arm = 1;
+@WITH_CXL_TRUE@$has_cxl = 1;
 @WITH_DEVLINK_TRUE@$has_devlink = 1;
 @WITH_DISKERROR_TRUE@$has_disk_errors = 1;
 @WITH_EXTLOG_TRUE@$has_extlog = 1;
@@ -1167,6 +1169,78 @@ sub get_uuid_le
     return $out;
 }
 
+use constant {
+    CXL_AER_UE_CACHE_DATA_PARITY => 0x0001,
+    CXL_AER_UE_CACHE_ADDR_PARITY => 0x0002,
+    CXL_AER_UE_CACHE_BE_PARITY => 0x0004,
+    CXL_AER_UE_CACHE_DATA_ECC => 0x0008,
+    CXL_AER_UE_MEM_DATA_PARITY => 0x0010,
+    CXL_AER_UE_MEM_ADDR_PARITY => 0x0020,
+    CXL_AER_UE_MEM_BE_PARITY => 0x0040,
+    CXL_AER_UE_MEM_DATA_ECC => 0x0080,
+    CXL_AER_UE_REINIT_THRESH => 0x0100,
+    CXL_AER_UE_RSVD_ENCODE => 0x0200,
+    CXL_AER_UE_POISON => 0x0400,
+    CXL_AER_UE_RECV_OVERFLOW => 0x0800,
+    CXL_AER_UE_INTERNAL_ERR => 0x4000,
+    CXL_AER_UE_IDE_TX_ERR => 0x8000,
+    CXL_AER_UE_IDE_RX_ERR => 0x10000,
+};
+
+sub get_cxl_ue_error_status_text
+{
+    my $error_status = $_[0];
+    my @out;
+
+    if ($error_status & CXL_AER_UE_CACHE_DATA_PARITY) {
+        push @out, (sprintf "\'Cache Data Parity Error\' ");
+    }
+    if ($error_status & CXL_AER_UE_CACHE_ADDR_PARITY) {
+        push @out, (sprintf "\'Cache Address Parity Error\' ");
+    }
+    if ($error_status & CXL_AER_UE_CACHE_BE_PARITY) {
+        push @out, (sprintf "\'Cache Byte Enable Parity Error\' ");
+    }
+    if ($error_status & CXL_AER_UE_CACHE_DATA_ECC) {
+        push @out, (sprintf "\'Cache Data ECC Error\' ");
+    }
+    if ($error_status & CXL_AER_UE_MEM_DATA_PARITY) {
+        push @out, (sprintf "\'Memory Data Parity Error\' ");
+    }
+    if ($error_status & CXL_AER_UE_MEM_ADDR_PARITY) {
+        push @out, (sprintf "\'Memory Address Parity Error\' ");
+    }
+    if ($error_status & CXL_AER_UE_MEM_BE_PARITY) {
+        push @out, (sprintf "\'Memory Byte Enable Parity Error\' ");
+    }
+    if ($error_status & CXL_AER_UE_MEM_DATA_ECC) {
+        push @out, (sprintf "\'Memory Data ECC Error\' ");
+    }
+    if ($error_status & CXL_AER_UE_REINIT_THRESH) {
+        push @out, (sprintf "\'REINIT Threshold Hit\' ");
+    }
+    if ($error_status & CXL_AER_UE_RSVD_ENCODE) {
+        push @out, (sprintf "\'Received Unrecognized Encoding\' ");
+    }
+    if ($error_status & CXL_AER_UE_POISON) {
+        push @out, (sprintf "\'Received Poison From Peer\' ");
+    }
+    if ($error_status & CXL_AER_UE_RECV_OVERFLOW) {
+        push @out, (sprintf "\'Receiver Overflow\' ");
+    }
+    if ($error_status & CXL_AER_UE_INTERNAL_ERR) {
+        push @out, (sprintf "\'Component Specific Error\' ");
+    }
+    if ($error_status & CXL_AER_UE_IDE_TX_ERR) {
+        push @out, (sprintf "\'IDE Tx Error\' ");
+    }
+    if ($error_status & CXL_AER_UE_IDE_RX_ERR) {
+        push @out, (sprintf "\'IDE Rx Error\' ");
+    }
+
+    return join (", ", @out);
+}
+
 sub summary
 {
     require DBI;
@@ -1174,7 +1248,7 @@ sub summary
     my ($err_type, $label, $mc, $top, $mid, $low, $count, $msg, $action_result);
     my ($etype, $severity, $etype_string, $severity_string);
     my ($dev_name, $dev);
-    my ($mpidr);
+    my ($mpidr, $memdev);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1230,6 +1304,25 @@ sub summary
         $query_handle->finish;
     }
 
+    # CXL errors
+    if ($has_cxl == 1) {
+        # CXL AER uncorrectable errors
+        $query = "select memdev, count(*) from cxl_aer_ue_event$conf{opt}{since} group by memdev";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($memdev, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$memdev errors: $count\n";
+        }
+        if ($out ne "") {
+            print "CXL AER uncorrectable events summary:\n$out\n";
+        } else {
+            print "No CXL AER uncorrectable errors.\n\n";
+        }
+        $query_handle->finish;
+    }
+
     # extlog errors
     if ($has_extlog == 1) {
         $query = "select etype, severity, count(*) from extlog_event$conf{opt}{since} group by etype, severity";
@@ -1335,6 +1428,7 @@ sub errors
     my ($dev, $sector, $nr_sector, $error, $rwbs, $cmd);
     my ($error_count, $affinity, $mpidr, $r_state, $psci_state);
     my ($pfn, $page_type, $action_result);
+    my ($memdev, $host, $serial, $error_status, $first_error, $header_log);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1400,6 +1494,44 @@ sub errors
         $query_handle->finish;
     }
 
+    # CXL errors
+    if ($has_cxl == 1) {
+        # CXL AER uncorrectable errors
+        use constant SZ_512 => 0x200;
+        use constant CXL_HEADERLOG_SIZE_U32 => SZ_512/32;
+        $query = "select id, timestamp, memdev, host, serial, error_status, first_error, header_log from cxl_aer_ue_event$conf{opt}{since} order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $error_status, $first_error, $header_log));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $timestamp error: ";
+            $out .= "memdev=$memdev, "  if (defined $memdev && length $memdev);
+            $out .= "host=$host, " if (defined $host && length $host);
+            $out .= sprintf "serial=0x%llx, ", $serial if (defined $serial && length $serial);
+            if (defined $error_status && length $error_status) {
+                $out .= sprintf "error_status: %s, ", get_cxl_ue_error_status_text($error_status);
+            }
+            if (defined $first_error && length $first_error) {
+                $out .= sprintf "first_error: %s, ", get_cxl_ue_error_status_text($first_error);
+            }
+            if (defined $header_log && length $header_log) {
+	        $out .= sprintf "header_log:\n";
+	        my @bytes = unpack "C*", $header_log;
+	        for (my $i = 0; $i < CXL_HEADERLOG_SIZE_U32; $i++) {
+	            $out .= sprintf "%08x ", $bytes[$i];
+                }
+            }
+            $out .= "\n";
+        }
+        if ($out ne "") {
+            print "CXL AER uncorrectable events:\n$out\n";
+        } else {
+            print "No CXL AER uncorrectable errors.\n\n";
+        }
+        $query_handle->finish;
+    }
+
     # Extlog errors
     if ($has_extlog == 1) {
         $query = "select id, timestamp, etype, severity, address, fru_id, fru_text, cper_data from extlog_event$conf{opt}{since} order by id";
-- 
2.34.1


