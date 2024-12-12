Return-Path: <linux-edac+bounces-2697-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8319EE830
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 15:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB89165B60
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 14:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617562135BA;
	Thu, 12 Dec 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pto191pA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3621171A;
	Thu, 12 Dec 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012205; cv=none; b=qMH5C/EKgTKlQJulNWJEw93TSypQQanfFOE49VCfgiNuUrf+PE8C88k/7ba9HNsjOSKf+rXSaTdcysd9cyH2l7+lk0IO0b5cqjy3Kbd0VPiqAdnqbEHY+xc6sDQZH2wgaYbPdBqcVN+gUTkz5CkyJRI4/grUrd8Bjx8bxwnqvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012205; c=relaxed/simple;
	bh=oOC4LP6NhQ+SUj4XW7IroWt42yIaPYOnOrkVVrEm3ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mU+ILczD9QxR7H33RRq0yvqgevNlWnWZsdKf/ydVBoD4y3rOjrzMAG9w1R7Mc+MMv1o8UsQs9rZ8/j1/w3r7HromK4g0wmkg4cPU+un/WK3+GREsTrQtMiU4TwpUUUKKA8Fz8wVW5iF48qDM1o6lmOSrFUuXMvGFKmsKyulqE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pto191pA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734012204; x=1765548204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=oOC4LP6NhQ+SUj4XW7IroWt42yIaPYOnOrkVVrEm3ao=;
  b=Pto191pAbZx2kGjeOnbko8WtmIAWFFk3Tn1WvPSBo2fa4ApyOs93fXKL
   NDK34UI86lzUE+znYvXJ9kr5KFKj0KQIEFl43tOj7ZZ2zIH48lXmckkTz
   a63VD+sZIE6zFr/6xo8EhUBK4tkuXvSOHrziryK/xTk5DlHoltKRFKrRa
   eV4fauO+xgzU0/CTOUAP6pmSUB6PWBBePwSQdvu5dCBOMy5pGFz2kGAg2
   9yxEBL8MOcQzr1ZAi/pFGHZ2sZdBFEASTU70eqCAMFTomIurkGAWEBIPa
   QDq6YWdO/pW6eplQdtwWYNMfbhyg4GeJsNkgjWzC+JxKx3zFRKZEHfuDQ
   Q==;
X-CSE-ConnectionGUID: XCbw+xFJQHyPwqmP8oKQPg==
X-CSE-MsgGUID: clPxfCoET3ayBlzKdvQfBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34155094"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34155094"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:03:23 -0800
X-CSE-ConnectionGUID: dOiWKAifQbaCgESBfPLycw==
X-CSE-MsgGUID: djCujwWIR6OwHrB7SGF5Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96465513"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:03:18 -0800
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
Subject: [PATCH v5 2/7] x86/mce/threshold: Remove the redundant this_cpu_dec_return()
Date: Thu, 12 Dec 2024 22:00:58 +0800
Message-Id: <20241212140103.66964-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212140103.66964-1-qiuxu.zhuo@intel.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The 'storm' variable points to this_cpu_ptr(&storm_desc). Access the
'stormy_bank_count' field through the 'storm' to avoid calling
this_cpu_*() on the same per-CPU variable twice.

This minor optimization reduces the text size by 16 bytes.

  $ size threshold.o.*
     text	   data	    bss	    dec	    hex	filename
     1395	   1664	      0	   3059	    bf3	threshold.o.old
     1379	   1664	      0	   3043	    be3	threshold.o.new

No functional changes intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v5:
  - No changes.

Changes in v4:
  - No changes.

Changes in v3:
  - Collect "Reviewed-by:" from Nikolay & Sohil.

Changes in v2:
  - Collect "Reviewed-by:" from Tony.

 arch/x86/kernel/cpu/mce/threshold.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 89e31e1e5c9c..f4a007616468 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -90,7 +90,7 @@ void cmci_storm_end(unsigned int bank)
 	storm->banks[bank].in_storm_mode = false;
 
 	/* If no banks left in storm mode, stop polling. */
-	if (!this_cpu_dec_return(storm_desc.stormy_bank_count))
+	if (!--storm->stormy_bank_count)
 		mce_timer_kick(false);
 }
 
-- 
2.17.1


