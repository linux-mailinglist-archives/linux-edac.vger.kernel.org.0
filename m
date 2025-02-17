Return-Path: <linux-edac+bounces-3099-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D4BA37B6F
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 07:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69287A2087
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 06:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01C190482;
	Mon, 17 Feb 2025 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L9pVeS6U"
X-Original-To: linux-edac@vger.kernel.org
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E0190055;
	Mon, 17 Feb 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774040; cv=none; b=AIJhIrbZhjYOQijEqFG1ZuHhFppmOGdOwSpT27Qk3xu/TSUmMFRFvVr+zRF7KQVHlq/CzEL+qFJlVs70Ypl6f5ezahxtbVfarVMBPWKSzAx8jfzAEsvaxyOeuRbuiM4h9fzSdhGG3PjVownN5SrqPmCZFGpziM4Rb/5Drf9GpQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774040; c=relaxed/simple;
	bh=kdu/4bLC3UQrdhqz+ozlX4h5tv4w8WukwNTq+M/36mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B4D0FDPN/JAcZ+bGgqTO/wYVBTTx8EW/QEhkpZUbET8phTUso5CgR8Ly7BwAErIMrmIsHjQgJAzJXPMeeCZRq5FzPvyYCxtwSFA5SOSkSXqGX6FM0//C97aHc8Qt90a5v6MYtaYpkdNpemzSFUIArGBqoQisAh66q/u8s/OfyIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L9pVeS6U; arc=none smtp.client-ip=47.90.199.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739774019; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=L0A7nBKDZctlChxPK/eFP1Sa0tw/MzJN7M2cddhGNjI=;
	b=L9pVeS6UXH3C9YU8vzZkj685OZ4XZqd3TSZcGXIZ5MrGyviD+DNHDZX9Jt7vtvosjTPMd1ETHyv1YF9f5ln5dqYk69mmplsx7BVBzcvh3JwxpEOB8OdGkNS88wMyolW+U4wK0cUTi0K9BXj6MOsdEp6R15HKX3BGluQ3jVHUSPs=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPb1mNR_1739774015 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 14:33:37 +0800
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
	peterz@infradead.org,
	jpoimboe@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure handling
Date: Mon, 17 Feb 2025 14:33:30 +0800
Message-ID: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes singce v1:
- Patch 1: Fix cur_sev and sev type to `int` per Tony
- Patch 4: Fix return value to 0 for clean pages per Miaohe
- Patch 5: pick return value comments of memory-failure()

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

Shuai Xue (5):
  x86/mce: Collect error message for severities below MCE_PANIC_SEVERITY
  x86/mce: dump error msg from severities
  x86/mce: add EX_TYPE_EFAULT_REG as in-kernel recovery context to fix
    copy-from-user operations regression
  mm/hwpoison: Fix incorrect "not recovered" report for recovered clean
    pages
  mm: memory-failure: move return value documentation to function
    declaration

 arch/x86/kernel/cpu/mce/core.c     | 26 +++++++++++++-------------
 arch/x86/kernel/cpu/mce/severity.c | 21 ++++++++++++++++-----
 mm/memory-failure.c                | 21 +++++++++++++++------
 3 files changed, 44 insertions(+), 24 deletions(-)

-- 
2.39.3


