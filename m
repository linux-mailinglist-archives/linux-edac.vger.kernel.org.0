Return-Path: <linux-edac+bounces-598-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F9E8561CB
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 12:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEFB295053
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300D12C809;
	Thu, 15 Feb 2024 11:33:52 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D312C542;
	Thu, 15 Feb 2024 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996832; cv=none; b=PqdLpBckZzdms+g8NG85vbXdF2EtHLb/F6Xa1kKtGqzJwxmQifZFvjlEUXlUYMyWiY/Z9YxrmugDa6B5TJ0uuX4r+0MWMAzvWbQbTAb05s1szB2loPW+ab9xmgpOFURxCJWVdJFRSwaU5Pgu4YOT/JXCcLI/z7Asm5tR4DhtLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996832; c=relaxed/simple;
	bh=+pwndm8IXBkS2fSegK9PDzjm7PW4Csd/mFuqiZ1bnFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDcYlTEG+H24iw1eVx3QMr9F8n8L1JcnFluSLSfci3LGHvOHTTDW7yNt1M8ASaeE6PSgbNMSUrM3phIgvV7RdXrATU33eVR64JZD/uLOeXmtTejgW7EZemMTu3jbRtoM18NP3wTQNlmP508ZA5OPGrgCuwlSmgpFn7GM7TVxc+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCXr3wySz6K8x5;
	Thu, 15 Feb 2024 19:30:20 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 243CE1400CD;
	Thu, 15 Feb 2024 19:33:48 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:33:47 +0000
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 8/8] rasdaemon: ras-mc-ctl: Add support for CXL memory module trace events
Date: Thu, 15 Feb 2024 19:32:35 +0800
Message-ID: <20240215113235.1498-10-shiju.jose@huawei.com>
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

Add support for CXL memory module events to the ras-mc-ctl tool.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 117 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index cae0e86..a7ece13 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1387,6 +1387,70 @@ sub get_cxl_transaction_type
     return $types[$_[0]];
 }
 
+sub get_cxl_dev_event_type
+{
+    my @types;
+
+    if ($_[0] < 0 || $_[0] > 5) {
+        return "unknown-type";
+    }
+
+    @types = ("Health Status Change",
+              "Media Status Change",
+              "Life Used Change",
+              "Temperature Change",
+              "Data Path Error",
+              "LSA Error");
+
+    return $types[$_[0]];
+}
+
+use constant {
+    CXL_DHI_HS_MAINTENANCE_NEEDED => 0x0001,
+    CXL_DHI_HS_PERFORMANCE_DEGRADED => 0x0002,
+    CXL_DHI_HS_HW_REPLACEMENT_NEEDED => 0x0004,
+};
+
+sub get_cxl_health_status_text
+{
+    my $flags = $_[0];
+    my @out;
+
+    if ($flags & CXL_DHI_HS_MAINTENANCE_NEEDED) {
+        push @out, (sprintf "\'MAINTENANCE_NEEDED\' ");
+    }
+    if ($flags & CXL_DHI_HS_PERFORMANCE_DEGRADED) {
+        push @out, (sprintf "\'PERFORMANCE_DEGRADED\' ");
+    }
+    if ($flags & CXL_DHI_HS_HW_REPLACEMENT_NEEDED) {
+        push @out, (sprintf "\'REPLACEMENT_NEEDED\' ");
+    }
+
+    return join (", ", @out);
+}
+
+sub get_cxl_media_status
+{
+    my @types;
+
+    if ($_[0] < 0 || $_[0] > 9) {
+        return "unknown";
+    }
+
+    @types = ("Normal",
+              "Not Ready",
+              "Write Persistency Lost",
+              "All Data Lost",
+              "Write Persistency Loss in the Event of Power Loss",
+              "Write Persistency Loss in Event of Shutdown",
+              "Write Persistency Loss Imminent",
+              "All Data Loss in Event of Power Loss",
+              "All Data loss in the Event of Shutdown",
+              "All Data Loss Imminent");
+
+    return $types[$_[0]];
+}
+
 sub summary
 {
     require DBI;
@@ -1563,6 +1627,22 @@ sub summary
             print "No CXL DRAM errors.\n\n";
         }
         $query_handle->finish;
+
+        # CXL memory module errors
+        $query = "select memdev, count(*) from cxl_memory_module_event$conf{opt}{since} group by memdev";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($memdev, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$memdev errors: $count\n";
+        }
+        if ($out ne "") {
+            print "CXL memory module events summary:\n$out\n";
+        } else {
+            print "No CXL memory module errors.\n\n";
+        }
+        $query_handle->finish;
     }
 
     # extlog errors
@@ -1676,6 +1756,7 @@ sub errors
     my ($hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $data);
     my ($dpa_flags, $descriptor, $mem_event_type, $transaction_type, $channel, $rank, $device, $comp_id);
     my ($nibble_mask, $bank_group, $row, $column, $cor_mask);
+    my ($event_type, $health_status, $media_status, $life_used, $dirty_shutdown_cnt, $cor_vol_err_cnt, $cor_per_err_cnt, $device_temp, $add_status);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1977,6 +2058,42 @@ sub errors
         } else {
             print "No CXL DRAM errors.\n\n";
         }
+
+        # CXL memory module errors
+        $query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, event_type, health_status, media_status, life_used, dirty_shutdown_cnt, cor_vol_err_cnt, cor_per_err_cnt, device_temp, add_status from cxl_memory_module_event$conf{opt}{since} order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $event_type, $health_status, $media_status, $life_used, $dirty_shutdown_cnt, $cor_vol_err_cnt, $cor_per_err_cnt, $device_temp, $add_status));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $timestamp error: ";
+            $out .= "memdev=$memdev, "  if (defined $memdev && length $memdev);
+            $out .= "host=$host, " if (defined $host && length $host);
+            $out .= sprintf "serial=0x%llx, ", $serial if (defined $serial && length $serial);
+            $out .= "log=$log_type, " if (defined $log_type && length $log_type);
+            $out .= "hdr_uuid=$hdr_uuid, " if (defined $hdr_uuid && length $hdr_uuid);
+            $out .= sprintf "hdr_flags=0x%llx, %s, ", $hdr_flags, get_cxl_hdr_flags_text($hdr_flags) if (defined $hdr_flags && length $hdr_flags);
+            $out .= sprintf "hdr_handle=0x%x, ", $hdr_handle if (defined $hdr_handle && length $hdr_handle);
+            $out .= sprintf "hdr_related_handle=0x%x, ", $hdr_related_handle if (defined $hdr_related_handle && length $hdr_related_handle);
+            $out .= "hdr_timestamp=$hdr_ts, " if (defined $hdr_ts && length $hdr_ts);
+            $out .= sprintf "hdr_length=%u, ", $hdr_length if (defined $hdr_length && length $hdr_length);
+            $out .= sprintf "hdr_maint_op_class=%u, ", $hdr_maint_op_class if (defined $hdr_maint_op_class && length $hdr_maint_op_class);
+            $out .= sprintf "event_type: %s, ", get_cxl_dev_event_type($event_type)  if (defined $event_type && length $event_type);
+            $out .= sprintf "health_status: %s, ", get_cxl_health_status_text($health_status)  if (defined $health_status && length $health_status);
+            $out .= sprintf "media_status: %s, ", get_cxl_media_status($media_status)  if (defined $media_status && length $media_status);
+            $out .= sprintf "life_used=%u, ", $life_used  if (defined $life_used && length $life_used);
+            $out .= sprintf "dirty_shutdown_cnt=%u, ", $dirty_shutdown_cnt  if (defined $dirty_shutdown_cnt && length $dirty_shutdown_cnt);
+            $out .= sprintf "cor_vol_err_cnt=%u, ", $cor_vol_err_cnt  if (defined $cor_vol_err_cnt && length $cor_vol_err_cnt);
+            $out .= sprintf "cor_per_err_cnt=%u, ", $cor_per_err_cnt  if (defined $cor_per_err_cnt && length $cor_per_err_cnt);
+            $out .= sprintf "device_temp=%u, ", $device_temp  if (defined $device_temp && length $device_temp);
+            $out .= sprintf "add_status=%u ", $add_status  if (defined $add_status && length $add_status);
+            $out .= "\n";
+        }
+        if ($out ne "") {
+            print "CXL memory module events:\n$out\n";
+        } else {
+            print "No CXL memory module errors.\n\n";
+        }
     }
 
     # Extlog errors
-- 
2.34.1


