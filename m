Return-Path: <linux-edac+bounces-2573-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C79D37CB
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 11:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353BA1F24289
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 10:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332D1A7255;
	Wed, 20 Nov 2024 10:00:33 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636071A304A;
	Wed, 20 Nov 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096833; cv=none; b=N2bfotV8kbQRtTXbOhXInu4NlRlCRqrvU9dCPCG6KYZCiauwao6pw6HMOBiSWMexS7PAmvUQwogTVyXlac5DHxQhNxmJfAL9v5iX6vY/lDYVJgU/cdg+FiuvlI3L0O0VQJtiNPz960QyQIuFdBcHILB/rE5Jmf45WqB9HWC07kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096833; c=relaxed/simple;
	bh=odXjPx57klL4KaCZpHh0R8RKqBvJmgvJx5wio021wFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIJDLSuu4Y7tkPsUt+1Py/Bi9dt/tXX9Gs2YfnqeXd90yRmdCLPPXHvcntuEw9rCeZ3tiVtQU5htgm8Z0S7R0oEWeNAexMotnECmkUqiBcxX5s/d8oGMcrOpZ0MpYdg8k1JkvP31or9Vx7g1nQHAc+ikDfAA1MHc86IsNBVfZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtcGL3QFtz6J6bg;
	Wed, 20 Nov 2024 17:56:58 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 43FAF140B55;
	Wed, 20 Nov 2024 18:00:29 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:00:27 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 09/13] rasdaemon: ras-mc-ctl: Fix logging of memory event type in CXL DRAM error table
Date: Wed, 20 Nov 2024 09:59:19 +0000
Message-ID: <20241120095923.1891-10-shiju.jose@huawei.com>
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

CXL spec rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.

Fix decoding of memory event type in the CXL DRAM error table in RAS
SQLite database.
For e.g. if value is 0x1 it will be logged as an Invalid Address
(General Media Event Record - Memory Event Type) instead of Scrub Media
ECC Error (DRAM Event Record - Memory Event Type) and so on.

Fixes: c38c14afc5d7 ("rasdaemon: ras-mc-ctl: Add support for CXL DRAM trace events")
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


