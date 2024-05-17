Return-Path: <linux-edac+bounces-1075-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB178C8DE5
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2024 23:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4E7282624
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2024 21:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4E313DDB8;
	Fri, 17 May 2024 21:55:18 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787721A2C20;
	Fri, 17 May 2024 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715982917; cv=none; b=rDZE5guawPceodxC4hqneS0J4DrSNG3inZ3wsO0REfhcIK1jviaaoJ0rTSsScVxe8s7c0VSvX+Gu1kjlW0p/lAygcG23aP3zwICXfllsc4Vab4x643rw7rku5S7wMVKnyiPKonZh0NvMMgpLDgs4XyN3izadeDuaGvu6pW3zFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715982917; c=relaxed/simple;
	bh=sJ+GtFwuKBg7t9R/MxdBCOuh6fAmgDIhwKbiz2Mm6xo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BgRBl5//hRlF9s2EGtwwTS5vKaKvR0M6rnn8iatcVjZ/QnkqfRWIB+eXHJrhkMYLYsCmGRKGOhiDV6ffcIDNzkQ/wYzSeRHnZu5Wai1HTpH8WZNqNL7bXLuBmY5D1FgDoEVzJREIAo4kLPlTfCQrWB2nCXu2km/KQKKRtOBAiF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44H9GMA2002440;
	Fri, 17 May 2024 14:55:04 -0700
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y64f41yfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 14:55:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 17 May 2024 14:55:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 17 May 2024 14:55:03 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 1CB523F706F;
	Fri, 17 May 2024 14:55:03 -0700 (PDT)
From: Vasyl Gomonovych <gomonovych@gmail.com>
To: <Yazen.Ghannam@amd.com>, <tony.luck@intel.com>
CC: Vasyl Gomonovych <gomonovych@gmail.com>, Borislav Petkov <bp@alien8.de>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] RAS: Add missing newlines to pr_info
Date: Fri, 17 May 2024 14:54:37 -0700
Message-ID: <20240517215452.2020680-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KbOv8qa4a5-PuEAHhx8t1J7yho_7nPmT
X-Proofpoint-ORIG-GUID: KbOv8qa4a5-PuEAHhx8t1J7yho_7nPmT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_10,2024-05-17_03,2023-05-22_02

Fix RAS log statement by adding missing newline character

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/ras/amd/atl/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 6dc4e06305f7..f9f760d780c4 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -206,7 +206,7 @@ static int __init amd_atl_init(void)
 	__module_get(THIS_MODULE);
 	amd_atl_register_decoder(convert_umc_mca_addr_to_sys_addr);
 
-	pr_info("AMD Address Translation Library initialized");
+	pr_info("AMD Address Translation Library initialized\n");
 	return 0;
 }
 
-- 
2.43.0


