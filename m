Return-Path: <linux-edac+bounces-2863-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE73EA09047
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 13:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A65188CF35
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E320DD5E;
	Fri, 10 Jan 2025 12:27:03 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5620D4E1;
	Fri, 10 Jan 2025 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512023; cv=none; b=ROk+Ub13xnMozOdRXSbXvHsk18NKVddeOD6e4M4qTNhuGOenZDHLGu6dgoi533H2KUOmlV4/9g23oS/rjpnRnHDfevqyF7cHGezM4XTnHfJnjU6CjfVu6EKg9938/g02Jj13CfD20sygzbDzxQkzbnA6EUESe0zFkOINJTFBhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512023; c=relaxed/simple;
	bh=EyIzN5hw5gWxxHs3Qj+6T0IsAi7m2FKPlyIvVTbPZ7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0Z9sQ68sZWnpqag/HS1pC30mKDpTEeIneGVlgFcONRhm5rnxPW0lUssMRSOvcSiFh4wCC+uAXeSOVITq/X2YdWr0NHc/qrmQDR+IYgp/owvQfbjg9swIgYzzaVRBhXtAY9Do0fBYYLD3zOCCrhg4jYzBkbt7+WVl1X2iyOtypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV14V3JCpz6K5VF;
	Fri, 10 Jan 2025 20:22:18 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 74C1C140A86;
	Fri, 10 Jan 2025 20:26:59 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.14) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 13:26:58 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 03/14] rasdaemon: cxl: Fix mismatch in region field's name with kernel DRAM trace event
Date: Fri, 10 Jan 2025 12:26:29 +0000
Message-ID: <20250110122641.1668-4-shiju.jose@huawei.com>
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

Fix mismatch in 'region' field's name with kernel DRAM trace event.

Fixes: ea224ad58b37 ("rasdaemon: CXL: Extract, log and record region info from cxl_general_media and cxl_dram events")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


