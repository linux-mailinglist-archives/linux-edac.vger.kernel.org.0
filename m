Return-Path: <linux-edac+bounces-2576-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E99D37FE
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 11:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F99B2DF8A
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 10:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0E1AA790;
	Wed, 20 Nov 2024 10:00:37 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2F51A9B54;
	Wed, 20 Nov 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096837; cv=none; b=QZcNxIKBnIqFeCKG2Q897+D6/OdpVq2jv//QNW/8BBWPQz5K032eChR9NgSHrqwGTSxzZd0PM6jHmNBs7qH5CmO9jQcK54sH6MQ88DHoBxhdEo1w12/6OItzdzjSdEuqWR7qWtL8X9Exz2B4hT6h2NtOFKq8QXj415fUfna6PJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096837; c=relaxed/simple;
	bh=8tow5TpsCCDUPIdZt8gavZ1OoctIto5lKBkIKyiDrOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekZa4y/SPBI5sN/6qMlE4zzGlLJkSE45dDN3+w0+aL2Qkkb8W6ruGroNgPxA0vDEjC/Jx0qYWeQLUZuQY0qh7GMbv0c8sfGVbwoeq8rb8/X5NCK/qYd35/EWi4OnsDpnlBlGwYhHcMcXDDeyptWK5e47An0aNAfDBu3qwfHPelc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtcHr73f1z6K98N;
	Wed, 20 Nov 2024 17:58:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 88BA0140119;
	Wed, 20 Nov 2024 18:00:33 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:00:32 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 12/13] rasdaemon: ras-mc-ctl: Update logging of CXL DRAM event data to align with CXL spec rev 3.1
Date: Wed, 20 Nov 2024 09:59:22 +0000
Message-ID: <20241120095923.1891-13-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241120095923.1891-1-shiju.jose@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.2.1.2 Table 8-46, DRAM Event Record has updated
with following new fields and new types for Memory Event Type, Transaction
Type and Validity Flags fields.
1. Component Identifier
2. Sub-channel
3. Advanced Programmable Corrected Memory Error Threshold Event Flags
4. Corrected Volatile Memory Error Count at Event
5. Memory Event Sub-Type

This update modifies ras-mc-ctl to parse and log CXL DRAM event data
stored in the RAS SQLite database table, reflecting the specification
changes introduced in revision 3.1.

Example output,

./util/ras-mc-ctl --errors
...
CXL DRAM events:
1 2024-11-20 00:18:53 +0000 error: memdev=mem0, host=0000:0f:00.0, serial=0x3, \
log=Informational, hdr_uuid=00000000-0000-0000-0000-000000000000, \
hdr_flags=0x1, , hdr_handle=0x1, hdr_related_handle=0x0, \
hdr_timestamp=1970-01-01 00:00:58 +0000, hdr_length=128, hdr_maint_op_class=1, \
hdr_maint_op_sub_class=3, dpa=0x18680, dpa_flags: , \
descriptor_flags: 'UNCORRECTABLE EVENT' , 'THRESHOLD EVENT' , \
memory event type: Data Path Error, memory event sub type: Media Link CRC Error, \
transaction_type: Internal Media Scrub, channel=3, sub_channel=0, rank=17, \
nibble_mask=3866802, bank_group=7, bank=11, row=2, column=77, \
correction_mask:21 00 00 00 00 00 00 00 2c 00 00 00 00 00 00 00 37 00 00 \
00 00 00 00 00 42 00 00 00 00 00 00 00 hpa=0xffffffffffffffff, \
region_uuid=00000000-0000-0000-0000-000000000000, \
component_id:01 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
pldm_entity_id:74 c5 08 9a 1a 0b pldm_resource_id:00 00 00 00 \
cme_threshold_ev_flags: 'Corrected Memory Errors in Multiple Media Components' , \
'Exceeded Programmable Threshold' , cvme_count=0x94, 
...

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index f8efa91..dbb1607 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1402,14 +1402,17 @@ sub get_cxl_der_mem_event_type
 {
     my @types;
 
-    if ($_[0] < 0 || $_[0] > 3) {
+    if ($_[0] < 0 || $_[0] > 6) {
 	return "unknown-type";
     }
 
     @types = ("Media ECC Error",
 	      "Scrub Media ECC Error",
 	      "Invalid Address",
-	      "Data Path Error");
+	      "Data Path Error",
+	      "TE State Violation",
+	      "Advanced Programmable CME Counter Expiration",
+	      "CKID Violation");
 
     return $types[$_[0]];
 }
@@ -1819,7 +1822,7 @@ sub errors
     my ($dpa_flags, $descriptor, $mem_event_type, $mem_event_sub_type, $transaction_type, $channel, $rank, $device, $comp_id, $pldm_entity_id, $pldm_res_id);
     my ($nibble_mask, $bank_group, $row, $column, $cor_mask);
     my ($event_type, $health_status, $media_status, $life_used, $dirty_shutdown_cnt, $cor_vol_err_cnt, $cor_per_err_cnt, $device_temp, $add_status);
-    my ($cme_threshold_ev_flags, $cme_count);
+    my ($sub_channel, $cme_threshold_ev_flags, $cme_count, $cvme_count);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -2089,10 +2092,10 @@ sub errors
 
 	# CXL DRAM errors
 	use constant CXL_EVENT_DER_CORRECTION_MASK_SIZE => 0x20;
-	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, dpa, dpa_flags, descriptor, type, transaction_type, channel, rank, nibble_mask, bank_group, bank, row, column, cor_mask, hpa, region, region_uuid, hdr_maint_op_sub_class from cxl_dram_event$conf{opt}{since} order by id";
+	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, dpa, dpa_flags, descriptor, type, transaction_type, channel, rank, nibble_mask, bank_group, bank, row, column, cor_mask, hpa, region, region_uuid, hdr_maint_op_sub_class, comp_id, pldm_entity_id, pldm_resource_id, sub_type, sub_channel, cme_threshold_ev_flags, cvme_count from cxl_dram_event$conf{opt}{since} order by id";
 	$query_handle = $dbh->prepare($query);
 	$query_handle->execute();
-	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $dpa, $dpa_flags, $descriptor, $type, $transaction_type, $channel, $rank, $nibble_mask, $bank_group, $bank, $row, $column, $cor_mask, $hpa, $region, $region_uuid, $hdr_maint_op_sub_class));
+	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $dpa, $dpa_flags, $descriptor, $type, $transaction_type, $channel, $rank, $nibble_mask, $bank_group, $bank, $row, $column, $cor_mask, $hpa, $region, $region_uuid, $hdr_maint_op_sub_class, $comp_id, $pldm_entity_id, $pldm_res_id, $mem_event_sub_type, $sub_channel, $cme_threshold_ev_flags, $cvme_count));
 	$out = "";
 	while($query_handle->fetch()) {
 	    $out .= "$id $timestamp error: ";
@@ -2112,8 +2115,10 @@ sub errors
 	    $out .= sprintf "dpa_flags: %s, ", get_cxl_dpa_flags_text($dpa_flags) if (defined $dpa_flags && length $dpa_flags);
 	    $out .= sprintf "descriptor_flags: %s, ", get_cxl_descriptor_flags_text($descriptor) if (defined $descriptor && length $descriptor);
 	    $out .= sprintf "memory event type: %s, ", get_cxl_der_mem_event_type($type) if (defined $type && length $type);
+	    $out .= sprintf "memory event sub type: %s, ", get_cxl_mem_event_sub_type($mem_event_sub_type) if (defined $mem_event_sub_type && length $mem_event_sub_type);
 	    $out .= sprintf "transaction_type: %s, ", get_cxl_transaction_type($transaction_type) if (defined $transaction_type && length $transaction_type);
 	    $out .= sprintf "channel=%u, ", $channel if (defined $channel && length $channel);
+	    $out .= sprintf "sub_channel=%u, ", $sub_channel if (defined $sub_channel && length $sub_channel);
 	    $out .= sprintf "rank=%u, ", $rank if (defined $rank && length $rank);
 	    $out .= sprintf "nibble_mask=%u, ", $nibble_mask if (defined $nibble_mask && length $nibble_mask);
 	    $out .= sprintf "bank_group=%u, ", $bank_group if (defined $bank_group && length $bank_group);
@@ -2130,6 +2135,17 @@ sub errors
             $out .= sprintf "hpa=0x%llx, ", $hpa if (defined $hpa && length $hpa);
             $out .= "region=$region, " if (defined $region && length $region);
             $out .= "region_uuid=$region_uuid, " if (defined $region_uuid && length $region_uuid);
+            if (defined $comp_id && length $comp_id) {
+                print_cxl_dev_id("component_id", $comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE, $out);
+            }
+            if (defined $pldm_entity_id && length $pldm_entity_id) {
+                print_cxl_dev_id("pldm_entity_id", $pldm_entity_id, CXL_EVENT_GEN_PLDM_ENTITY_ID_SIZE, $out);
+            }
+            if (defined $pldm_res_id && length $pldm_res_id) {
+                print_cxl_dev_id("pldm_resource_id", $pldm_res_id, CXL_EVENT_GEN_PLDM_RES_ID_SIZE, $out);
+            }
+            $out .= sprintf "cme_threshold_ev_flags: %s, ", get_cxl_cme_threshold_ev_flags_text($cme_threshold_ev_flags) if (defined $cme_threshold_ev_flags && length $cme_threshold_ev_flags);
+            $out .= sprintf "cvme_count=0x%x, ", $cvme_count if (defined $cvme_count && length $cvme_count);
 	    $out .= "\n";
 	}
 	if ($out ne "") {
-- 
2.43.0


