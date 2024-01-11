Return-Path: <linux-edac+bounces-337-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D413982B010
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jan 2024 14:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 747CEB25083
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jan 2024 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3085F3DBB3;
	Thu, 11 Jan 2024 13:56:08 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57F3B193;
	Thu, 11 Jan 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T9mQG1wmdz1xm4K;
	Thu, 11 Jan 2024 21:55:18 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id C42D41800B7;
	Thu, 11 Jan 2024 21:55:56 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 21:55:55 +0800
From: Tong Tiangen <tongtiangen@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <wangkefeng.wang@huawei.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-mm@kvack.org>, Tong Tiangen <tongtiangen@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
Subject: [PATCH -next v4 0/3] minor improvements for x86 mce processing
Date: Thu, 11 Jan 2024 21:55:45 +0800
Message-ID: <20240111135548.3207437-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)

In this patchset, we remove the unused macro EX_TYPE_COPY and centralize
the processing of memory-failure to do_machine_check() to avoid calling
memory_failure_queue() separately for different MC-Safe scenarios. In
addition, MCE_IN_KERNEL_COPYIN is renamed MCE_IN_KERNEL_COPY_MC to expand
its usage scope.

[1]https://lore.kernel.org/linux-mm/20230526063242.133656-1-wangkefeng.wang@huawei.com/

since v3:
  1. Rebased on linux-next tag next-20240111.
  2. Delete duplicate commit references on patch 3.

since v2:
  1. remove redundant fixup type EX_TYPE_COPY.
  2. rename MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC.
  3. update patch3's commit message and the processing logic of
     EX_TYPE_DEFAULT_MCE_SAFE based on the discussion of [1].

Kefeng Wang (1):
  x86/mce: set MCE_IN_KERNEL_COPY_MC for DEFAULT_MCE_SAFE exception

Tong Tiangen (2):
  x86/mce: remove redundant fixup type EX_TYPE_COPY
  x86/mce: rename MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC

 arch/x86/include/asm/asm.h                 |  3 ---
 arch/x86/include/asm/extable_fixup_types.h | 23 +++++++++++-----------
 arch/x86/include/asm/mce.h                 |  8 ++++----
 arch/x86/kernel/cpu/mce/core.c             |  2 +-
 arch/x86/kernel/cpu/mce/severity.c         |  7 +++----
 arch/x86/mm/extable.c                      |  9 ---------
 mm/ksm.c                                   |  1 -
 mm/memory.c                                | 13 ++++--------
 8 files changed, 23 insertions(+), 43 deletions(-)

-- 
2.25.1


