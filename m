Return-Path: <linux-edac+bounces-5441-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2E6C5E179
	for <lists+linux-edac@lfdr.de>; Fri, 14 Nov 2025 17:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B653020056
	for <lists+linux-edac@lfdr.de>; Fri, 14 Nov 2025 16:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB361624C5;
	Fri, 14 Nov 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DHvxbCky"
X-Original-To: linux-edac@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4F26E17F
	for <linux-edac@vger.kernel.org>; Fri, 14 Nov 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136032; cv=none; b=IML4SVHz30fYfFoSGxNNdCVtx6egH+uhoDO1mPgb0bJXzEvzLGf9reeTz/AXR0AHkV7scjtqjC9He7kZg3zyV77a7AsDS4VkKnLVr7mx92kKiXWkfQxjTpUaiy0MdiBM/H7T043yB6CPkD7///EfrUCIIhCjWQnKoeIFBT2k3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136032; c=relaxed/simple;
	bh=XECehUmSI7TK5rOPKBoCkm+0nPhV+OBi+2SN6lu1Qhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HHB+DLdoMwds7XqGAPzSNhas9OBB7CxALKz0lwZx4fE6XyIbt4RW2212K1VbNIRDSUhe9dSB+uTY8k19VoODvPlhx5TT93iEXVrIRI5D+PBgUpHaIAVNLhH5iP76MXIYupYLDZGyg5gSMQtgbdKYlxgzdwIequBoRFVmPkZwHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DHvxbCky; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763136028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zbOtzsUl4rD3ykr6Of7jeUrXRsx4bYIw63wLmw7EuHM=;
	b=DHvxbCkyDEG9rMU0lFA3FJA9jxV+Txk4CJo+bfYN67+PHGLF27nyU6vVKTQM5/n/Ct6wgs
	U19u9Z8Co2UoIH2ZaCRR9ipj/vjgt5/7Akj5M3MBHD9GwuzNOexRPCnTmNdwoPDWGor4sn
	q/XcQ2yTFTOsgqCQHNThqolHyw7ekQ0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] EDAC/ghes: Replace deprecated strcpy in ghes_edac_report_mem_error
Date: Fri, 14 Nov 2025 17:00:05 +0100
Message-ID: <20251114160004.230025-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead. No functional changes.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/edac/ghes_edac.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 1eb0136c6fbd..d80c88818691 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -15,6 +15,7 @@
 #include "edac_module.h"
 #include <ras/ras_event.h>
 #include <linux/notifier.h>
+#include <linux/string.h>
 
 #define OTHER_DETAIL_LEN	400
 
@@ -332,7 +333,7 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 		p = pvt->msg;
 		p += snprintf(p, sizeof(pvt->msg), "%s", cper_mem_err_type_str(etype));
 	} else {
-		strcpy(pvt->msg, "unknown error");
+		strscpy(pvt->msg, "unknown error");
 	}
 
 	/* Error address */
@@ -357,14 +358,14 @@ static int ghes_edac_report_mem_error(struct notifier_block *nb,
 		dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
 		if (dimm) {
 			e->top_layer = dimm->idx;
-			strcpy(e->label, dimm->label);
+			strscpy(e->label, dimm->label);
 		}
 	}
 	if (p > e->location)
 		*(p - 1) = '\0';
 
 	if (!*e->label)
-		strcpy(e->label, "unknown memory");
+		strscpy(e->label, "unknown memory");
 
 	/* All other fields are mapped on e->other_detail */
 	p = pvt->other_detail;
-- 
2.51.1


