Return-Path: <linux-edac+bounces-2313-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C65E9B29FE
	for <lists+linux-edac@lfdr.de>; Mon, 28 Oct 2024 09:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FC1B21A6B
	for <lists+linux-edac@lfdr.de>; Mon, 28 Oct 2024 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778F418FDA9;
	Mon, 28 Oct 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nNEQ3Eqq"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303718A6BC;
	Mon, 28 Oct 2024 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103123; cv=none; b=ktBQh1VRc5qTo3GbNsR1o4p7ZP1RKYtqCM0YyQCbGVmgPgpyTsdj0xcASvKapHyZW/3nIymN8L/6bsKEmXqrwmItY0aPEt7xwrMm+QDSmvsQXzk3L16g1QbZrFuIG8CfOtmQ7woxkdR6x9jfNcWsDliCcdnFn399JsMoG9FK8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103123; c=relaxed/simple;
	bh=+EUIPEc6brnnT+kXHmTPw5KWnP3M7i9iCuS/Z5OvfmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDPduWVi9qvGJ5MImwhHhqpMXTNn59yxOfpgfkQFJllzOx1K4aLgncWaG1h5IyFOvJSpB4XNciH/V2O5tKugUCH2vQlP0WCu6o4srsZI+YkEb3CRLNcWYom3vpA3vmxY+YUN1hI6xPNqVddmnkseVPhDK6ANrABFNTTFYEdUrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nNEQ3Eqq; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730103117; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8brKTW7uO02ZOn/x4lpZT/JYszcIfoEiVfeoh4hX2X0=;
	b=nNEQ3Eqq2X9g0SdSlinj3OWZlNZ7fj/YQuVMxh3j8R0X5GZVHEt1Y4qiDLbabDuTw9vveMaqtNs1ZXjdaJqRGGfBvxtn1AGy0AHSyzk18ztT4W4ty7cBpVZiZ1kAn1UTzA5tJsvGxSsFbG3NClhRHiER3nnKXP4cpl6Iq36Rm8c=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WI0hO4H_1730103114 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 16:11:55 +0800
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
Subject: [PATCH v15 1/3] ACPI: APEI: send SIGBUS to current task if synchronous memory error not recovered
Date: Mon, 28 Oct 2024 16:11:40 +0800
Message-ID: <20241028081142.66028-2-xueshuai@linux.alibaba.com>
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/apei/ghes.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ada93cfde9ba..f2ee28c44d7a 100644
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


