Return-Path: <linux-edac+bounces-2870-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE42A09057
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 13:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1477A501B
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E680920FA9E;
	Fri, 10 Jan 2025 12:27:11 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9458020E708;
	Fri, 10 Jan 2025 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512031; cv=none; b=NvdHCXugZIOYu3FEbv/LmCpTBD4f15lE9+JCwTTWNZHKC5tWMX84tJqslkVWLCEVxNqHIVzTami1uq33jmlXuNrYDiFGBBQZJ2jVsviVdqN4mqPgMh5GwZF87m5NsgHJEKm5KCP044g69PTfL1oe/HSez5qLYsokAaDCfgtYL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512031; c=relaxed/simple;
	bh=pl7xgqly1nZC13pJTNwzbx5ji1p/DFLza513JE9xfus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftnSFlGrNcPooIhClfZTx6pNHQXd8pYh9TjITijhKSx/wDkwJi1HQEjFJ/616SPDOy7cAlBds6zgY1xyWJGXUr1el1w1AtfvmEklFDVK0+ANGMg3stGB2+JK58KtCe03uIjpVt7VMSEZWVuXtowib/9ZfmDXRndDd4nf6CmYRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV18B0yv2z6GFm8;
	Fri, 10 Jan 2025 20:25:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id CF8F91406AC;
	Fri, 10 Jan 2025 20:27:07 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.14) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 13:27:06 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 10/14] rasdaemon: ras-mc-ctl: Fix logging of memory event type in CXL DRAM error table
Date: Fri, 10 Jan 2025 12:26:36 +0000
Message-ID: <20250110122641.1668-11-shiju.jose@huawei.com>
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

CXL spec rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.

Fix decoding of memory event type in the CXL DRAM error table in RAS
SQLite database.
For e.g. if value is 0x1 it will be logged as an Invalid Address
(General Media Event Record - Memory Event Type) instead of Scrub Media
ECC Error (DRAM Event Record - Memory Event Type) and so on.

Fixes: c38c14afc5d7 ("rasdaemon: ras-mc-ctl: Add support for CXL DRAM trace events")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index c24941f..3f9bad0 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1339,7 +1339,7 @@ sub get_cxl_descriptor_flags_text
     return join (", ", @out);
 }
 
-sub get_cxl_mem_event_type
+sub get_cxl_gmer_mem_event_type
 {
     my @types;
 
@@ -1354,6 +1354,22 @@ sub get_cxl_mem_event_type
     return $types[$_[0]];
 }
 
+sub get_cxl_der_mem_event_type
+{
+    my @types;
+
+    if ($_[0] < 0 || $_[0] > 3) {
+	return "unknown-type";
+    }
+
+    @types = ("Media ECC Error",
+	      "Scrub Media ECC Error",
+	      "Invalid Address",
+	      "Data Path Error");
+
+    return $types[$_[0]];
+}
+
 sub get_cxl_transaction_type
 {
     my @types;
@@ -1978,7 +1994,7 @@ sub errors
 	    $out .= sprintf "dpa=0x%llx, ", $dpa if (defined $dpa && length $dpa);
 	    $out .= sprintf "dpa_flags: %s, ", get_cxl_dpa_flags_text($dpa_flags) if (defined $dpa_flags && length $dpa_flags);
 	    $out .= sprintf "descriptor_flags: %s, ", get_cxl_descriptor_flags_text($descriptor) if (defined $descriptor && length $descriptor);
-	    $out .= sprintf "memory event type: %s, ", get_cxl_mem_event_type($mem_event_type) if (defined $mem_event_type && length $mem_event_type);
+	    $out .= sprintf "memory event type: %s, ", get_cxl_gmer_mem_event_type($mem_event_type) if (defined $mem_event_type && length $mem_event_type);
 	    $out .= sprintf "transaction_type: %s, ", get_cxl_transaction_type($transaction_type) if (defined $transaction_type && length $transaction_type);
 	    $out .= sprintf "channel=%u, ", $channel if (defined $channel && length $channel);
 	    $out .= sprintf "rank=%u, ", $rank if (defined $rank && length $rank);
@@ -2024,7 +2040,7 @@ sub errors
 	    $out .= sprintf "dpa=0x%llx, ", $dpa if (defined $dpa && length $dpa);
 	    $out .= sprintf "dpa_flags: %s, ", get_cxl_dpa_flags_text($dpa_flags) if (defined $dpa_flags && length $dpa_flags);
 	    $out .= sprintf "descriptor_flags: %s, ", get_cxl_descriptor_flags_text($descriptor) if (defined $descriptor && length $descriptor);
-	    $out .= sprintf "memory event type: %s, ", get_cxl_mem_event_type($type) if (defined $type && length $type);
+	    $out .= sprintf "memory event type: %s, ", get_cxl_der_mem_event_type($type) if (defined $type && length $type);
 	    $out .= sprintf "transaction_type: %s, ", get_cxl_transaction_type($transaction_type) if (defined $transaction_type && length $transaction_type);
 	    $out .= sprintf "channel=%u, ", $channel if (defined $channel && length $channel);
 	    $out .= sprintf "rank=%u, ", $rank if (defined $rank && length $rank);
-- 
2.43.0


