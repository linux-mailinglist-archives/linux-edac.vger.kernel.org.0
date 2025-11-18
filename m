Return-Path: <linux-edac+bounces-5458-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1EDC69CD1
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 15:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 036874F6722
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 14:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F6135A93D;
	Tue, 18 Nov 2025 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JxauxAMP"
X-Original-To: linux-edac@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E0347FC4
	for <linux-edac@vger.kernel.org>; Tue, 18 Nov 2025 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474246; cv=none; b=N/Ijdnp9P9GJoCYCmPQhdBX6HAYK7dVO7X6LXUZSY+aRi3N5REHhKS33Yj56MouzS2kRkUtjcARHNuT3BXaffTyzGi8QSuC/MgP2QgVNJZDtZvs86zMzZ+TVu54cf795IIRo1AsFr++WfHIbY5szAh1BqwZMjJaNsMeE0f2k4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474246; c=relaxed/simple;
	bh=B7Y2jPvXl+Ml5QhQY6ztxFtDJUDkgSlRRQBd47ldFNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXsBCI/hps1BksEh8gIDPqVNdr3rrMIrIKVFsQmW5IhWE7qU+eHHy+SjHX8aPV0eyXxhMf7IlQUdqV5daJBzL0Pcsjs/JGQcalnNmE9dnvmHdH/LSQJsRoQQV83km11IUj4+MAVI76sRw7o7pwYNhsMN2/QjJjs9CriGbL2jX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JxauxAMP; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763474233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hmbMMb0x7lTr3iL7dutg+8V0gOGJqiVZ6GailA3Ebok=;
	b=JxauxAMPa914qmTvX/ido2fDW11/RgBnkldyHSIgitunKlCCfXdjhror68o+R0a3LKXzFy
	qBEYoNjSW2pZE6CmT6+9PALMrdt1BliUelGr6w2FLF76g6AV8FJ4EcaywFqzwJqcAsfDwa
	aR7+WU8n/EDMSSi6YYrNvp7xRMbvSDA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] EDAC/ghes: Replace deprecated strcpy in ghes_edac_report_mem_error
Date: Tue, 18 Nov 2025 14:56:22 +0100
Message-ID: <20251118135621.101148-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() has been deprecated [1] because it performs no bounds checking
on the destination buffer, which can lead to buffer overflows. Use the
safer strscpy() instead.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Update patch description (Boris)
- Link to v1: https://lore.kernel.org/lkml/20251031114607.133523-1-thorsten.blum@linux.dev/
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


