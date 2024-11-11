Return-Path: <linux-edac+bounces-2492-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5EC9C3871
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 07:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815B31F21E13
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 06:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93883156C72;
	Mon, 11 Nov 2024 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sgoq3/id"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57261537CB;
	Mon, 11 Nov 2024 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306851; cv=none; b=cJiqz1Bg160W+6wOA/UvkJ8NElMvAC/MNBDLI7a65gd76hoAqK7O4dB6Oznglfylh+LNQmIjFpNKEfI0C57hAZ6iKdTELhxtfbNm2dMhowpUZfJjMNVwzmkwZw7CgkSypl7XMSiTBHIOUjDiDraJFy9LA8qPskI58EvuW9SBtaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306851; c=relaxed/simple;
	bh=ocS7zShDtGnLI5b4X5XRts5pmrdem65a4kf54K7qkQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RDoSsByMjKqzdVwfYYaMJiUIp9w+WqWM2jlUsSWH3b+Fahf2DG2LU/tmR/k/FWq7S5QeMzsKTZZSLrQFJRCjGA5U+e5lmwtWStjest6igLeowQ3vjVGEtNmmZLh1j12f6C03yyVs4Br2n+1+jgynPGVaYYUbDt0C+9tPNSXYDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sgoq3/id; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731306850; x=1762842850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ocS7zShDtGnLI5b4X5XRts5pmrdem65a4kf54K7qkQI=;
  b=Sgoq3/idxTiPBPRMZHCxyN+V+FeMx1213xcKlfMfy9g7JUqC5NPL2B/L
   lsnFXIS0QHySQJ7rtdIZjdbpWW/eG/cWLR0aYmWUN17h68iOXbvqR+gJs
   Gw02mhJGalJHEUcWlsyqDAMvLsaB+WSvF0OUOvFshUAH9losW610j5tQE
   BDO4sGSDlu2wE8/O7rC02xe76UEXMM7Wo4C4WjdgsE5hc5xM/BTGkh7MR
   TE1+9X5p769Eux1RDPPhmzxejayD+2v+ZHh769eYcj59QPLcTIvFM8JXO
   3hKcS45gpIkJP01TURs+6jQ8iYOlv6ew2tHdmrx7b9tNqJ4spQ6bicYZI
   w==;
X-CSE-ConnectionGUID: 5T88Xm+hRE+hGAj0Rq/6vg==
X-CSE-MsgGUID: 5B+pfDPFQ6GUEakkK56Qfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41715621"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="41715621"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:34:09 -0800
X-CSE-ConnectionGUID: D2Ab2lAmRZ2/YVaIgiOvFQ==
X-CSE-MsgGUID: 5KinCGrRQS6dpOdHAXk2Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="117684695"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:34:06 -0800
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
Subject: [PATCH v4 7/8] x86/mce/amd: Remove unnecessary NULL pointer initializations
Date: Mon, 11 Nov 2024 14:04:27 +0800
Message-Id: <20241111060428.44258-8-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Remove unnecessary NULL pointer initializations from variables that
are already initialized before use.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v4:
 - No changes.

Changes in v3:
 - Collect "Reviewed-by:" Nikolay & Sohil.
 - Remove the variables' names from the commit message (Sohil).

 arch/x86/kernel/cpu/mce/amd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 018874b554cb..c79a82912d38 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -921,8 +921,8 @@ static void log_and_reset_block(struct threshold_block *block)
  */
 static void amd_threshold_interrupt(void)
 {
-	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
+	struct threshold_block *first_block, *block, *tmp;
 	unsigned int bank, cpu = smp_processor_id();
 
 	/*
@@ -1201,8 +1201,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 static int __threshold_add_blocks(struct threshold_bank *b)
 {
 	struct list_head *head = &b->blocks->miscj;
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
+	struct threshold_block *pos, *tmp;
 	int err = 0;
 
 	err = kobject_add(&b->blocks->kobj, b->kobj, b->blocks->kobj.name);
@@ -1312,8 +1311,7 @@ static void deallocate_threshold_blocks(struct threshold_bank *bank)
 
 static void __threshold_remove_blocks(struct threshold_bank *b)
 {
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
+	struct threshold_block *pos, *tmp;
 
 	kobject_put(b->kobj);
 
-- 
2.17.1


