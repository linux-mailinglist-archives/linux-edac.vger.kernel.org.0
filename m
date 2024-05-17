Return-Path: <linux-edac+bounces-1073-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7718C8D74
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2024 22:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DD61C21328
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2024 20:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674333C489;
	Fri, 17 May 2024 20:50:26 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410014F61;
	Fri, 17 May 2024 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715979026; cv=none; b=XAe57yXcz1rkyWlQF8NNATtA0RjZsE1Np4uinsjdBxfPTj6AhcKD1K+IJQMF60zjL7+i6wYuxI2nYQnpnzaM+H2POpjUK051DSOy6N3XrORRfbDFdWxMuvsdymYeqe31vzBjpAuLXyL/zG8bipjikSyo3x4iXzzMRYTGsV6PTDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715979026; c=relaxed/simple;
	bh=xlTIHBFr5nT6Pr9fHBFj+p3Br3FxDKrwi0G8RjXGnSo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U4jiBx53TDGso+tHvmucP29No0ipo54/ihUx3edklzndtdoUO8MHXxKdJqGdNXZAnUJPuVCBQT/qJ9+vII56pW/zT3ur5AX2lEH+uvzfRflqP54WLtpa+AVbBQncoGYVuivBuNAr+AgLOBk1I953nF6m9sfzn7tmqbHmJrkU9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44HICFoe011460;
	Fri, 17 May 2024 13:50:03 -0700
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y579bf0n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 13:50:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 17 May 2024 13:50:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 17 May 2024 13:50:02 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 6B4703F70A0;
	Fri, 17 May 2024 13:50:02 -0700 (PDT)
From: Vasyl Gomonovych <gomonovych@gmail.com>
To: <mchehab@kernel.org>, <bp@alien8.de>, <james.morse@arm.com>,
        <rric@kernel.org>, <vgomonovych@marvell.com>
CC: Vasyl Gomonovych <gomonovych@gmail.com>, Tony Luck <tony.luck@intel.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC/ghes: Add missing newlines to log statements
Date: Fri, 17 May 2024 13:48:46 -0700
Message-ID: <20240517204951.2019031-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JyIDAnVUgsnqmynC8w_Zd5KmOpDWvTiK
X-Proofpoint-ORIG-GUID: JyIDAnVUgsnqmynC8w_Zd5KmOpDWvTiK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_09,2024-05-17_03,2023-05-22_02

Ensure consistency in log output by
adding missing newlines to two GHES log statements.

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/edac/ghes_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index cf2b618c1ada..1eb0136c6fbd 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -547,7 +547,7 @@ static int __init ghes_edac_init(void)
 		return -ENODEV;
 
 	if (list_empty(ghes_devs)) {
-		pr_info("GHES probing device list is empty");
+		pr_info("GHES probing device list is empty\n");
 		return -ENODEV;
 	}
 
-- 
2.43.0


