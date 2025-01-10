Return-Path: <linux-edac+bounces-2872-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D0FA09059
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D7916AF86
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD92101A4;
	Fri, 10 Jan 2025 12:27:13 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C820FA9A;
	Fri, 10 Jan 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512033; cv=none; b=VQIJ9YD3wEbGkhgF9GdjKHDI+iIf0soSEpF8s2cWI+RhA136XtpCS0vd3CMB5ppvBnzz6JIPSkMJ6wAb/QFndaybAnG0p8DScQ9Ki3px8huuWxcH/GmC2/KLF5MZht8/4sysVuD3Qu1mMgpX7b8hMF40uPB3ldCXBVB2z7P2ZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512033; c=relaxed/simple;
	bh=4gs+4O4P3KLv4NeRQACtbNUbMMmAka6KKme22k5QHzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWq/936HQ5QOYxYOnV/Y9RVt1cBZXOGNI1lxGcggLTPu436/VUEdg/msCu1rLi6D3u+JU/1NF1GmMsAOyW8WmxXwdDI+37vBilM/fuJm20BvHqo4n4IAWzslFfu/GORYyV/h+XhCgKAdk6P0azYOl7audDeaUGUesSClrjOIygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV18g5wdcz6L51y;
	Fri, 10 Jan 2025 20:25:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 19F021403D2;
	Fri, 10 Jan 2025 20:27:10 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.14) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 13:27:09 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 12/14] rasdaemon: ras-mc-ctl: Update logging of CXL general media event data to align with CXL spec rev 3.1
Date: Fri, 10 Jan 2025 12:26:38 +0000
Message-ID: <20250110122641.1668-13-shiju.jose@huawei.com>
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

CXL spec rev 3.1 section 8.2.9.2.1.1 Table 8-45, General Media Event
Record has updated with following new fields and new types for Memory
Event Type and Transaction Type fields.
1. Advanced Programmable Corrected Memory Error Threshold Event Flags
2. Corrected Memory Error Count at Event
3. Memory Event Sub-Type

The format of component identifier has changed (CXL spec 3.1 section
8.2.9.2.1 Table 8-44).

This update modifies ras-mc-ctl to parse and log CXL general media event
data stored in the RAS SQLite database table, reflecting the specification
changes introduced in revision 3.1.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 92 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 12 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 58ee916..fe21f81 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1339,21 +1339,65 @@ sub get_cxl_descriptor_flags_text
     return join (", ", @out);
 }
 
+#CXL rev 3.1 Section 8.2.9.2.1.1; Table 8-45
+#General Media Event Record - GMER
 sub get_cxl_gmer_mem_event_type
 {
     my @types;
 
-    if ($_[0] < 0 || $_[0] > 2) {
+    if ($_[0] < 0 || $_[0] > 6) {
 	return "unknown-type";
     }
 
     @types = ("ECC Error",
 	      "Invalid Address",
-	      "Data Path Error");
+	      "Data Path Error",
+	      "TE State Violation",
+	      "Scrub Media ECC Error",
+	      "Advanced Programmable CME Counter Expiration",
+	      "CKID Violation");
 
     return $types[$_[0]];
 }
 
+# CXL rev 3.1 Section 8.2.9.2.1.1; Table 8-45
+sub get_cxl_mem_event_sub_type
+{
+    my @types;
+
+    if ($_[0] < 0 || $_[0] > 5) {
+	return "unknown-type";
+    }
+
+    @types = ("Not Reported",
+	      "Internal Datapath Error",
+	      "Media Link Command Training Error",
+	      "Media Link Control Training Error",
+	      "Media Link Data Training Error",
+	      "Media Link CRC Error");
+
+    return $types[$_[0]];
+}
+
+use constant {
+    CXL_EVT_FLAG_CME_MULTIPLE_MEDIA => 0x0001,
+    CXL_EVT_FLAG_THRESHOLD_EXCEEDED => 0x0002,
+};
+sub get_cxl_cme_threshold_ev_flags_text
+{
+    my $flags = $_[0];
+    my @out;
+
+    if ($flags & CXL_EVT_FLAG_CME_MULTIPLE_MEDIA) {
+	push @out, (sprintf "\'Corrected Memory Errors in Multiple Media Components\' ");
+    }
+    if ($flags & CXL_EVT_FLAG_THRESHOLD_EXCEEDED) {
+	push @out, (sprintf "\'Exceeded Programmable Threshold\' ");
+    }
+
+    return join (", ", @out);
+}
+
 sub get_cxl_der_mem_event_type
 {
     my @types;
@@ -1370,11 +1414,12 @@ sub get_cxl_der_mem_event_type
     return $types[$_[0]];
 }
 
+# CXL rev 3.1 Section 8.2.9.2.1.1; Table 8-45
 sub get_cxl_transaction_type
 {
     my @types;
 
-    if ($_[0] < 0 || $_[0] > 6) {
+    if ($_[0] < 0 || $_[0] > 8) {
 	return "unknown-type";
     }
 
@@ -1384,7 +1429,9 @@ sub get_cxl_transaction_type
 	      "Host Scan Media",
 	      "Host Inject Poison",
 	      "Internal Media Scrub",
-	      "Internal Media Management");
+	      "Internal Media Management",
+	      "Internal Media Error Check Scrub",
+	      "Media Initialization");
 
     return $types[$_[0]];
 }
@@ -1453,6 +1500,19 @@ sub get_cxl_media_status
     return $types[$_[0]];
 }
 
+# arg0 - name of the id
+# arg1 - id
+# arg2 - size(bytes) of id
+# arg3 - out log buffer
+sub print_cxl_dev_id
+{
+    $_[3] .= sprintf "%s:", $_[0];
+    my @bytes = unpack "C*", $_[1];
+    for (my $i = 0; $i < $_[2]; $i++) {
+        $_[3] .= sprintf "%02x ", $bytes[$i];
+    }
+}
+
 sub summary
 {
     require DBI;
@@ -1756,9 +1816,10 @@ sub errors
     my ($log_type, $first_ts, $last_ts);
     my ($trace_type, $region, $region_uuid, $hpa, $dpa, $dpa_length, $source, $flags, $overflow_ts);
     my ($hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $hdr_maint_op_sub_class, $data);
-    my ($dpa_flags, $descriptor, $mem_event_type, $transaction_type, $channel, $rank, $device, $comp_id);
+    my ($dpa_flags, $descriptor, $mem_event_type, $mem_event_sub_type, $transaction_type, $channel, $rank, $device, $comp_id, $pldm_entity_id, $pldm_res_id);
     my ($nibble_mask, $bank_group, $row, $column, $cor_mask);
     my ($event_type, $health_status, $media_status, $life_used, $dirty_shutdown_cnt, $cor_vol_err_cnt, $cor_per_err_cnt, $device_temp, $add_status);
+    my ($sub_type, $cme_threshold_ev_flags, $cme_count);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1974,10 +2035,12 @@ sub errors
 
 	# CXL general media errors
 	use constant CXL_EVENT_GEN_MED_COMP_ID_SIZE => 0x10;
-	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, hdr_maint_op_sub_class, dpa, dpa_flags, descriptor, type, transaction_type, channel, rank, device, comp_id, hpa, region, region_uuid from cxl_general_media_event$conf{opt}{since} order by id";
+	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, hdr_maint_op_sub_class, dpa, dpa_flags, descriptor, type, transaction_type, channel, rank, device, comp_id, hpa, region, region_uuid, pldm_entity_id, pldm_resource_id, sub_type, cme_threshold_ev_flags, cme_count from cxl_general_media_event$conf{opt}{since} order by id";
 	$query_handle = $dbh->prepare($query);
 	$query_handle->execute();
-	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $hdr_maint_op_sub_class, $dpa, $dpa_flags, $descriptor, $mem_event_type, $transaction_type, $channel, $rank, $device, $comp_id, $hpa, $region, $region_uuid));
+	use constant CXL_EVENT_GEN_PLDM_ENTITY_ID_SIZE => 0x6;
+	use constant CXL_EVENT_GEN_PLDM_RES_ID_SIZE => 0x4;
+	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $hdr_maint_op_sub_class, $dpa, $dpa_flags, $descriptor, $mem_event_type, $transaction_type, $channel, $rank, $device, $comp_id, $hpa, $region, $region_uuid, $pldm_entity_id, $pldm_res_id, $sub_type, $cme_threshold_ev_flags, $cme_count));
 	$out = "";
 	while($query_handle->fetch()) {
 	    $out .= "$id $timestamp error: ";
@@ -1997,20 +2060,25 @@ sub errors
 	    $out .= sprintf "dpa_flags: %s, ", get_cxl_dpa_flags_text($dpa_flags) if (defined $dpa_flags && length $dpa_flags);
 	    $out .= sprintf "descriptor_flags: %s, ", get_cxl_descriptor_flags_text($descriptor) if (defined $descriptor && length $descriptor);
 	    $out .= sprintf "memory event type: %s, ", get_cxl_gmer_mem_event_type($mem_event_type) if (defined $mem_event_type && length $mem_event_type);
+            $out .= sprintf "memory event sub type: %s, ", get_cxl_mem_event_sub_type($mem_event_sub_type) if (defined $mem_event_sub_type && length $mem_event_sub_type);
 	    $out .= sprintf "transaction_type: %s, ", get_cxl_transaction_type($transaction_type) if (defined $transaction_type && length $transaction_type);
 	    $out .= sprintf "channel=%u, ", $channel if (defined $channel && length $channel);
 	    $out .= sprintf "rank=%u, ", $rank if (defined $rank && length $rank);
 	    $out .= sprintf "device=0x%x, ", $device if (defined $device && length $device);
 	    if (defined $comp_id && length $comp_id) {
-		$out .= sprintf "component_id:";
-		my @bytes = unpack "C*", $comp_id;
-		for (my $i = 0; $i < CXL_EVENT_GEN_MED_COMP_ID_SIZE; $i++) {
-		    $out .= sprintf "%02x ", $bytes[$i];
-		}
+                print_cxl_dev_id("component_id", $comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE, $out);
 	    }
+            if (defined $pldm_entity_id && length $pldm_entity_id) {
+                print_cxl_dev_id("pldm_entity_id", $pldm_entity_id, CXL_EVENT_GEN_PLDM_ENTITY_ID_SIZE, $out);
+            }
+            if (defined $pldm_res_id && length $pldm_res_id) {
+                print_cxl_dev_id("pldm_resource_id", $pldm_res_id, CXL_EVENT_GEN_PLDM_RES_ID_SIZE, $out);
+            }
             $out .= sprintf "hpa=0x%llx, ", $hpa if (defined $hpa && length $hpa);
             $out .= "region=$region, " if (defined $region && length $region);
             $out .= "region_uuid=$region_uuid, " if (defined $region_uuid && length $region_uuid);
+            $out .= sprintf "cme_threshold_ev_flags: %s, ", get_cxl_cme_threshold_ev_flags_text($cme_threshold_ev_flags) if (defined $cme_threshold_ev_flags && length $cme_threshold_ev_flags);
+            $out .= sprintf "cme_count=%u, ", $cme_count if (defined $cme_count && length $cme_count);
 	    $out .= "\n";
 	}
 	if ($out ne "") {
-- 
2.43.0


