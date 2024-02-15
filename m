Return-Path: <linux-edac+bounces-595-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487538561C8
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 12:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C0C1F28E02
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA1F12C807;
	Thu, 15 Feb 2024 11:33:50 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED312C55B;
	Thu, 15 Feb 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996830; cv=none; b=Lbgo40UAsnB10ALfH6ReKGQum6DjTz6RSJ6xp00YZI3U+ZuY9XeASO9lbW9BYpgRm4Ly43Uf5mbdyPALircd3CewgRXEVXWuIfbnAZkM1iFExC+PABIFbWNKI6lHjNXA1JU8GMlELmruGA5Xw1PP1sXWE6ONwhtPX6TjzPyZi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996830; c=relaxed/simple;
	bh=WBMuGaFByOBizSHSc9nVwDXvzMsp2kRr0IrhOv/Us1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdnHltZO0wEeAjuBS04U6gsx1m8sEDZma6nUwYEaxIx4HH1rPo6Pfb8XLfgBWtsZkDo+qlZFLrQ+h+C2i1FLhi6QYMuAQqIDlS4B06hagYcB+OVFKJMkI6Y2EULpyKB0UbFmSGMaEa4aqpa8SbDgJrsFHDgkg824jcUAdBfrZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCXq3f5Kz6K8wt;
	Thu, 15 Feb 2024 19:30:19 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AD891400D4;
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
Subject: [RFC PATCH 5/8] rasdaemon: ras-mc-ctl: Add support for CXL generic trace events
Date: Thu, 15 Feb 2024 19:32:32 +0800
Message-ID: <20240215113235.1498-7-shiju.jose@huawei.com>
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

Add support for CXL generic events to the ras-mc-ctl tool.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index d8c1dec..84cdf2c 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1281,6 +1281,34 @@ sub get_cxl_ce_error_status_text
     return join (", ", @out);
 }
 
+use constant {
+    CXL_EVENT_RECORD_FLAG_PERMANENT => 0x0004,
+    CXL_EVENT_RECORD_FLAG_MAINT_NEEDED => 0x0008,
+    CXL_EVENT_RECORD_FLAG_PERF_DEGRADED => 0x0010,
+    CXL_EVENT_RECORD_FLAG_HW_REPLACE => 0x0020,
+};
+
+sub get_cxl_hdr_flags_text
+{
+    my $flags = $_[0];
+    my @out;
+
+    if ($flags & CXL_EVENT_RECORD_FLAG_PERMANENT) {
+        push @out, (sprintf "\'PERMANENT_CONDITION\' ");
+    }
+    if ($flags & CXL_EVENT_RECORD_FLAG_MAINT_NEEDED) {
+        push @out, (sprintf "\'MAINTENANCE_NEEDED\' ");
+    }
+    if ($flags & CXL_EVENT_RECORD_FLAG_PERF_DEGRADED) {
+        push @out, (sprintf "\'PERFORMANCE_DEGRADED\' ");
+    }
+    if ($flags & CXL_EVENT_RECORD_FLAG_HW_REPLACE) {
+        push @out, (sprintf "\'HARDWARE_REPLACEMENT_NEEDED\' ");
+    }
+
+    return join (", ", @out);
+}
+
 sub summary
 {
     require DBI;
@@ -1409,6 +1437,22 @@ sub summary
             print "No CXL poison errors.\n\n";
         }
         $query_handle->finish;
+
+        # CXL generic errors
+        $query = "select memdev, count(*) from cxl_generic_event$conf{opt}{since} group by memdev";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($memdev, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$memdev errors: $count\n";
+        }
+        if ($out ne "") {
+            print "CXL  generic events summary:\n$out\n";
+        } else {
+            print "No CXL generic errors.\n\n";
+        }
+        $query_handle->finish;
     }
 
     # extlog errors
@@ -1519,6 +1563,7 @@ sub errors
     my ($memdev, $host, $serial, $error_status, $first_error, $header_log);
     my ($log_type, $first_ts, $last_ts);
     my ($trace_type, $region, $region_uuid, $hpa, $dpa, $dpa_length, $source, $flags, $overflow_ts);
+    my ($hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $data);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1692,6 +1737,44 @@ sub errors
         } else {
             print "No CXL poison errors.\n\n";
         }
+
+        # CXL generic errors
+        use constant CXL_EVENT_RECORD_DATA_LENGTH => 0x50;
+        $query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, data from cxl_generic_event$conf{opt}{since} order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $data));
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
+            if (defined $data && length $data) {
+                $out .= sprintf "data:\n";
+                my @bytes = unpack "C*", $data;
+                for (my $i = 0; $i < CXL_EVENT_RECORD_DATA_LENGTH; $i++) {
+                    if (($i > 0) && (($i % 16) == 0)) {
+                        $out .= sprintf "\n %08x: ", $i;
+                    }
+                    $out .= sprintf "%02x%02x%02x%02x ", $bytes[$i], $bytes[$i + 1], $bytes[$i + 2], $bytes[$i + 3];
+		}
+            }
+            $out .= "\n";
+        }
+        if ($out ne "") {
+            print "CXL generic events:\n$out\n";
+        } else {
+            print "No CXL generic errors.\n\n";
+        }
     }
 
     # Extlog errors
-- 
2.34.1


