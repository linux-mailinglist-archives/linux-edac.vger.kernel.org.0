Return-Path: <linux-edac+bounces-3012-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3451AA3032B
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 07:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C767A1252
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 06:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6EB1E3DD3;
	Tue, 11 Feb 2025 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sPAB7Qcp"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360E26BD98;
	Tue, 11 Feb 2025 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253731; cv=none; b=lMMS4+Ja9GPeICUsMOh90UrYdAGKlhHxcONwBd/ZSwU9b1T77oVArf9/nOvsu3R3WuCCdS3VP1bWiXZ5SKoDXTn3SptCR+N7adz1dksfexvWKOKLqT8izs1MQaf/PwUPcEOq25LUNND+UKlKqnfbysSLVKNQ3kNX91AFpPrFBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253731; c=relaxed/simple;
	bh=9TlBQFKfgo8qm9vvVdscR3v2j2Y9oifJALzQb7jwKBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhYvSUDc7nD6sfKivz4yF+rg2vrSIDE9yUB03Ty1+UDOMXLS3f/GV/XzJ0GIpEKXH3fr9l0jPA7qUjne1M9wWefWG+zTAaX/skOuUngQ+Lg2fIgYioUVBbla1lX5M/MRGJlMlbSDxxoq4C9OW2xPw5l1pXQmhzaqJz0roWyLA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sPAB7Qcp; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739253726; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tlo8q8j4Pp6YSO9Kcn8UqITwpqL/bxjMQZvrf+MMEtk=;
	b=sPAB7QcpRbwxVaM08+jD4tRIeDfIyOhBCHLXsmCt4x9+58IR5Gb4iEUWOmjlJ6RM1HhRrZ0P7p5QoiUaFqELWljdnO6ISDJGYB4V28EH85rBz+iRVFDdTyB6SUsWOP2yf9mQpz+Oz5w2YTWyUstXmTrVENpZhRAoL4MEfWO1qXI=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPFiSI3_1739253723 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Feb 2025 14:02:04 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: tony.luck@intel.com,
	bp@alien8.de,
	nao.horiguchi@gmail.com
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linmiaohe@huawei.com,
	akpm@linux-foundation.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v1 2/4] x86/mce: dump error msg from severities
Date: Tue, 11 Feb 2025 14:01:58 +0800
Message-ID: <20250211060200.33845-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
References: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The message in severities is useful for identifying the type of MCE that
has occurred; dump it if it is valid.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/x86/kernel/cpu/mce/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2919a077cd66..c1319db45b0a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1456,6 +1456,8 @@ static void queue_task_work(struct mce_hw_err *err, char *msg, void (*func)(stru
 	if (count > 1)
 		return;
 
+	if (msg)
+		pr_err("%s\n", msg);
 	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
 }
 
-- 
2.39.3


