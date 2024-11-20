Return-Path: <linux-edac+bounces-2574-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94749D37E1
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 11:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0D3B2DB98
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 10:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393141A0AF2;
	Wed, 20 Nov 2024 10:00:35 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C41A4F20;
	Wed, 20 Nov 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096835; cv=none; b=Cf4/LC7q2/qsQDnqXzwtb5g0k2PbG6SB8ctkMifXoZolgz9XM0h5iovIQ3Et6xQtehe6zIYGACOYKsDIi8wc7Pv2cb/TNsh8Lvnmhsx89s88QM76i2wDjoikNNxEElxyI+Cl5MUsaNscJoUweI9On2SEdHUxUSDm8AYv4zm2X9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096835; c=relaxed/simple;
	bh=+7Nalnfa5ggI50m9KvlZLFKQ2L5CaiT2QyfvrLdm2YU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pu58gSj5DFaBVKPAEWE2ffNBIkLOhTjsP3DrTgbntC/SpI9P9Ph00pkPMHvWXNT8/FRFUzSCfmkscL4+8oPzg8vpNpmLCLMW/01HcAZnNrbtM1gSfyyty+pVefDnqkAdK0WuWqvwQJm5Arzbb9dZVq/jc2klwm/mtj2ftjJKlmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtcL04VKcz6L764;
	Wed, 20 Nov 2024 18:00:08 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id D0177140F3F;
	Wed, 20 Nov 2024 18:00:30 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:00:29 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 10/13] rasdaemon: ras-mc-ctl: Update logging of common event data to align with CXL spec rev 3.1
Date: Wed, 20 Nov 2024 09:59:20 +0000
Message-ID: <20241120095923.1891-11-shiju.jose@huawei.com>
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

The Common Event Record format in the CXL spec 3.1, section 8.2.9.2.1,
Table 8-42, has been updated to include Maintenance Operation Subclass
information.

This update modifies ras-mc-ctl to log CXL common event data in the RAS
SQLite database tables, reflecting the specification changes introduced
in revision 3.1.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 3f9bad0..e075ad8 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1755,7 +1755,7 @@ sub errors
     my ($memdev, $host, $serial, $error_status, $first_error, $header_log);
     my ($log_type, $first_ts, $last_ts);
     my ($trace_type, $region, $region_uuid, $hpa, $dpa, $dpa_length, $source, $flags, $overflow_ts);
-    my ($hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $data);
+    my ($hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $hdr_maint_op_sub_class, $data);
     my ($dpa_flags, $descriptor, $mem_event_type, $transaction_type, $channel, $rank, $device, $comp_id);
     my ($nibble_mask, $bank_group, $row, $column, $cor_mask);
     my ($event_type, $health_status, $media_status, $life_used, $dirty_shutdown_cnt, $cor_vol_err_cnt, $cor_per_err_cnt, $device_temp, $add_status);
@@ -1935,10 +1935,10 @@ sub errors
 
 	# CXL generic errors
 	use constant CXL_EVENT_RECORD_DATA_LENGTH => 0x50;
-	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, data from cxl_generic_event$conf{opt}{since} order by id";
+	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, data, hdr_maint_op_sub_class from cxl_generic_event$conf{opt}{since} order by id";
 	$query_handle = $dbh->prepare($query);
 	$query_handle->execute();
-	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $data));
+	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $data, $hdr_maint_op_sub_class));
 	$out = "";
 	while($query_handle->fetch()) {
 	    $out .= "$id $timestamp error: ";
@@ -1953,6 +1953,7 @@ sub errors
 	    $out .= "hdr_timestamp=$hdr_ts, " if (defined $hdr_ts && length $hdr_ts);
 	    $out .= sprintf "hdr_length=%u, ", $hdr_length if (defined $hdr_length && length $hdr_length);
 	    $out .= sprintf "hdr_maint_op_class=%u, ", $hdr_maint_op_class if (defined $hdr_maint_op_class && length $hdr_maint_op_class);
+	    $out .= sprintf "hdr_maint_op_sub_class=%u, ", $hdr_maint_op_sub_class if (defined $hdr_maint_op_sub_class && length $hdr_maint_op_sub_class);
 	    if (defined $data && length $data) {
 		$out .= sprintf "data:\n";
 		my @bytes = unpack "C*", $data;
@@ -1973,10 +1974,10 @@ sub errors
 
 	# CXL general media errors
 	use constant CXL_EVENT_GEN_MED_COMP_ID_SIZE => 0x10;
-	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, dpa, dpa_flags, descriptor, type, transaction_type, channel, rank, device, comp_id, hpa, region, region_uuid from cxl_general_media_event$conf{opt}{since} order by id";
+	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, dpa, dpa_flags, descriptor, type, transaction_type, channel, rank, device, comp_id, hpa, region, region_uuid, hdr_maint_op_sub_class from cxl_general_media_event$conf{opt}{since} order by id";
 	$query_handle = $dbh->prepare($query);
 	$query_handle->execute();
-	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $dpa, $dpa_flags, $descriptor, $mem_event_type, $transaction_type, $channel, $rank, $device, $comp_id, $hpa, $region, $region_uuid));
+	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $dpa, $dpa_flags, $descriptor, $mem_event_type, $transaction_type, $channel, $rank, $device, $comp_id, $hpa, $region, $region_uuid, $hdr_maint_op_sub_class));
 	$out = "";
 	while($query_handle->fetch()) {
 	    $out .= "$id $timestamp error: ";
@@ -1991,6 +1992,7 @@ sub errors
 	    $out .= "hdr_timestamp=$hdr_ts, " if (defined $hdr_ts && length $hdr_ts);
 	    $out .= sprintf "hdr_length=%u, ", $hdr_length if (defined $hdr_length && length $hdr_length);
 	    $out .= sprintf "hdr_maint_op_class=%u, ", $hdr_maint_op_class if (defined $hdr_maint_op_class && length $hdr_maint_op_class);
+	    $out .= sprintf "hdr_maint_op_sub_class=%u, ", $hdr_maint_op_sub_class if (defined $hdr_maint_op_sub_class && length $hdr_maint_op_sub_class);
 	    $out .= sprintf "dpa=0x%llx, ", $dpa if (defined $dpa && length $dpa);
 	    $out .= sprintf "dpa_flags: %s, ", get_cxl_dpa_flags_text($dpa_flags) if (defined $dpa_flags && length $dpa_flags);
 	    $out .= sprintf "descriptor_flags: %s, ", get_cxl_descriptor_flags_text($descriptor) if (defined $descriptor && length $descriptor);
@@ -2019,10 +2021,10 @@ sub errors
 
 	# CXL DRAM errors
 	use constant CXL_EVENT_DER_CORRECTION_MASK_SIZE => 0x20;
-	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, dpa, dpa_flags, descriptor, type, transaction_type, channel, rank, nibble_mask, bank_group, bank, row, column, cor_mask, hpa, region, region_uuid from cxl_dram_event$conf{opt}{since} order by id";
+	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, dpa, dpa_flags, descriptor, type, transaction_type, channel, rank, nibble_mask, bank_group, bank, row, column, cor_mask, hpa, region, region_uuid, hdr_maint_op_sub_class from cxl_dram_event$conf{opt}{since} order by id";
 	$query_handle = $dbh->prepare($query);
 	$query_handle->execute();
-	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $dpa, $dpa_flags, $descriptor, $type, $transaction_type, $channel, $rank, $nibble_mask, $bank_group, $bank, $row, $column, $cor_mask, $hpa, $region, $region_uuid));
+	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $dpa, $dpa_flags, $descriptor, $type, $transaction_type, $channel, $rank, $nibble_mask, $bank_group, $bank, $row, $column, $cor_mask, $hpa, $region, $region_uuid, $hdr_maint_op_sub_class));
 	$out = "";
 	while($query_handle->fetch()) {
 	    $out .= "$id $timestamp error: ";
@@ -2037,6 +2039,7 @@ sub errors
 	    $out .= "hdr_timestamp=$hdr_ts, " if (defined $hdr_ts && length $hdr_ts);
 	    $out .= sprintf "hdr_length=%u, ", $hdr_length if (defined $hdr_length && length $hdr_length);
 	    $out .= sprintf "hdr_maint_op_class=%u, ", $hdr_maint_op_class if (defined $hdr_maint_op_class && length $hdr_maint_op_class);
+	    $out .= sprintf "hdr_maint_op_sub_class=%u, ", $hdr_maint_op_sub_class if (defined $hdr_maint_op_sub_class && length $hdr_maint_op_sub_class);
 	    $out .= sprintf "dpa=0x%llx, ", $dpa if (defined $dpa && length $dpa);
 	    $out .= sprintf "dpa_flags: %s, ", get_cxl_dpa_flags_text($dpa_flags) if (defined $dpa_flags && length $dpa_flags);
 	    $out .= sprintf "descriptor_flags: %s, ", get_cxl_descriptor_flags_text($descriptor) if (defined $descriptor && length $descriptor);
@@ -2068,10 +2071,10 @@ sub errors
 	}
 
 	# CXL memory module errors
-	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, event_type, health_status, media_status, life_used, dirty_shutdown_cnt, cor_vol_err_cnt, cor_per_err_cnt, device_temp, add_status from cxl_memory_module_event$conf{opt}{since} order by id";
+	$query = "select id, timestamp, memdev, host, serial, log_type, hdr_uuid, hdr_flags, hdr_handle, hdr_related_handle, hdr_ts, hdr_length, hdr_maint_op_class, event_type, health_status, media_status, life_used, dirty_shutdown_cnt, cor_vol_err_cnt, cor_per_err_cnt, device_temp, add_status, hdr_maint_op_sub_class from cxl_memory_module_event$conf{opt}{since} order by id";
 	$query_handle = $dbh->prepare($query);
 	$query_handle->execute();
-	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $event_type, $health_status, $media_status, $life_used, $dirty_shutdown_cnt, $cor_vol_err_cnt, $cor_per_err_cnt, $device_temp, $add_status));
+	$query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $hdr_uuid, $hdr_flags, $hdr_handle, $hdr_related_handle, $hdr_ts, $hdr_length, $hdr_maint_op_class, $event_type, $health_status, $media_status, $life_used, $dirty_shutdown_cnt, $cor_vol_err_cnt, $cor_per_err_cnt, $device_temp, $add_status, $hdr_maint_op_sub_class));
 	$out = "";
 	while($query_handle->fetch()) {
 	    $out .= "$id $timestamp error: ";
@@ -2086,6 +2089,7 @@ sub errors
 	    $out .= "hdr_timestamp=$hdr_ts, " if (defined $hdr_ts && length $hdr_ts);
 	    $out .= sprintf "hdr_length=%u, ", $hdr_length if (defined $hdr_length && length $hdr_length);
 	    $out .= sprintf "hdr_maint_op_class=%u, ", $hdr_maint_op_class if (defined $hdr_maint_op_class && length $hdr_maint_op_class);
+	    $out .= sprintf "hdr_maint_op_sub_class=%u, ", $hdr_maint_op_sub_class if (defined $hdr_maint_op_sub_class && length $hdr_maint_op_sub_class);
 	    $out .= sprintf "event_type: %s, ", get_cxl_dev_event_type($event_type)  if (defined $event_type && length $event_type);
 	    $out .= sprintf "health_status: %s, ", get_cxl_health_status_text($health_status)  if (defined $health_status && length $health_status);
 	    $out .= sprintf "media_status: %s, ", get_cxl_media_status($media_status)  if (defined $media_status && length $media_status);
-- 
2.43.0


