Return-Path: <linux-edac+bounces-2490-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A91DF9C386C
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 07:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3ED1C222B8
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 06:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEB1155CB0;
	Mon, 11 Nov 2024 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gODLY/es"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCAE15533B;
	Mon, 11 Nov 2024 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306834; cv=none; b=lS2wYDmkeUZO2ry0G/n1S7QTbqRoYkg2denhfnX4DdUaNS1dhRFUZd2eGnU5EUy/90qlUhm7KCtH0F9KxQklYfQErACuJw8Smh4B+S+YjH3QxqJDMRGIJtn0GYa4J/ywNTKi7XAk3m4A4G8a4Yw5DqV18A7Fdp6bPa2AU54CTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306834; c=relaxed/simple;
	bh=M8xnXQTpv++oBgUurlSvudU6qs57Dbg1H+Eq0HCqBxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MXIb08t/4/Vb5OgJNNTcCobKYN+DK1FRQSt0QhiJga43oLdsX6Opnc8DEqrLek9ojhUHZ8mPBekwTT3FeSk3m67X7fiy54olqyc0ZKX+aR6wlcfGtZLEs2DMtRXroVwyUUDm6darXsn4gwU8fIcM9/0N3aC/Xih7DAc1nYDDNn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gODLY/es; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731306833; x=1762842833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=M8xnXQTpv++oBgUurlSvudU6qs57Dbg1H+Eq0HCqBxY=;
  b=gODLY/esMK+JyEWhGt3VdmvakvJoaQB4XYOBv6pROhPjE7985HDnwCRt
   Ee5NGSiWfdLnhahQ71xFeIClSix66qDwV/lXPyfSyco6t5zFQkdfv6xRf
   gtkp17Fg3dhmZ5COhJBV+1ifYHeSiczz8mXL9LF9uohGS9K0VA1ltw/rt
   Ir0sK/HR8oSbdMTIeTrmTNucawTZ64XfD02G6YKTRekX7I/IRn0UJl8HN
   gpBW3DZ0hZV/hbWNgd5l2W1Xc4F7Wo5BA4zis+PU7zYLi0eqDX99CqNmO
   J+WOr2vqFP6xnO67aEeFc3NF/3Ph7lP9WicEO4BX82AGBpkAljWO7qYLG
   w==;
X-CSE-ConnectionGUID: P242mYf7TsGXPBExE9mnMQ==
X-CSE-MsgGUID: naEMd6koT/irF7K1QVjlMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41715598"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="41715598"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:33:52 -0800
X-CSE-ConnectionGUID: u+e5HdmCSM24hV0FMrGZuw==
X-CSE-MsgGUID: BNvh2a03TbqjP1AE6DxkuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="117684679"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:33:49 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	hpa@zytor.com,
	yazen.ghannam@amd.com,
	sohil.mehta@intel.com,
	nik.borisov@suse.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH v4 5/8] x86/mce: Convert family/model mixed checks to VFM-based checks
Date: Mon, 11 Nov 2024 14:04:25 +0800
Message-Id: <20241111060428.44258-6-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Convert family/model mixed checks to VFM-based checks to make
the code more compact.

Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v4:
  - No changes but rebased.

Changes in v3:
  - Newly added.

 arch/x86/kernel/cpu/mce/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3855ec2ed0e0..d288cc7390f6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1954,6 +1954,10 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 
+	/* Older CPUs (prior to family 6) don't need quirks. */
+	if (c->x86_vfm < INTEL_PENTIUM_PRO)
+		return;
+
 	/*
 	 * SDM documents that on family 6 bank 0 should not be written
 	 * because it aliases to another special BIOS controlled
@@ -1962,22 +1966,21 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
 	 * Don't ignore bank 0 completely because there could be a
 	 * valid event later, merely don't write CTL0.
 	 */
-	if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
+	if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks) > 0)
 		mce_banks[0].init = false;
 
 	/*
 	 * All newer Intel systems support MCE broadcasting. Enable
 	 * synchronization with a one second timeout.
 	 */
-	if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
-	    mca_cfg.monarch_timeout < 0)
+	if (c->x86_vfm >= INTEL_CORE_YONAH && mca_cfg.monarch_timeout < 0)
 		mca_cfg.monarch_timeout = USEC_PER_SEC;
 
 	/*
 	 * There are also broken BIOSes on some Pentium M and
 	 * earlier systems:
 	 */
-	if (c->x86 == 6 && c->x86_model <= 13 && mca_cfg.bootlog < 0)
+	if (c->x86_vfm < INTEL_CORE_YONAH && mca_cfg.bootlog < 0)
 		mca_cfg.bootlog = 0;
 
 	if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
-- 
2.17.1


