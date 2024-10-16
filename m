Return-Path: <linux-edac+bounces-2097-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF869A0AC5
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 14:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8F6281725
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCAB2076BA;
	Wed, 16 Oct 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjNz3hVY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D41F8189;
	Wed, 16 Oct 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083230; cv=none; b=GUeLWRRoTrioGkNCfvdnKD1KjIj91Pw9rdvEx4oCO8FM11aa3RytWsSWCXBVoyYUykqyuCjslSayfqUtScTYOBPSatxpK8vbTjQrrrxsuTNmaTpCAjPUjCDNwL5C/YtcMBF0w9kDp/iji2OEZvhqLphmkp4okgrR2YvG7OQSq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083230; c=relaxed/simple;
	bh=KOY+JBxUC1JBmDbxMSISPXRy6rIM65p1ZBlq9X5krHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ppihlzskZnXsLffccY5fh8rrJoiWUnNIrpwJaiQpmWpZvblntP0I0+BuPmMbXJx/R0NonPo8K7rL//qzuQTzM9N6ZVG6Vsdb2izckia+3j8oRCm5yen4ZYziXu43b91SQgkEVO+MVxJqXL1yK6RJPs/cFIY2/oRy2GwcV7j5hJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjNz3hVY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083230; x=1760619230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=KOY+JBxUC1JBmDbxMSISPXRy6rIM65p1ZBlq9X5krHw=;
  b=cjNz3hVY9Gb9+IYXnfIcA21n+77andZTpXPtQs+OYEm4sywx6FhsgIp2
   tNct3yn2balAmNid6ukWl7VmFTwbfLGHAUA2T9W9ZCxgkh9K3L+RF7nEB
   A3CxM0SZXj80vYL+RvyklEVOclhpUIqWioSQ4ckxVBNnXKK/l3wWf0YU6
   IvUx/veXfk858/tR26c+eICDf3mOrCfqXJ/bXZbSUKCQwVCjotjK2jlj6
   4uVVMwADLOOsAtn/sqb+5HZdYlT8RcY5iKc0gAJPJnciv45nOUpNM+nq/
   /z6HF8wgJQkE+RjVgom5tiszLZmQMxoWdsQjuFfyMxJCQfeyycETeSJ9c
   Q==;
X-CSE-ConnectionGUID: l1EnNMAoSaamdFf7tplg0Q==
X-CSE-MsgGUID: iW0/bdKbRti3/8DpmWoe6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32217432"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32217432"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:53:46 -0700
X-CSE-ConnectionGUID: kk8iWaCaQWaPgmeokZ7vdQ==
X-CSE-MsgGUID: 7Fq9b19GTei6O0qhbYH/RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82761573"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:53:43 -0700
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
Subject: [PATCH v2 01/10] x86/mce/dev-mcelog: Use xchg() to get and clear the flags
Date: Wed, 16 Oct 2024 20:30:27 +0800
Message-Id: <20241016123036.21366-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Using xchg() to atomically get and clear the MCE log buffer flags,
streamlines the code and reduces the text size by 20 bytes.

  $ size dev-mcelog.o.*

       text	   data	    bss	    dec	    hex	filename
       3013	    360	    160	   3533	    dcd	dev-mcelog.o.old
       2993	    360	    160	   3513	    db9	dev-mcelog.o.new

No functional changes intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index af44fd5dbd7c..8d023239ce18 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -264,15 +264,8 @@ static long mce_chrdev_ioctl(struct file *f, unsigned int cmd,
 		return put_user(sizeof(struct mce), p);
 	case MCE_GET_LOG_LEN:
 		return put_user(mcelog->len, p);
-	case MCE_GETCLEAR_FLAGS: {
-		unsigned flags;
-
-		do {
-			flags = mcelog->flags;
-		} while (cmpxchg(&mcelog->flags, flags, 0) != flags);
-
-		return put_user(flags, p);
-	}
+	case MCE_GETCLEAR_FLAGS:
+		return put_user(xchg(&mcelog->flags, 0), p);
 	default:
 		return -ENOTTY;
 	}
-- 
2.17.1


