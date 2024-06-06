Return-Path: <linux-edac+bounces-1209-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0578FDEE2
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9528528AFE2
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6576E13F003;
	Thu,  6 Jun 2024 06:36:33 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316D13DDCD;
	Thu,  6 Jun 2024 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655793; cv=none; b=octbumbjE9opeHt5AFjA1Mk5X/dHCz2HsltxKSHRYid7gvYo0bo6jSRxkkC36+pUyC6YRPHGscY1mpxBwkuGkJcHUfryFyZt7aCVIwvrFUlT1rC9SOmN3tFEgxX3d1YOr8NvnNEtCF06mPYl/XbnIIObPLaC9jA3TY/o/Pi4JUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655793; c=relaxed/simple;
	bh=9PoCntt3SW0Oa9RezGMsjClVz37Yg87KhMqQaOh+e2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhFMPSZrA3lt0ujHXHoZZ26ZkRkGx0fShe2CbekEj7eWQdcjEAHo/T7GV6wK5UmC3gAPuhwIdGJrXdfdN+e/tGqxIPjJOP8vEJ7eQ7eB/ZMnFP9nnog28TeztuXfx/gx4a5C5EIvUhUvgFmaRWNPpwOKrTJKDBI556e7np9bK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VvvhX1wr5z1xsGB;
	Thu,  6 Jun 2024 14:35:08 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id CAAE21A016C;
	Thu,  6 Jun 2024 14:36:28 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:28 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 12/13] mm/memory-failure: remove obsolete comment in kill_proc()
Date: Thu, 6 Jun 2024 14:32:46 +0800
Message-ID: <20240606063247.712575-13-linmiaohe@huawei.com>
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

When user sets SIGBUS to SIG_IGN, it won't cause loop now. For action
required mce error, SIGBUS cannot be blocked. Also when a hwpoisoned
page is re-accessed, kill_accessing_process() will be called to kill
the process.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0d37f20968e6..161bdc79b44c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -354,8 +354,6 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 		 * PF_MCE_EARLY set.
 		 * Don't use force here, it's convenient if the signal
 		 * can be temporarily blocked.
-		 * This could cause a loop when the user sets SIGBUS
-		 * to SIG_IGN, but hopefully no one will do that?
 		 */
 		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
 				      addr_lsb, t);
-- 
2.33.0


