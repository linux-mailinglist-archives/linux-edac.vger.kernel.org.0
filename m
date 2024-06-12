Return-Path: <linux-edac+bounces-1254-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC91B904C97
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 09:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592D81F243BE
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 07:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D5016C436;
	Wed, 12 Jun 2024 07:22:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898447D412;
	Wed, 12 Jun 2024 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176945; cv=none; b=eCPkS1BQxlDRzD2znMHx3UHQjLQB3LyldZmJZPshm54EKH7URs4v26fN/gXItXAb7VUGeNDWhoQWWn/sc5nmyCx69GTdYCRxxNohwpzr4us9N48r4ETZslOJoKQ16MYLXsKwmldZzEpn61Xz0CgH3atNN9TEjRiSrW624vLJ5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176945; c=relaxed/simple;
	bh=lNTgL9bIM0ya5dGayqFCcn/qYeuQFOLkZ9SHTvr4cGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVhAPFtE8gdTFXzjJt0iPLm+WdPfPFxeSVqDIWNz7ZYVhixKuF29ruuhNlZxuBQZmhF1F2ZDvsbGYOfzLqhONZTD7+s++VRlkxl5LspFzgNQRyH3NHAvscISozhGSvd7DW3bSLLfOCtV585aetZoAbCO3I5971Uo6G8pWhRYEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VzcQ1401Fz1HDJm;
	Wed, 12 Jun 2024 15:20:25 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F53C180065;
	Wed, 12 Jun 2024 15:22:20 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 15:22:19 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v3 02/13] mm/memory-failure: remove MF_MSG_SLAB
Date: Wed, 12 Jun 2024 15:18:24 +0800
Message-ID: <20240612071835.157004-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240612071835.157004-1-linmiaohe@huawei.com>
References: <20240612071835.157004-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

Since commit 46df8e73a4a3 ("mm: free up PG_slab"), MF_MSG_SLAB becomes
unused. Remove it. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/mm.h      | 1 -
 include/ras/ras_event.h | 1 -
 mm/memory-failure.c     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 25b541974134..0bf0f22b32c8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4048,7 +4048,6 @@ enum mf_result {
 enum mf_action_page_type {
 	MF_MSG_KERNEL,
 	MF_MSG_KERNEL_HIGH_ORDER,
-	MF_MSG_SLAB,
 	MF_MSG_DIFFERENT_COMPOUND,
 	MF_MSG_HUGE,
 	MF_MSG_FREE_HUGE,
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index cf7f19b7ce64..9bc707fe8819 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -356,7 +356,6 @@ TRACE_EVENT(aer_event,
 #define MF_PAGE_TYPE		\
 	EM ( MF_MSG_KERNEL, "reserved kernel page" )			\
 	EM ( MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page" )	\
-	EM ( MF_MSG_SLAB, "kernel slab page" )				\
 	EM ( MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking" ) \
 	EM ( MF_MSG_HUGE, "huge page" )					\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2e6038c73119..4b9a9298d478 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -911,7 +911,6 @@ static const char *action_name[] = {
 static const char * const action_page_types[] = {
 	[MF_MSG_KERNEL]			= "reserved kernel page",
 	[MF_MSG_KERNEL_HIGH_ORDER]	= "high-order kernel page",
-	[MF_MSG_SLAB]			= "kernel slab page",
 	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
-- 
2.33.0


