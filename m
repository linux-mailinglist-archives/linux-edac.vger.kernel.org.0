Return-Path: <linux-edac+bounces-597-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC138561CA
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 12:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B252E1C20D74
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 11:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DDA12C812;
	Thu, 15 Feb 2024 11:33:51 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167E12C54B;
	Thu, 15 Feb 2024 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996831; cv=none; b=VnQrMHPKBwzzJ0AX4d+9RPs8SRVMASgywjiLrLi3ZDEtrKMfgj/+OC7W2WM5rH9SI7DLybbQtIEd6VOtoZDLbchL/kVKQfld4sERNQU5QctEezBdg9RULJTYE7gZxV6y49V6XODgIX2B+fdyZcS+wtw1TgOQ6G1EOPpNFVOf7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996831; c=relaxed/simple;
	bh=ki91YIiPp+hwGj2CcMBkns2E9AGAxSYmijbXopUzklQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oe07o82kF85nvNCykp2CYLjsPTaV6QtUz8BxOd4x5KYIM3z8VFDAd691eYCXXsWjsB+k/+YoSMfClMjNm1Lbo8MXRFkXEGOdZheM/b1fn78Du6amsYn50BAY8Q4EI8wv+AJdrp3QP7X/glwByBMxXBf3m2P3F86aQzMejFAI3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCX90jSGz6JB1p;
	Thu, 15 Feb 2024 19:29:45 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 50A77140DAF;
	Thu, 15 Feb 2024 19:33:47 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:33:46 +0000
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 6/8] rasdaemon: ras-mc-ctl: Add support for CXL general media trace events
Date: Thu, 15 Feb 2024 19:32:33 +0800
Message-ID: <20240215113235.1498-8-shiju.jose@huawei.com>
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

Add support for CXL general media events to the ras-mc-ctl tool.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 138 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 84cdf2c..27b6962 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1309,6 +1309,84 @@ sub get_cxl_hdr_flags_text
     return join (", ", @out);
 }
 
+use constant {
+    CXL_DPA_VOLATILE => 0x0001,
+    CXL_DPA_NOT_REPAIRABLE => 0x0002,
+};
+
+sub get_cxl_dpa_flags_text
+{
+    my $flags = $_[0];
+    my @out;
+
+    if ($flags & CXL_DPA_VOLATILE) {
+        push @out, (sprintf "\'VOLATILE\' ");
+    }
+    if ($flags & CXL_DPA_NOT_REPAIRABLE) {
+        push @out, (sprintf "\'NOT_REPAIRABLE\' ");
+    }
+
+    return join (", ", @out);
+}
+
+use constant {
+    CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT => 0x0001,
+    CXL_GMER_EVT_DESC_THRESHOLD_EVENT => 0x0002,
+    CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW => 0x0004,
+};
+
+sub get_cxl_descriptor_flags_text
+{
+    my $flags = $_[0];
+    my @out;
+
+    if ($flags & CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT) {
+        push @out, (sprintf "\'UNCORRECTABLE EVENT\' ");
+    }
+    if ($flags & CXL_GMER_EVT_DESC_THRESHOLD_EVENT) {
+        push @out, (sprintf "\'THRESHOLD EVENT\' ");
+    }
+    if ($flags & CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW) {
+        push @out, (sprintf "\'POISON LIST OVERFLOW\' ");
+    }
+
+    return join (", ", @out);
+}
+
+sub get_cxl_mem_event_type
+{
+    my @types;
+
+    if ($_[0] < 0 || $_[0] > 2) {
+        return "unknown-type";
+    }
+
+    @types = ("ECC Error",
+              "Invalid Address",
+              "Data Path Error");
+
+    return $types[$_[0]];
+}
+
+sub get_cxl_transaction_type
+{
+    my @types;
+
+    if ($_[0] < 0 || $_[0] > 6) {
+        return "unknown-type";
+    }
+
+    @types = ("Unknown",
+              "Host Read",
+              "Host Write",
+              "Host Scan Media",
+              "Host Inject Poison",
+              "Internal Media Scrub",
+              "Internal Media Management");
+
+    return $types[$_[0]];
+}
+
 sub summary
 {
     require DBI;
@@ -1453,6 +1531,22 @@ sub summary
             print "No CXL generic errors.\n\n";
         }
         $query_handle->finish;
+
+        # CXL general media errors
+        $query = "select memdev, count(*) from cxl_general_media_event$conf{opt}{since} group by memdev";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($memdev, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$memdev errors: $count\n";
+        }
+        if ($out ne "") {
+            print "CXL general media events summary:\n$out\n";
+        } else {
+            print "No CXL general media errors.\n\n";
+        }
+        $query_handle->finish;
     }
 
     # extlog errors
@@ -1564,6 +1658,7 @@ sub errors
     my ($log_type, $first_ts, $last_ts);
     my ($trace_type, $region, $region_uuid, $hpa, $dpa, $dpa_length, $source, $flags, $overflow_ts);
     my ($hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $data);
+    my ($dpa_flags, $descriptor, $mem_event_type, $transaction_type, $channel, $rank, $device, $comp_id);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1775,6 +1870,49 @@ sub errors
         } else {
             print "No CXL generic errors.\n\n";
         }
+
+        # CXL general media errors
+        use constant CXL_EVENT_GEN_MED_COMP_ID_SIZE => 0x10;
+        $query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, dpa, dpa_flags, descriptor, type, transaction_type, channel, rank, device, comp_id from cxl_general_media_event$conf{opt}{since} order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $dpa, $dpa_flags, $descriptor, $mem_event_type, $transaction_type, $channel, $rank, $device, $comp_id));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $timestamp error: ";
+            $out .= "memdev=$memdev, "  if (defined $memdev && length $memdev);
+            $out .= "host=$host, " if (defined $host && length $host);
+            $out .= sprintf "serial=0x%llx, ", $serial if (defined $serial && length $serial);
+            $out .= "log=$log_type, " if (defined $log_type && length $log_type);
+            $out .= "hdr_uuid=$hdr_uuid, " if (defined $hdr_uuid && length $hdr_uuid);
+            $out .= sprintf "hdr_flags=0x%llx %s, ", $hdr_flags, get_cxl_hdr_flags_text($hdr_flags) if (defined $hdr_flags && length $hdr_flags);
+            $out .= sprintf "hdr_handle=0x%x, ", $hdr_handle if (defined $hdr_handle && length $hdr_handle);
+            $out .= sprintf "hdr_related_handle=0x%x, ", $hdr_related_handle if (defined $hdr_related_handle && length $hdr_related_handle);
+            $out .= "hdr_timestamp=$hdr_ts, " if (defined $hdr_ts && length $hdr_ts);
+            $out .= sprintf "hdr_length=%u, ", $hdr_length if (defined $hdr_length && length $hdr_length);
+            $out .= sprintf "hdr_maint_op_class=%u, ", $hdr_maint_op_class if (defined $hdr_maint_op_class && length $hdr_maint_op_class);
+            $out .= sprintf "dpa=0x%llx, ", $dpa if (defined $dpa && length $dpa);
+            $out .= sprintf "dpa_flags: %s, ", get_cxl_dpa_flags_text($dpa_flags) if (defined $dpa_flags && length $dpa_flags);
+            $out .= sprintf "descriptor_flags: %s, ", get_cxl_descriptor_flags_text($descriptor) if (defined $descriptor && length $descriptor);
+            $out .= sprintf "memory event type: %s, ", get_cxl_mem_event_type($mem_event_type) if (defined $mem_event_type && length $mem_event_type);
+            $out .= sprintf "transaction_type: %s, ", get_cxl_transaction_type($transaction_type) if (defined $transaction_type && length $transaction_type);
+            $out .= sprintf "channel=%u, ", $channel if (defined $channel && length $channel);
+            $out .= sprintf "rank=%u, ", $rank if (defined $rank && length $rank);
+            $out .= sprintf "device=0x%x, ", $device if (defined $device && length $device);
+            if (defined $comp_id && length $comp_id) {
+                $out .= sprintf "component_id:";
+                my @bytes = unpack "C*", $comp_id;
+                for (my $i = 0; $i < CXL_EVENT_GEN_MED_COMP_ID_SIZE; $i++) {
+                    $out .= sprintf "%02x ", $bytes[$i];
+		}
+            }
+            $out .= "\n";
+        }
+        if ($out ne "") {
+            print "CXL general media events:\n$out\n";
+        } else {
+            print "No CXL general media errors.\n\n";
+        }
     }
 
     # Extlog errors
-- 
2.34.1


