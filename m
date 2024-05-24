Return-Path: <linux-edac+bounces-1118-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092418CE330
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5E91F22D88
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC2C8664A;
	Fri, 24 May 2024 09:16:39 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F085937;
	Fri, 24 May 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542199; cv=none; b=IgUN3TP2tIamphJw5gUTO5uyWLWiZYbA8VmgLxqf1BCfotFqYyheqdfLwZNFt6cOPbIrNz2FuEmEwj4dUFGPA0QWgUqid7EktQQxyhM06BV/xnrNofe0gZYL3XQJ/1xEvD1Cd+dm2nYt9jzvkMeS/AIJyloeVRC/OE9KFbCj2ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542199; c=relaxed/simple;
	bh=4ORM+LTuiEk3sa/gaLB3Wh9ziHCUed4N+GPGWhqSDrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+6zdSe0mxHwRMR9n76uqiBtN7JW90PkavFjSDwB80Q0wS7xCcSUrWaE/EhFabZBZX20Ahn92XFZg1carA3Fd36NfEwOAuNWvitbE7CRfagWcC+S4jibwtvQ7efl7Rqc9E+RTX4CfJ1z3I9RDsFns0eHUyUORWHRfQ/hFoWapKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Vlzq82b8VzPkVR;
	Fri, 24 May 2024 17:13:24 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C739180A9C;
	Fri, 24 May 2024 17:16:28 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:28 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 05/13] mm/memory-failure: remove unneeded empty string
Date: Fri, 24 May 2024 17:13:02 +0800
Message-ID: <20240524091310.1430048-6-linmiaohe@huawei.com>
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

Remove unneeded empty string in definition of macro pr_fmt. No functional
change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 73878ecdec22..c09e1bf83682 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2549,7 +2549,7 @@ static int __init memory_failure_init(void)
 core_initcall(memory_failure_init);
 
 #undef pr_fmt
-#define pr_fmt(fmt)	"" fmt
+#define pr_fmt(fmt)	fmt
 #define unpoison_pr_info(fmt, pfn, rs)			\
 ({							\
 	if (__ratelimit(rs))				\
-- 
2.33.0


