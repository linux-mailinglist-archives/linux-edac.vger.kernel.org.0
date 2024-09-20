Return-Path: <linux-edac+bounces-1895-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665A497D08D
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 06:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09D41C22D5F
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 04:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEE1225D9;
	Fri, 20 Sep 2024 04:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mMBvpZ9F"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B3125A9;
	Fri, 20 Sep 2024 04:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726806650; cv=none; b=bw3MKJYGFFe40hwFHbXxm1ABIYy74wvHY6z7TYwY/7SsUXb4YwJdrThC7m0CqBqz9tUt0kOQY1Xqu5j7b73Y+irOqMqBmlPtv/WKcsvk0LqlNTMep1FA1HaxRN5tl1zBGLfzzjgfPF5FbAjQC3O56qqXZuFP9caHcfCHxmMlPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726806650; c=relaxed/simple;
	bh=U1dcDKyBWkE7fnPx8mVLa/JSgNKQbkF5fmA7WejDhC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+SvK6Apt7MrCmPsjvevNuQ7OMBvsA24ZiSynxPeJ3Q0Ls18mZk4lMEA62AZG66akmCXfIw7x1+hst1OdhNzW0wiwIa5sOi5tb7dIakaIu5nGM/DW91Jmf+UUF6izrJNpOhoEfC1YdlG2qgASxhw306TWlqXk6sRir5lri6VNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mMBvpZ9F; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726806644; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dFoBE4+/zB3lnbneu+kgWUeKvl7Lb5hy3AUk2WpE210=;
	b=mMBvpZ9FVsFWzd/NpX5HKMyNPCZ7DmlrbAmSuVvk+jRc+A3GqS7zkEAuzX4xoF1KET+vZedqt8O5k9RMKRqswSMCoJyBqHg0+9ZdLa/k49/uWl4ON9HXgb42kHhM+TINgHVFc49VfZKQ7ISAALl6IqggbN03vF+IIGcAw4iya/g=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WFJd0Il_1726806640)
          by smtp.aliyun-inc.com;
          Fri, 20 Sep 2024 12:30:42 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: mark.rutland@arm.com,
	catalin.marinas@arm.com,
	mingo@redhat.com,
	robin.murphy@arm.com,
	Jonathan.Cameron@Huawei.com,
	bp@alien8.de,
	rafael@kernel.org,
	wangkefeng.wang@huawei.com,
	tanxiaofei@huawei.com,
	mawupeng1@huawei.com,
	tony.luck@intel.com,
	linmiaohe@huawei.com,
	naoya.horiguchi@nec.com,
	james.morse@arm.com,
	tongtiangen@huawei.com,
	gregkh@linuxfoundation.org,
	will@kernel.org,
	jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-edac@vger.kernel.org,
	x86@kernel.org,
	xueshuai@linux.alibaba.com,
	justin.he@arm.com,
	ardb@kernel.org,
	ying.huang@intel.com,
	ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	lenb@kernel.org,
	hpa@zytor.com,
	robert.moore@intel.com,
	lvying6@huawei.com,
	xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: [PATCH v13 1/3] ACPI: APEI: send SIGBUS to current task if synchronous memory error not recovered
Date: Fri, 20 Sep 2024 12:30:25 +0800
Message-ID: <20240920043027.21907-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Synchronous error was detected as a result of user-space process accessing
a 2-bit uncorrected error. The CPU will take a synchronous error exception
such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
memory_failure() work which poisons the related page, unmaps the page, and
then sends a SIGBUS to the process, so that a system wide panic can be
avoided.

However, no memory_failure() work will be queued when abnormal synchronous
errors occur. These errors can include situations such as invalid PA,
unexpected severity, no memory failure config support, invalid GUID
section, etc. In such case, the user-space process will trigger SEA again.
This loop can potentially exceed the platform firmware threshold or even
trigger a kernel hard lockup, leading to a system reboot.

Fix it by performing a force kill if no memory_failure() work is queued
for synchronous errors.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 623cc0cb4a65..93eb11482832 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -801,6 +801,16 @@ static bool ghes_do_proc(struct ghes *ghes,
 		}
 	}
 
+	/*
+	 * If no memory failure work is queued for abnormal synchronous
+	 * errors, do a force kill.
+	 */
+	if (sync && !queued) {
+		pr_err("%s:%d: hardware memory corruption (SIGBUS)\n",
+			current->comm, task_pid_nr(current));
+		force_sig(SIGBUS);
+	}
+
 	return queued;
 }
 
-- 
2.39.3


