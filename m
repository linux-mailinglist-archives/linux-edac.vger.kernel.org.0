Return-Path: <linux-edac+bounces-1199-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACEE8FDECE
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FCD1C21623
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96A912B17C;
	Thu,  6 Jun 2024 06:36:28 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB319D8A1;
	Thu,  6 Jun 2024 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655788; cv=none; b=hWpnWDr3lNJvh9r9Rj+AcDuhRuGi3Cp/9e5ttEtHNfrjLkdVCOgcPnmXLryQJikrrKPobzS2lus0dwdUrFsdxptZ0WFoRoQg9E9qb/tsnftNaJA+zE5QK/O4P1vFcY0RowZdY9Rk9ZKDXpUGBswKXxSghjKbP2TY/J4QKTfVC5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655788; c=relaxed/simple;
	bh=9FG1gH4uPg3/DS2R1IgYkBWH90lxrrUq2tdAtmnDaj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7wpHmlXaXA0kcW1ORtKGexO4kJ/lIg01I4scqM/wOOqduQxf2tAw3KMsinc4xBq4BHUkQIcYamgMZ4QGuC77D1BgEi/Wx8F3ZxGI3LJLykUEVx8U5BKLk+GBupzVWmMaNYnguKZXNYrXlFGEyf0XlHXKzEhyr64+eeSd5yctSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VvvdP6DTdzwRt3;
	Thu,  6 Jun 2024 14:32:25 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 9756218007A;
	Thu,  6 Jun 2024 14:36:23 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:23 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 02/13] mm/memory-failure: remove MF_MSG_SLAB
Date: Thu, 6 Jun 2024 14:32:36 +0800
Message-ID: <20240606063247.712575-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240606063247.712575-1-linmiaohe@huawei.com>
References: <20240606063247.712575-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
index 04795a509026..ec7141fb0252 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4078,7 +4078,6 @@ enum mf_result {
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


