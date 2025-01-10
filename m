Return-Path: <linux-edac+bounces-2873-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96144A0905E
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 13:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91E27A5B37
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B132101B6;
	Fri, 10 Jan 2025 12:27:14 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4B210186;
	Fri, 10 Jan 2025 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512034; cv=none; b=OQphfNpmN095LOL1ANMki2UkVHuGzK2WYsRGY9gck/dA2wv380lnv4dLOmZybebM2CihpGm1/uG2mns2erx0NcuhoegTZPctnFypMoxTEXMLoJdtnH8Hc/dwyU25bm6MYj8kBkws0vgFBVby7kzyQv6oJzPMA3l3khcdVAbaz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512034; c=relaxed/simple;
	bh=sHNaKOdik4xKYTMfAKnmrTmtkhxcvI/t38KZDDnQZpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPM6pn0fSxNvpJM0ve6xtq1lzr7Z28CqTv5R+fI/AlDnA/cV3ndlLHQZiZ3dy16ZSkjmhBKm2lKPlrN4F0kBmznPFD4KOB/LqmZrXF6xUAPhcpJfMLmu5vIRKe0RZqOvBIdjyf5yS+DukGzCou8F5Dn1HcC/yduv+/jeZdG36kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV14k1d7hz6K5ft;
	Fri, 10 Jan 2025 20:22:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CCF614022E;
	Fri, 10 Jan 2025 20:27:11 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.14) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 13:27:10 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 13/14] rasdaemon: ras-mc-ctl: Update logging of CXL DRAM event data to align with CXL spec rev 3.1
Date: Fri, 10 Jan 2025 12:26:39 +0000
Message-ID: <20250110122641.1668-14-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250110122641.1668-1-shiju.jose@huawei.com>
References: <20250110122641.1668-1-shiju.jose@huawei.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index fe21f81..86ea48e 100755
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
-    my ($sub_type, $cme_threshold_ev_flags, $cme_count);
+    my ($sub_type, $sub_channel, $cme_threshold_ev_flags, $cme_count, $cvme_count);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -2089,10 +2092,10 @@ sub errors
 
 	# CXL DRAM errors
 	use constant CXL_EVENT_DER_CORRECTION_MASK_SIZE => 0x20;
-	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, hdr_maint_op_sub_class, dpa, dpa_flags, descriptor, type, transaction_type, channel, rank, nibble_mask, bank_group, bank, row, column, cor_mask, hpa, region, region_uuid from cxl_dram_event$conf{opt}{since} order by id";
+	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, hdr_maint_op_sub_class, dpa, dpa_flags, descriptor, type, transaction_type, channel, rank, nibble_mask, bank_group, bank, row, column, cor_mask, hpa, region, region_uuid, comp_id, pldm_entity_id, pldm_resource_id, sub_type, sub_channel, cme_threshold_ev_flags, cvme_count from cxl_dram_event$conf{opt}{since} order by id";
 	$query_handle = $dbh->prepare($query);
 	$query_handle->execute();
-	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $hdr_maint_op_sub_class, $dpa, $dpa_flags, $descriptor, $type, $transaction_type, $channel, $rank, $nibble_mask, $bank_group, $bank, $row, $column, $cor_mask, $hpa, $region, $region_uuid));
+	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $hdr_maint_op_sub_class, $dpa, $dpa_flags, $descriptor, $type, $transaction_type, $channel, $rank, $nibble_mask, $bank_group, $bank, $row, $column, $cor_mask, $hpa, $region, $region_uuid, $comp_id, $pldm_entity_id, $pldm_res_id, $mem_event_sub_type, $sub_channel, $cme_threshold_ev_flags, $cvme_count));
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
+            $out .= sprintf "cvme_count=%u, ", $cvme_count if (defined $cvme_count && length $cvme_count);
 	    $out .= "\n";
 	}
 	if ($out ne "") {
-- 
2.43.0


