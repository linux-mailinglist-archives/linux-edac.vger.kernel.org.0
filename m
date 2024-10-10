Return-Path: <linux-edac+bounces-1993-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209B1998C69
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C580B1F222BA
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003241CCB3A;
	Thu, 10 Oct 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDDOJUvL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8BD77F1B;
	Thu, 10 Oct 2024 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575661; cv=none; b=IIENcNXDJJuR8TH4hZVbNbP5LBynHaFb0HZs7CQeO7/lhDXjJ469+o3amID9daUytOmnx+2gKJcJzsLbTzyGAH44wRh7NDTtlRdVcQlJHORYIIiGK1KC58wanj/D4mQ3kAFeeugiKN7hYDbzVuUXysebFdqA41YsewkESWMo1RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575661; c=relaxed/simple;
	bh=1WynrAEJvNfnKoJ9G8ZFXV7mNdQCAvS6jbzSEf4O3A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Uxx9b3qw+Q+b8yRpbyWzwSS6XlJulzhpgfiVIqX2ayqx55z5m1eB/7UnsUtVZ+ex6oUF/AQd+PvO924EgJWjEwUO2j1Gx2B3b3TiKSxAbIPuv2AevZ5EVcTMF8zcobEgpxY9/AhdCW38CKHk8qarp+CsczYeqqKjxqm9BDD+Zl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDDOJUvL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728575661; x=1760111661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1WynrAEJvNfnKoJ9G8ZFXV7mNdQCAvS6jbzSEf4O3A4=;
  b=cDDOJUvLN3EJBUt1FkIZf1+sMz23wJLKch72VGKmXMrsBvWhTYC3BRKC
   KtBBOvrh+ukPO96N1AtBUCZkJFYwGf+6jR0XhFZsXtCBM3y2bxst3CHj+
   DCJjPJNiH8r3wJd1IxHiS9IxC9A4hYFEuwu1FFdWEU4ZyS64Nlf3IY2Un
   yQLMzx9Tyvcc/Ya40BLvU3Cl+eV6dI5b/r0KE1EM7VwpAqowb+sRXirb5
   Mzt6EXaPPKHi41HCySu+XkW/fgM6yucpAB49m0XO1C8lXK+GgJMZJ1f98
   T0GmIgCoabCrKfMc+YGAr3CHizron4ELyzKqOeKFyZZscd6P3lpFuBHGu
   A==;
X-CSE-ConnectionGUID: oXxcA21iQ7OqcuTqUvN+FQ==
X-CSE-MsgGUID: dvdZclTkQeKNpveUggwZdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31643511"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31643511"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:54:20 -0700
X-CSE-ConnectionGUID: X3871bsAQyq+IdW4xEcZGw==
X-CSE-MsgGUID: F/4SHDI7ToOi6hTJ8EQwSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81221751"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:54:17 -0700
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
Subject: [PATCH 01/10] x86/mce/dev-mcelog: Use xchg() to get and clear the flags
Date: Thu, 10 Oct 2024 23:31:53 +0800
Message-Id: <20241010153202.30876-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
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


