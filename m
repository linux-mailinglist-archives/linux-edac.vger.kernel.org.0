Return-Path: <linux-edac+bounces-4031-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8ADAC7608
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 05:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062C4A40216
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15073244682;
	Thu, 29 May 2025 03:00:50 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9A21CC5D
	for <linux-edac@vger.kernel.org>; Thu, 29 May 2025 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748487650; cv=none; b=YoIyF4wI5zX/Tt0IiCW1JgLSl+9wo9ZqfYT3T3NAiToEUynbphSSv64rYGe7tIMroZ7JUx9C/dxjYyvJpSeamajzDX8aA6WCMAStcSXte4QKhP5Gn1FfAtFMTb8RZtPygk4DqcpG1CQTXcRpzPn1HXmkB02cOLA3sD3sbA7vaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748487650; c=relaxed/simple;
	bh=rclhPDUn7MDNLqW8a23+tVHQVVXPu4/tWnIqdKIKffs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jbT+LmNypNSXB72rV+PM5764IJqlfniUnMwxkbICej60vsW1gxv7ed5fLbj8Pv2VPzmDjCgXqIugvbtTNWIPT4ITAr0ZTZYkV1hvhsMpQUtGxuKh7cRQhelIZIkXEGATPaHdBCNVZ+pYYvSOnr+nw800FtgrSpft0goEyN6HhlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4b7B0F16MCzvPsb;
	Thu, 29 May 2025 10:58:53 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 70D2E180B6C;
	Thu, 29 May 2025 11:00:38 +0800 (CST)
Received: from kwepemq500009.china.huawei.com (7.202.195.53) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 May 2025 11:00:38 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 kwepemq500009.china.huawei.com (7.202.195.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 May 2025 11:00:37 +0800
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
To: <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <linux-edac@vger.kernel.org>, <wanghai38@huawei.com>,
	<bobo.shaobowang@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH] x86/mce/inject: Add sanity check in inject_mce()
Date: Thu, 29 May 2025 11:32:56 +0800
Message-ID: <20250529033256.31554-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500009.china.huawei.com (7.202.195.53)

syzbot reported the following kernel panic:

[  306.335489][ T3298] mce: CPUs not responding to MCE broadcast (may include false positives): 1-3
[  306.336332][ T3298] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
[  306.337786][ T3298] Kernel Offset: 0x17400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

The syzkaller test didn't set 'MCJ_IRQ_BROADCAST | MCJ_NMI_BROADCAST' in
'inject_flags', so the MCE will only be injected to the local CPU. But
'MCG_STATUS_LMCES' is not set in 'mcgstatus', so the local CPU will wait
others CPUs to enter MCE in mce_start(). But other CPUs were not
injected, so the above panic happened. We add sanity check in
inject_mce() to fix this issue.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 06e3cf7229ce..4af98f0e191e 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -127,6 +127,13 @@ static void inject_mce(struct mce *m)
 {
 	struct mce *i = &per_cpu(injectm, m->extcpu);
 
+	/* do some sanity checks */
+	if (!(m->inject_flags & (MCJ_IRQ_BROADCAST | MCJ_NMI_BROADCAST))) {
+		if (m->cpuvendor == X86_VENDOR_INTEL ||
+		    m->cpuvendor == X86_VENDOR_ZHAOXIN)
+			m->mcgstatus |= MCG_STATUS_LMCES;
+	}
+
 	/* Make sure no one reads partially written injectm */
 	i->finished = 0;
 	mb();
-- 
2.20.1


