Return-Path: <linux-edac+bounces-2564-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A16ED9D37E8
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 11:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F7CB28F7C
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D207119DF9A;
	Wed, 20 Nov 2024 10:00:23 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F819CC05;
	Wed, 20 Nov 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096823; cv=none; b=Kt5RUQaBRg9ZkcgMRlRkK+P5J0XLKQpipg0/VKwlXvRvk/vapO2GtJaTKUpGtFcbRqcC9St43NYXZOq6Jpcftvl8KD6p72oj7ldquAIpvgQZkqF0qnCsNCxwcbG+GZGyoKvgJumlzeFsyOxXoLAx2ZGtIaRNsO+Ex/XJ2x+z7PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096823; c=relaxed/simple;
	bh=HvMPg9eNH0Cq39DgYlaE54bKxU4kLupfTmtt+JKz4eA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucAhJCRxJSRRr9XTJS1VjeET0B4yGtr5hz7UtxqkmJ9qjKO209iE1DH6VM02l0d41HXGZLojhvsRBUGGFHh1zY6SQSbKqB4eAj4lnirsp0TcAqx0M5zELzpCDrw/SVqZbR7bOwtdYibt+/RwxQRFFr/IqbpDTnCusLWSLF3idcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtcKn1Z0xz6L764;
	Wed, 20 Nov 2024 17:59:57 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B66B140119;
	Wed, 20 Nov 2024 18:00:19 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:00:18 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 01/13] rasdaemon: cxl: Fix logging of memory event type of DRAM trace event
Date: Wed, 20 Nov 2024 09:59:11 +0000
Message-ID: <20241120095923.1891-2-shiju.jose@huawei.com>
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

Fix logging of memory event type field of DRAM trace event.
For e.g. if value is 0x1 it will be reported as an Invalid Address
(General Media Event Record - Memory Event Type) instead of Scrub Media
ECC Error (DRAM Event Record - Memory Event Type) and so on.

Fixes: 9a2f6186db26 ("rasdaemon: Add support for the CXL dram events")
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


