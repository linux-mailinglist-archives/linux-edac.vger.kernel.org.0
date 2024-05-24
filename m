Return-Path: <linux-edac+bounces-1109-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C20C8CE31C
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E180B20993
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209DA84A40;
	Fri, 24 May 2024 09:16:33 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9329422;
	Fri, 24 May 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542193; cv=none; b=sDTS2ufG2yBj1Nd7DTfQZ40jVTW7hnury0ctj+AeZHK7JNpIVNvsCZrCIKvRyYddCEY03iYC+mJlMqMlBd03x37zIaxjgF/6grRd9x3bgZBAZ08RxFBseBuuw8beOXepe5RUqnzebUEdAkBp9KSrIIcWFVkOluWYrwy7tZ5evZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542193; c=relaxed/simple;
	bh=rwEZ739gHGTO1YqKPyBHYk4+sVARrxvb5W+BR02A2i4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJzJi7T6AT5CVNWIbAE7W0QJkBbz6NNCckRmWefu9ivDfxiCndPMaJP/UhmXWo7rZg/BEOvoif9kwFBRIoR9F5YOyCAyxdl8wMkF1hKE+QepL3j5nKP4UNHUGYcBZqd1wI1+PKw3BYM0uMJv0t9ac33JdOPz2d2C1qOxO8nBKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Vlzs84TXDzcj6g;
	Fri, 24 May 2024 17:15:08 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 2275F180A9C;
	Fri, 24 May 2024 17:16:27 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:26 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 02/13] mm/memory-failure: remove MF_MSG_SLAB
Date: Fri, 24 May 2024 17:12:59 +0800
Message-ID: <20240524091310.1430048-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240524091310.1430048-1-linmiaohe@huawei.com>
References: <20240524091310.1430048-1-linmiaohe@huawei.com>
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
index 3aa1b6889bcc..4bc97ae25ade 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4099,7 +4099,6 @@ enum mf_result {
 enum mf_action_page_type {
 	MF_MSG_KERNEL,
 	MF_MSG_KERNEL_HIGH_ORDER,
-	MF_MSG_SLAB,
 	MF_MSG_DIFFERENT_COMPOUND,
 	MF_MSG_HUGE,
 	MF_MSG_FREE_HUGE,
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index b3f6832a94fe..3fe77ba2cdd5 100644
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
index 922c902a7229..9c23adceee75 100644
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


