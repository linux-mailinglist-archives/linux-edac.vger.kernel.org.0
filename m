Return-Path: <linux-edac+bounces-588-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC9D85618C
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 12:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD921F29549
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8E12B144;
	Thu, 15 Feb 2024 11:28:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B4128837
	for <linux-edac@vger.kernel.org>; Thu, 15 Feb 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996516; cv=none; b=W4EzO152CB49rj0vH1d6N1b55pjEpE+FrLrhb+qzjX16jxmaJtb7+h4MKdfY/RYySBr4MJ2Xm431G9EfVJtV0ZH+Cic6+NIucCuK1n7WSTlAUnhVcwe9yZgNFTTLCrc2FprUfz5C0yhjNrDvmIcLxk+5X1aGJgZxwYJ+8Urmyhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996516; c=relaxed/simple;
	bh=zRjOSWfrOF67zKLw16hITWkRmhVmpZZgHbehbksIzRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lkh0K0a/o0PXvRCrrSwhDV/ERyYWhhaFGLHfllXGLXBZ6zDpV1j8qn3vDOFX+95pMz5NaqLhCOiEmkOLfY8TK04qUKGCyNKrdk59oSlonOUjpogWea17FAAm1cSRqRQOHxcWoH6Y+JUHjqGUmnlrVQODxgQlviq5xbTMBpohfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCQ360Gtz67mZc;
	Thu, 15 Feb 2024 19:24:27 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DA291400CD;
	Thu, 15 Feb 2024 19:28:30 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:28:29 +0000
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 1/1] rasdaemon: ras-memory-failure-handler: update memory failure action page types
Date: Thu, 15 Feb 2024 19:28:00 +0800
Message-ID: <20240215112800.1483-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Update memory failure action page types corresponding to the same in
mm/memory-failure.c in the kernel.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-memory-failure-handler.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/ras-memory-failure-handler.c b/ras-memory-failure-handler.c
index 97e8840..a5acc08 100644
--- a/ras-memory-failure-handler.c
+++ b/ras-memory-failure-handler.c
@@ -26,10 +26,8 @@ enum mf_action_page_type {
 	MF_MSG_KERNEL_HIGH_ORDER,
 	MF_MSG_SLAB,
 	MF_MSG_DIFFERENT_COMPOUND,
-	MF_MSG_POISONED_HUGE,
 	MF_MSG_HUGE,
 	MF_MSG_FREE_HUGE,
-	MF_MSG_NON_PMD_HUGE,
 	MF_MSG_UNMAP_FAILED,
 	MF_MSG_DIRTY_SWAPCACHE,
 	MF_MSG_CLEAN_SWAPCACHE,
@@ -41,7 +39,6 @@ enum mf_action_page_type {
 	MF_MSG_CLEAN_LRU,
 	MF_MSG_TRUNCATED_LRU,
 	MF_MSG_BUDDY,
-	MF_MSG_BUDDY_2ND,
 	MF_MSG_DAX,
 	MF_MSG_UNSPLIT_THP,
 	MF_MSG_UNKNOWN,
@@ -64,10 +61,8 @@ static const struct {
 	{ MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page"},
 	{ MF_MSG_SLAB, "kernel slab page"},
 	{ MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking"},
-	{ MF_MSG_POISONED_HUGE, "huge page already hardware poisoned"},
 	{ MF_MSG_HUGE, "huge page"},
 	{ MF_MSG_FREE_HUGE, "free huge page"},
-	{ MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page"},
 	{ MF_MSG_UNMAP_FAILED, "unmapping failed page"},
 	{ MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page"},
 	{ MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page"},
@@ -79,7 +74,6 @@ static const struct {
 	{ MF_MSG_CLEAN_LRU, "clean LRU page"},
 	{ MF_MSG_TRUNCATED_LRU, "already truncated LRU page"},
 	{ MF_MSG_BUDDY, "free buddy page"},
-	{ MF_MSG_BUDDY_2ND, "free buddy page (2nd try)"},
 	{ MF_MSG_DAX, "dax page"},
 	{ MF_MSG_UNSPLIT_THP, "unsplit thp"},
 	{ MF_MSG_UNKNOWN, "unknown page"},
-- 
2.34.1


