Return-Path: <linux-edac+bounces-596-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911978561C9
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 12:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C84294FEF
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A3412C808;
	Thu, 15 Feb 2024 11:33:51 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ECE12C55E;
	Thu, 15 Feb 2024 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996830; cv=none; b=TwBf7lmCKWbtc0vUAsHakbugnDwFDIPUtIvFOwLb7+WUSBMLfVBzC/oQ3XxVFriCP35V+qBKn5x2yJI7IiPoYtV0kBaKgsdXpLkQI16VIWRy7Ajp6Nr+GlQKFCeoTZkdAf98PdJ3pTTQDJAg4YL+hki/IBYIT8jjKwZhgFCN3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996830; c=relaxed/simple;
	bh=y4LEABMzaH0A2Jq6jQWE1luBSFmpRr/RwC6u0D89WBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ruib/ZmNdSgetfws+aFphOnA3AqdRc+EBhhLa08YrOKzeBj9yKDz0TC2h7J5TPhryczmcdOdTygtYSk5QqhwhwK6ORiKL5zh+MlD24hxON0xG0xjmWDZ3UfCZa/1fa7DgRMugEIyA5ClgwuZKtRqCyAqQ5u2iEY2Rz2ReeCGcoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCXq4xTtz6K8wy;
	Thu, 15 Feb 2024 19:30:19 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id A5CC31400D4;
	Thu, 15 Feb 2024 19:33:47 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:33:47 +0000
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 7/8] rasdaemon: ras-mc-ctl: Add support for CXL DRAM trace events
Date: Thu, 15 Feb 2024 19:32:34 +0800
Message-ID: <20240215113235.1498-9-shiju.jose@huawei.com>
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

Add support for CXL DRAM events to the ras-mc-ctl tool.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 27b6962..cae0e86 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1547,6 +1547,22 @@ sub summary
             print "No CXL general media errors.\n\n";
         }
         $query_handle->finish;
+
+        # CXL DRAM errors
+        $query = "select memdev, count(*) from cxl_dram_event$conf{opt}{since} group by memdev";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($memdev, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$memdev errors: $count\n";
+        }
+        if ($out ne "") {
+            print "CXL DRAM events summary:\n$out\n";
+        } else {
+            print "No CXL DRAM errors.\n\n";
+        }
+        $query_handle->finish;
     }
 
     # extlog errors
@@ -1659,6 +1675,7 @@ sub errors
     my ($trace_type, $region, $region_uuid, $hpa, $dpa, $dpa_length, $source, $flags, $overflow_ts);
     my ($hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $data);
     my ($dpa_flags, $descriptor, $mem_event_type, $transaction_type, $channel, $rank, $device, $comp_id);
+    my ($nibble_mask, $bank_group, $row, $column, $cor_mask);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1913,6 +1930,53 @@ sub errors
         } else {
             print "No CXL general media errors.\n\n";
         }
+
+        # CXL DRAM errors
+        use constant CXL_EVENT_DER_CORRECTION_MASK_SIZE => 0x20;
+        $query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, dpa, dpa_flags, descriptor, type, transaction_type, channel, rank, nibble_mask, bank_group, bank, row, column, cor_mask from cxl_dram_event$conf{opt}{since} order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $dpa, $dpa_flags, $descriptor, $type, $transaction_type, $channel, $rank, $nibble_mask, $bank_group, $bank, $row, $column, $cor_mask));
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
+            $out .= sprintf "dpa=0x%llx, ", $dpa if (defined $dpa && length $dpa);
+            $out .= sprintf "dpa_flags: %s, ", get_cxl_dpa_flags_text($dpa_flags) if (defined $dpa_flags && length $dpa_flags);
+            $out .= sprintf "descriptor_flags: %s, ", get_cxl_descriptor_flags_text($descriptor) if (defined $descriptor && length $descriptor);
+            $out .= sprintf "memory event type: %s, ", get_cxl_mem_event_type($type) if (defined $type && length $type);
+            $out .= sprintf "transaction_type: %s, ", get_cxl_transaction_type($transaction_type) if (defined $transaction_type && length $transaction_type);
+            $out .= sprintf "channel=%u, ", $channel if (defined $channel && length $channel);
+            $out .= sprintf "rank=%u, ", $rank if (defined $rank && length $rank);
+            $out .= sprintf "nibble_mask=%u, ", $nibble_mask if (defined $nibble_mask && length $nibble_mask);
+            $out .= sprintf "bank_group=%u, ", $bank_group if (defined $bank_group && length $bank_group);
+            $out .= sprintf "bank=%u, ", $bank if (defined $bank && length $bank);
+            $out .= sprintf "row=%u, ", $row if (defined $row && length $row);
+            $out .= sprintf "column=%u, ", $column if (defined $column && length $column);
+            if (defined $cor_mask && length $cor_mask) {
+                $out .= sprintf "correction_mask:";
+                my @bytes = unpack "C*", $cor_mask;
+                for (my $i = 0; $i < CXL_EVENT_DER_CORRECTION_MASK_SIZE; $i++) {
+                    $out .= sprintf "%02x ", $bytes[$i];
+		}
+            }
+            $out .= "\n";
+        }
+        if ($out ne "") {
+            print "CXL DRAM events:\n$out\n";
+        } else {
+            print "No CXL DRAM errors.\n\n";
+        }
     }
 
     # Extlog errors
-- 
2.34.1


