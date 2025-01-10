Return-Path: <linux-edac+bounces-2861-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77342A09044
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 13:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954623A8F20
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4002520D502;
	Fri, 10 Jan 2025 12:27:02 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97E20CCFF;
	Fri, 10 Jan 2025 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512022; cv=none; b=dHgch0zYSDkdn/yjw4/KRU1zwEWeyCAHHKIKH7MbqfoYm1tQzOgIJapzx2owuY3OLRM/US5bOTGrKidIrh3ku35XnEXS3S3UTsXTfBj7aDfOtB0wmueYBlD/I8eOT3fuZ0FSip3PExG26ARU3DNo6pQe47tLUkaPoO/b+MWgXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512022; c=relaxed/simple;
	bh=D6bhIDt/2J7FW///EE7RuzuvXMlsMsnemwu6QDnllD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C52M2gWAfSw3QXcEpsQ4RAMoDj5Ux7WMsPxvvBd1Vq6BbrATdq7aojfsNW42hrzsrVtlAsvYdUqhMN2/iGmNDnBEuO2tdAjn1jc5UUIcT1uLNb/3/Qluf8TlcR7koDlsl6BkXnVvSKPqCB3Db0IT/BVbXfYBMsICZmE5LBJzBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV18S1Gr8z67mJg;
	Fri, 10 Jan 2025 20:25:44 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E75814022E;
	Fri, 10 Jan 2025 20:26:58 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.14) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 13:26:57 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 02/14] rasdaemon: cxl: Fix logging of memory event type of DRAM trace event
Date: Fri, 10 Jan 2025 12:26:28 +0000
Message-ID: <20250110122641.1668-3-shiju.jose@huawei.com>
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

Fix logging of memory event type field of DRAM trace event.
For e.g. if value is 0x1 it will be reported as an Invalid Address
(General Media Event Record - Memory Event Type) instead of Scrub Media
ECC Error (DRAM Event Record - Memory Event Type) and so on.

Fixes: 9a2f6186db26 ("rasdaemon: Add support for the CXL dram events")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index 67ce32e..8733b2b 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -898,6 +898,13 @@ int ras_cxl_general_media_event_handler(struct trace_seq *s,
 #define CXL_DER_VALID_COLUMN			BIT(6)
 #define CXL_DER_VALID_CORRECTION_MASK		BIT(7)
 
+static const char * const cxl_der_mem_event_type[] = {
+	"Media ECC Error",
+	"Scrub Media ECC Error",
+	"Invalid Address",
+	"Data Path Error",
+};
+
 int ras_cxl_dram_event_handler(struct trace_seq *s,
 			       struct tep_record *record,
 			       struct tep_event *event, void *context)
@@ -938,9 +945,9 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
 	if (tep_get_field_val(s,  event, "type", record, &val, 1) < 0)
 		return -1;
 	ev.type = val;
-	if (trace_seq_printf(s, "type:%s ",
-			     get_cxl_type_str(cxl_gmer_mem_event_type,
-					      ARRAY_SIZE(cxl_gmer_mem_event_type),
+	if (trace_seq_printf(s, "memory_event_type:%s ",
+			     get_cxl_type_str(cxl_der_mem_event_type,
+					      ARRAY_SIZE(cxl_der_mem_event_type),
 					      ev.type)) <= 0)
 		return -1;
 
-- 
2.43.0


