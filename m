Return-Path: <linux-edac+bounces-2577-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6719D37D2
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 11:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FFB1F248FF
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791441AAE18;
	Wed, 20 Nov 2024 10:00:38 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFBA1AA1DE;
	Wed, 20 Nov 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096838; cv=none; b=newU0nSR8UsuM/AeSdAl83OeFZELUcg4k4lOqbPPGcG4OuC9zNUgt93CyGhQIoJXDBVeMPW1jMbdXT4F/ekpYyOmxakOyr1iHKQCraUF0/YSdteoARRGq5crgCedoNUNjC7Po3OMwRqtSUI6XjXxTg/4JIr+nXyyTbOmLB8JYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096838; c=relaxed/simple;
	bh=aU8mrRh2PwcG4SYFEXTEPcfJJ57bkVCpuJvMDJZRP84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGE4wZHuuOr7KAUMW3j43fY2MYHNeM1C7i7SBWeIgghen1Up0B0hayHZJKyJJwDRnMxVOX2JFO/ILemHuMxQy2LyQGEM/N1+xU9YxTrLUOrH1jqs9a7Wcy///Rxvl61P89CX+enn9m1VjDHDC4fKVNT+4ZH3irgOPTG+oB3IaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtcHt12zjz6K98Z;
	Wed, 20 Nov 2024 17:58:18 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id AECA7140CF4;
	Wed, 20 Nov 2024 18:00:34 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:00:33 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 13/13] rasdaemon: ras-mc-ctl: Update logging of CXL memory module data to align with CXL spec rev 3.1
Date: Wed, 20 Nov 2024 09:59:23 +0000
Message-ID: <20241120095923.1891-14-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.2.1.3 Table 8-47, Memory Module Event Record
has updated with following new fields and new info for Device Event Type
and Device Health Information fields.
1. Validity Flags
2. Component Identifier
3. Device Event Sub-Type

This update modifies ras-mc-ctl to parse and log CXL memory module event
data stored in the RAS SQLite database table, reflecting the
specification changes introduced in revision 3.1.

Example output,

./util/ras-mc-ctl --errors
...
CXL memory module events:
1 2024-11-20 00:22:33 +0000 error: memdev=mem0, host=0000:0f:00.0, serial=0x3, \
log=Fatal, hdr_uuid=fe927475-dd59-4339-a586-79bab113b774, hdr_flags=0x1, , \
hdr_handle=0x1, hdr_related_handle=0x0, hdr_timestamp=1970-01-01 00:04:38 +0000, \
hdr_length=128, hdr_maint_op_class=0, hdr_maint_op_sub_class=1, \
event_type: Temperature Change, event_sub_type: Unsupported Config Data, \
health_status: 'MAINTENANCE_NEEDED' , 'REPLACEMENT_NEEDED' , \
media_status: All Data Loss in Event of Power Loss, life_used=8, \
dirty_shutdown_cnt=33, cor_vol_err_cnt=25, cor_per_err_cnt=45, \
device_temp=3, add_status=3 \
component_id:02 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
pldm_entity_id:00 00 00 00 00 00 pldm_resource_id:fc d2 7e 2f 
...

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 46 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index dbb1607..0990da9 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1439,11 +1439,12 @@ sub get_cxl_transaction_type
     return $types[$_[0]];
 }
 
+# CXL rev 3.1 section 8.2.9.2.1.3; Table 8-47
 sub get_cxl_dev_event_type
 {
     my @types;
 
-    if ($_[0] < 0 || $_[0] > 5) {
+    if ($_[0] < 0 || $_[0] > 8) {
 	return "unknown-type";
     }
 
@@ -1452,15 +1453,37 @@ sub get_cxl_dev_event_type
 	      "Life Used Change",
 	      "Temperature Change",
 	      "Data Path Error",
-	      "LSA Error");
+	      "LSA Error",
+	      "Unrecoverable Internal Sideband Bus Error",
+	      "Memory Media FRU Error",
+	      "Power Management Fault");
 
     return $types[$_[0]];
 }
 
+sub get_cxl_dev_event_sub_type
+{
+    my @types;
+
+    if ($_[0] < 0 || $_[0] > 3) {
+	return "unknown-type";
+    }
+
+    @types = ("Not Reported",
+	      "Invalid Config Data",
+	      "Unsupported Config Data",
+	      "Unsupported Memory Media FRU");
+
+    return $types[$_[0]];
+}
+
+#CXL rev 3.1 section 8.2.9.9.3.1; Table 8-133
 use constant {
     CXL_DHI_HS_MAINTENANCE_NEEDED => 0x0001,
     CXL_DHI_HS_PERFORMANCE_DEGRADED => 0x0002,
     CXL_DHI_HS_HW_REPLACEMENT_NEEDED => 0x0004,
+    CXL_DHI_HS_HW_REPLACEMENT_NEEDED => 0x0004,
+    CXL_DHI_HS_MEM_CAPACITY_DEGRADED => 0x0008,
 };
 
 sub get_cxl_health_status_text
@@ -1477,6 +1500,9 @@ sub get_cxl_health_status_text
     if ($flags & CXL_DHI_HS_HW_REPLACEMENT_NEEDED) {
 	push @out, (sprintf "\'REPLACEMENT_NEEDED\' ");
     }
+    if ($flags & CXL_DHI_HS_MEM_CAPACITY_DEGRADED) {
+	push @out, (sprintf "\'MEM_CAPACITY_DEGRADED\' ");
+    }
 
     return join (", ", @out);
 }
@@ -1821,7 +1847,7 @@ sub errors
     my ($hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $hdr_maint_op_sub_class, $data);
     my ($dpa_flags, $descriptor, $mem_event_type, $mem_event_sub_type, $transaction_type, $channel, $rank, $device, $comp_id, $pldm_entity_id, $pldm_res_id);
     my ($nibble_mask, $bank_group, $row, $column, $cor_mask);
-    my ($event_type, $health_status, $media_status, $life_used, $dirty_shutdown_cnt, $cor_vol_err_cnt, $cor_per_err_cnt, $device_temp, $add_status);
+    my ($event_type, $event_sub_type, $health_status, $media_status, $life_used, $dirty_shutdown_cnt, $cor_vol_err_cnt, $cor_per_err_cnt, $device_temp, $add_status);
     my ($sub_channel, $cme_threshold_ev_flags, $cme_count, $cvme_count);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
@@ -2155,10 +2181,10 @@ sub errors
 	}
 
 	# CXL memory module errors
-	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, event_type, health_status, media_status, life_used, dirty_shutdown_cnt, cor_vol_err_cnt, cor_per_err_cnt, device_temp, add_status, hdr_maint_op_sub_class from cxl_memory_module_event$conf{opt}{since} order by id";
+	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, event_type, health_status, media_status, life_used, dirty_shutdown_cnt, cor_vol_err_cnt, cor_per_err_cnt, device_temp, add_status, hdr_maint_op_sub_class, event_sub_type, comp_id, pldm_entity_id, pldm_resource_id from cxl_memory_module_event$conf{opt}{since} order by id";
 	$query_handle = $dbh->prepare($query);
 	$query_handle->execute();
-	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $event_type, $health_status, $media_status, $life_used, $dirty_shutdown_cnt, $cor_vol_err_cnt, $cor_per_err_cnt, $device_temp, $add_status, $hdr_maint_op_sub_class));
+	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $event_type, $health_status, $media_status, $life_used, $dirty_shutdown_cnt, $cor_vol_err_cnt, $cor_per_err_cnt, $device_temp, $add_status, $hdr_maint_op_sub_class, $event_sub_type, $comp_id, $pldm_entity_id, $pldm_res_id));
 	$out = "";
 	while($query_handle->fetch()) {
 	    $out .= "$id $timestamp error: ";
@@ -2175,6 +2201,7 @@ sub errors
 	    $out .= sprintf "hdr_maint_op_class=%u, ", $hdr_maint_op_class if (defined $hdr_maint_op_class && length $hdr_maint_op_class);
 	    $out .= sprintf "hdr_maint_op_sub_class=%u, ", $hdr_maint_op_sub_class if (defined $hdr_maint_op_sub_class && length $hdr_maint_op_sub_class);
 	    $out .= sprintf "event_type: %s, ", get_cxl_dev_event_type($event_type)  if (defined $event_type && length $event_type);
+            $out .= sprintf "event_sub_type: %s, ", get_cxl_dev_event_sub_type($event_sub_type)  if (defined $event_sub_type && length $event_sub_type);
 	    $out .= sprintf "health_status: %s, ", get_cxl_health_status_text($health_status)  if (defined $health_status && length $health_status);
 	    $out .= sprintf "media_status: %s, ", get_cxl_media_status($media_status)  if (defined $media_status && length $media_status);
 	    $out .= sprintf "life_used=%u, ", $life_used  if (defined $life_used && length $life_used);
@@ -2183,6 +2210,15 @@ sub errors
 	    $out .= sprintf "cor_per_err_cnt=%u, ", $cor_per_err_cnt  if (defined $cor_per_err_cnt && length $cor_per_err_cnt);
 	    $out .= sprintf "device_temp=%u, ", $device_temp  if (defined $device_temp && length $device_temp);
 	    $out .= sprintf "add_status=%u ", $add_status  if (defined $add_status && length $add_status);
+            if (defined $comp_id && length $comp_id) {
+                print_cxl_dev_id("component_id", $comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE, $out);
+            }
+            if (defined $pldm_entity_id && length $pldm_entity_id) {
+                print_cxl_dev_id("pldm_entity_id", $pldm_entity_id, CXL_EVENT_GEN_PLDM_ENTITY_ID_SIZE, $out);
+            }
+            if (defined $pldm_res_id && length $pldm_res_id) {
+                print_cxl_dev_id("pldm_resource_id", $pldm_res_id, CXL_EVENT_GEN_PLDM_RES_ID_SIZE, $out);
+            }
 	    $out .= "\n";
 	}
 	if ($out ne "") {
-- 
2.43.0


