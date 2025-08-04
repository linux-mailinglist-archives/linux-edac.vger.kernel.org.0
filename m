Return-Path: <linux-edac+bounces-4506-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215AEB1975B
	for <lists+linux-edac@lfdr.de>; Mon,  4 Aug 2025 02:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF093A34F4
	for <lists+linux-edac@lfdr.de>; Mon,  4 Aug 2025 00:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29EB184540;
	Mon,  4 Aug 2025 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0ywWmuv"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DA117A310;
	Mon,  4 Aug 2025 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267205; cv=none; b=mDfIks344lL7WNbM0/nvRGRMu+qSVm7lXk0B77YcMaDHNrQUlgQQSe1X7GcSq6zj48YSCSSmQOm9VpdDMT9g4RXyvx3mv/XnLesbS9Fp0snNdE+YaI8N95IxQi4ebulo4QRBbkAp6DLjoIwXQVKM1B8o9L3zwjvDu97LS8rjsqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267205; c=relaxed/simple;
	bh=s2/rlHHWGgfkIJwDCOvKo4CQOlSCHBQ1/r4At5fcDvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EABxMZdIc888IHgqrGzH0OP/ghw3banWRGuO7zD+VCsWmCMHR/RhG0FQ1Y8RJjUiQ0dacbZydQ4rG++MI/Fev0pVTNWzQdcRoTvyjt3NhKv07RQnKeFMuoedadifxUerSUqgfA1y9vMO/aHoCyAvFED8DpBwqIzCZNpvjj3dXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0ywWmuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269B1C4CEEB;
	Mon,  4 Aug 2025 00:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267205;
	bh=s2/rlHHWGgfkIJwDCOvKo4CQOlSCHBQ1/r4At5fcDvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A0ywWmuv4LS3ugpAnhXpelwVFwBcJo20bV/uuXGEpgc1i+yYsjLyo2GAuU/Qu2pvt
	 /dqfkJ1+Twc0W1jgz+MsWjibbdOnJzzCqtS+nl1xRjxHHz/uDV1Gk5XBRTC+p2XzhP
	 vDlBzojhsKRQBPJiQIklSWXswX/1L+bB62SvaPXXTd/qfrrwbvzPVkrkGcKx2g5NE2
	 MjYEupoKWRH4m5FRp6RwuVTR8EOLW9Jet4GtrneVNT2GFtk2DAxqSm0Kqoj2dCHYvR
	 e3hT4ZQGzwFkSmuBFrcU7gs/xQkb00BL9o3MmsUFqXb5a0luhDQvO4pxl0wNZ1Mvlh
	 dSbCQ6LR+bqKA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: George Gaidarov <gdgaidarov+lkml@gmail.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	jbaron@akamai.com,
	linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16 62/85] EDAC/ie31200: Enable support for Core i5-14600 and i7-14700
Date: Sun,  3 Aug 2025 20:23:11 -0400
Message-Id: <20250804002335.3613254-62-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002335.3613254-1-sashal@kernel.org>
References: <20250804002335.3613254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Transfer-Encoding: 8bit

From: George Gaidarov <gdgaidarov+lkml@gmail.com>

[ Upstream commit 493f9c930e5ff72b3508755b45488d1ae2c9650e ]

Device ID '0xa740' is shared by i7-14700, i7-14700K, and i7-14700T.
Device ID '0xa704' is shared by i5-14600, i5-14600K, and i5-14600T.

Tested locally on my i7-14700K.

Signed-off-by: George Gaidarov <gdgaidarov+lkml@gmail.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250529162933.1228735-1-gdgaidarov+lkml@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Device ID Addition Only**: This commit adds exactly two new PCI
   device IDs (`0xa740` and `0xa704`) to enable EDAC (Error Detection
   and Correction) support for Intel Core i5-14600 and i7-14700
   processors. According to the stable kernel rules at
   Documentation/process/stable-kernel-rules.rst:15, patches that "just
   add a device ID" are explicitly allowed in stable trees.

2. **Minimal and Safe Change**: The patch is extremely small (4 lines of
   actual code change), adding only:
   - Two `#define` statements for the new device IDs
   - Two entries to the `ie31200_pci_tbl[]` array that map these IDs to
     the existing `rpl_s_cfg` configuration

3. **No Functional Changes**: The commit doesn't introduce any new
   functionality, algorithms, or modify existing behavior. It simply
   extends hardware support using the already-tested Raptor Lake-S
   configuration (`rpl_s_cfg`) for these new processor variants.

4. **Tested Hardware**: The commit message indicates "Tested locally on
   my i7-14700K", showing the change has been verified on actual
   hardware.

5. **Pattern of Similar Commits**: Looking at the driver's history,
   similar hardware enablement commits have been regularly added (e.g.,
   commits `180f091224a0`, `021681830e41`, `05a61c6cb631`), following
   the same pattern of adding device IDs for new processor variants.

6. **User Benefit**: Without this patch, users with these specific Intel
   processors cannot use EDAC functionality to detect and report memory
   errors, which is an important reliability feature for systems using
   ECC memory.

The commit perfectly fits the stable tree criteria of being a simple
device ID addition that enables existing, tested functionality for new
hardware variants without any risk of regression to existing systems.

 drivers/edac/ie31200_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index a53612be4b2f..6aac6672ba38 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -91,6 +91,8 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_2	0x4640
 #define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_3	0x4630
 #define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_4	0xa700
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_5	0xa740
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_6	0xa704
 
 /* Alder Lake-S */
 #define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
@@ -740,6 +742,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_2), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_3), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_4), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_5), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_6), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1), (kernel_ulong_t)&rpl_s_cfg},
 	{ 0, } /* 0 terminated list. */
 };
-- 
2.39.5


