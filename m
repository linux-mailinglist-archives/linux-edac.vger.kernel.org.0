Return-Path: <linux-edac+bounces-2566-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 837DC9D37E0
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 11:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F2C1B2C5C8
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193BE19D89B;
	Wed, 20 Nov 2024 10:00:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5D1714BE;
	Wed, 20 Nov 2024 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096825; cv=none; b=JWDO4vrXERDDfcYy6ID7ktMI99nvWXhHoDt5l7lmRANzhpup/ilf8MBhS5lW5PFTsxLU/apxuISy+ES5bbBl4gQsyU5wBZNV9dsXXSroTAYQxj5fK4W9OS76tfW96jUTwL4Fclf6C4cBiybr1wpYRcxuunrRwbdRigJkb1iAs6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096825; c=relaxed/simple;
	bh=j+iCJZVSiM9lGRSBsJcmXMX/vFg8DZGDGte9IPZy7j4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czD2favnkF/UvtWqtEWAzGSOb5z/kyiATyS5xb6VJe8hme3AgMj6N5IwD9dVFle0t/kYG4Fha9OT/QmaFBOH6G2dQ0mIos2H3plTvZj78dHJu45k30b8tVusUnHHfmQU2/Qkf1xCH2ay+yx5MUVi+ulL88VDTwcrJjnZRerSoBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtcG95dP2z6J6YS;
	Wed, 20 Nov 2024 17:56:49 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 957DC140CF4;
	Wed, 20 Nov 2024 18:00:20 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:00:19 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 02/13] rasdaemon: cxl: Fix mismatch in region field's name with kernel DRAM trace event
Date: Wed, 20 Nov 2024 09:59:12 +0000
Message-ID: <20241120095923.1891-3-shiju.jose@huawei.com>
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

Fix mismatch in 'region' field's name with kernel DRAM trace event.

Fixes: ea224ad58b37 ("rasdaemon: CXL: Extract, log and record region info from cxl_general_media and cxl_dram events")

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index 8733b2b..7d4fc9f 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -966,7 +966,7 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
 	if (trace_seq_printf(s, "hpa:0x%llx ", (unsigned long long)ev.hpa) <= 0)
 		return -1;
 
-	ev.region = tep_get_field_raw(s, event, "region", record, &len, 1);
+	ev.region = tep_get_field_raw(s, event, "region_name", record, &len, 1);
 	if (!ev.region)
 		return -1;
 	if (trace_seq_printf(s, "region:%s ", ev.region) <= 0)
-- 
2.43.0


