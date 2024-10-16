Return-Path: <linux-edac+bounces-2104-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B39A0AD8
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 14:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B0CB28E5B
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0257A209F41;
	Wed, 16 Oct 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCpL7VMd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10420C49D;
	Wed, 16 Oct 2024 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083284; cv=none; b=PsogW3evZ7Ail59wIC8EYKesZC3fCxtDQ3WHfJ3QQrZynsHfSjEl0L+MM7YRlY49DLau/idRvfdYA8htztzRnSBjocIO4HzxhTX3ALPepAiTbIAzZAipm7NYH7wPiiDmKlJlvcuqEnJ1wg7e9xKN8AteDdvnYP4gxthQMi5VHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083284; c=relaxed/simple;
	bh=2ls6pglQHV/bEvjP70YtkNvbmLntN02ye5RgwZfXdb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GOL6EKSVCmrhAxJrr6R2ESCNNfUoUBL3Fd1Qxrro+FlIgwkmMOuUFsCIztuMTtuve4+A5DnJEDf1MkRSYJS9uHgv96YKQsq4y9hfQFhdiEP+XCk2Tj4SOPbDlaoj16daSg+J0fvMGTLI7iFmXy7y9vVDgKbzTOlpuzP01LhDeQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCpL7VMd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083284; x=1760619284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2ls6pglQHV/bEvjP70YtkNvbmLntN02ye5RgwZfXdb0=;
  b=XCpL7VMdiy+VZM4nESksOKIkBv8J+ZvpZ/dpQV8k0I893YawPFjA51Ir
   tRL5Vdcng+gM/gPYq00Z2tTYaeD7Qs7X3yHroUKWmRtmCbmmbauvs5vKZ
   eUIm3xq8VnQtOmtH0T8xd86ZQ7BXDHxMTkDUENMKj3X1OpcXknu/Fj9lB
   DqEcms5SGeyz0rapr6CZJ9FBMXZ78MdQv7pLoM2ULLyQOXKLwu9bYyJlM
   T9bTjfpkqrdlgaZsWsOuRpdoYoUNkEL54sm125LSK2TodvDU77ENc93RO
   6ENRN8/3XZLNPz5GxaEZjk+kioDJZVT7Zn7i6HjX45McVC42zyYOvYMpJ
   w==;
X-CSE-ConnectionGUID: 2ZN8cLstTTWLX1l06CTIDA==
X-CSE-MsgGUID: oXVqUbOJRaahlM8kfJwNFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32217603"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32217603"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:43 -0700
X-CSE-ConnectionGUID: fXwKWwI8TzyXmVBle256IQ==
X-CSE-MsgGUID: b2HARNm0SXig/YsOZkLNig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82761741"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:40 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tony.luck@intel.com,
	bp@alien8.de
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH v2 08/10] x86/mce: Remove the redundant zeroing assignments
Date: Wed, 16 Oct 2024 20:30:34 +0800
Message-Id: <20241016123036.21366-9-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

As the entire mce structure is initialized to zero using memset(0)
within mce_gather_info(), remove the redundant zeroing assignments to
mce->misc and mce->addr.

This results in a reduction of 64 bytes in the text size.

  $ size core.o.*
     text	   data	    bss	    dec	    hex	filename
    21348	   4181	   3776	  29305	   7279	core.o.old
    21284	   4181	   3776	  29241	   7239	core.o.new

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e718b9bbe8e5..844a6f8d6f39 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -706,8 +706,6 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (!mce_banks[i].ctl || !test_bit(i, *b))
 			continue;
 
-		m.misc = 0;
-		m.addr = 0;
 		m.bank = i;
 
 		barrier();
@@ -1284,8 +1282,6 @@ __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
 		if (!mce_banks[i].ctl)
 			continue;
 
-		m->misc = 0;
-		m->addr = 0;
 		m->bank = i;
 
 		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
-- 
2.17.1


