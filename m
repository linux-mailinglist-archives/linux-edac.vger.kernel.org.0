Return-Path: <linux-edac+bounces-2000-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE54998C83
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 17:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412A21F20A9D
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744A21CDFB6;
	Thu, 10 Oct 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgzygADS"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040261CDFA4;
	Thu, 10 Oct 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575774; cv=none; b=G10cOudoMT8fqUb9iDymaYJeOdjYP4B9WCw7lDWT5chkMIeJ6ydBPZ6gR6LB22z+0uF3GQWxFtvBtidZTxZRT6pGucywcIQh17Dbe176J2EiBTktrbja1zxdHrz1qSJFJRYmtWHLsrx0H6tbUCTW+ipLfI1o2tWQ86Lj4dNkTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575774; c=relaxed/simple;
	bh=DS90dg2NbbEoGW7kXq2baDYlEThrWrVLN673//15/1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lKl5xz7B//bQCkgytwkuzz84oiFFLrgFWNcNR3Vpug+qpuKdR9EIotF4JvP4ICjEmg1VhpSZQwfLuqYSKmQq87WtNFw1Gc+WtZs3FhK8W5jUYHwpnp/n6GsB7F36iBbYyQxyM61VuDzKiLv1mnpsMKfmTmSBnp5C7avl4hNrsUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgzygADS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728575770; x=1760111770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DS90dg2NbbEoGW7kXq2baDYlEThrWrVLN673//15/1Y=;
  b=cgzygADSEUE9uFfsIex1iO2gUflhXIjVx1lXTlHKMt+WjSl4PbHyzDYP
   pTCJCnEnKeDQwHTjbTv1tS54ds61ewvPp08Dc21kEWjO3BW4Xv0AvjE2c
   T92RtA1hog537IX/WMA8bAbOMmLEIml/LD8VtVvUPn0wCwvicVXoGGfPm
   fbibtHpgAmiGd1un7HVWMY+Rd77KZ5DmGVIUYczsnjOgEwgcrXmzquvFe
   IkrBsDKqpc34u6moebfLDj/7Ve5t90L3kGNRQyS5OesJzBFNtGk0ppbwm
   V9QcYCMzEol3Vl1l+UXXODy/cYiX5EuuTAnCxYliXY4zZgxD6aZxwsvig
   A==;
X-CSE-ConnectionGUID: pUuu0t/BQtOSzSOIQ8EYhg==
X-CSE-MsgGUID: c5dpKi4/QsyhSjg+wBhNKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45423261"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="45423261"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:56:10 -0700
X-CSE-ConnectionGUID: k0kd+4lPRqeD1wLYe5TELg==
X-CSE-MsgGUID: SNn/hWwUQy6xP2cmzV+hPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81222754"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:56:07 -0700
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
Subject: [PATCH 08/10] x86/mce: Remove the redundant zeroing assignments
Date: Thu, 10 Oct 2024 23:32:00 +0800
Message-Id: <20241010153202.30876-9-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
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


