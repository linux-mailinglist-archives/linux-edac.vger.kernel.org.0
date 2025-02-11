Return-Path: <linux-edac+bounces-3014-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765ACA3032D
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 07:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66993A7597
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 06:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AF31E9B03;
	Tue, 11 Feb 2025 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aUWibNCV"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5391E5B87;
	Tue, 11 Feb 2025 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253734; cv=none; b=n8m6z2w6C2e/AuVfFVQdO48i6z6d8qiCjSPbIc553YKEZC0vyGehzO+XA9ZmlyYN2w36ddUqLMKuKrdcQu9zRbLtRuUFJ7UAiHm6xptuh7mZmrF6g0kOyKZJe2A90Gth9FKGrIzaNqBN0ZJ+qhhLNPN8sFP2VK9opzDQf63YaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253734; c=relaxed/simple;
	bh=m9tJe05NWad9zWzoKlpEUgZsTJGCSwZkoTLQsSwq4fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2pEAqrwlukNY3Tli1uV+LwXDOKagOnTzeJwJIf8Hgr5I60dn7KgkhgWzPn/5AsJWmsVDOhHsJNtMCkR2QolvkbmsJCSyRsW26c7gcxOGlSLyVLZ0YzVlwZWdyDbRTQvjpIEcZRmWFVBnxHWVNviPjAaGQxkOp9PPgk1gI+1qXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aUWibNCV; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739253724; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jiGp5PhnCpH/e44Wh/mkAafmjAyKfVlWuH9hcSORWag=;
	b=aUWibNCVIsSUNNEWQ3H/EfrMYAo6rM7F+2BwVXeCURpeRFUx3nImh+a9wG7yvS5jeb9btjc/xNvODyGPWTYZo4GyH/Bufqs9p1lDzxYw495G2QODjud0N4UCRBUKE4k/KKZTpEVO/YWznu9SCU6//+AYds1y5NrpG6x3AXqCniI=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPFiSHJ_1739253721 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Feb 2025 14:02:02 +0800
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
Subject: [PATCH v1 0/4] fmm/hwpoison: Fix regressions in memory failure handling
Date: Tue, 11 Feb 2025 14:01:56 +0800
Message-ID: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses three regressions identified in memory failure
handling, as discovered using ras-tools[1]:

- `./einj_mem_uc copyin -f`
- `./einj_mem_uc futex -f`
- `./einj_mem_uc instr`

The regressions in the copyin and futex cases were caused by the
replacement of `EX_TYPE_UACCESS` with `EX_TYPE_EFAULT_REG` in some
copy-from-user operations, leading to kernel panics. The instr case
regression resulted from the PTE entry not being marked as hwpoison,
causing the system to send unnecessary SIGBUS signals.

These fixes ensure proper handling of memory errors and prevent kernel
panics and unnecessary signal dispatch.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/aegl/ras-tools.git

Shuai Xue (4):
  x86/mce: Collect error message for severities below MCE_PANIC_SEVERITY
  x86/mce: dump error msg from severities
  x86/mce: add EX_TYPE_EFAULT_REG as in-kernel recovery context to fix
    copy-from-user operations regression
  mm/hwpoison: Fix incorrect "not recovered" report for recovered clean
    pages

 arch/x86/kernel/cpu/mce/core.c     | 19 +++++++++++++------
 arch/x86/kernel/cpu/mce/severity.c | 21 ++++++++++++++++-----
 mm/memory-failure.c                |  5 ++---
 3 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.39.3


