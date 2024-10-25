Return-Path: <linux-edac+bounces-2269-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F89AF7FA
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 05:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B650B2120B
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 03:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE3E18BBA6;
	Fri, 25 Oct 2024 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2/NUHer"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB018BBA3;
	Fri, 25 Oct 2024 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825818; cv=none; b=EdV4ss0TUrmFzAS4UO/ky9TbiZtcZpxtdU2+kVtW6PbCzaj7OZEhLpD3nDfE85pN2HlH20/1G2knSitCSKDfYANt2DkLzrkcrqtbgQD/1qFbxtWFgMg7gihi+i5CzCfJyqjK2W9tpDDRANCNLw+GukpJfum9ZU07BJpkjVRnHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825818; c=relaxed/simple;
	bh=/U8+xKHaCdvK3vMq4oDINx7J29Rm28/W5b4lYt8uNgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QGvLawT9phIGuKHMzpSyVlNiVy7toPIFs//aVZzBoGuLXoAcjOfFh0CHoJFdRUlMwvrcOzY43dVe9erO8Ha9EiAEnxUgSSRban/eVjhVSe45wkgiN4A0K651WUpRj9XdEfewv0nQP3g+Fgh/KiStChaUHuSqGmz5zdpOZu8XjVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2/NUHer; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729825816; x=1761361816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/U8+xKHaCdvK3vMq4oDINx7J29Rm28/W5b4lYt8uNgs=;
  b=h2/NUHercz0J/OGfA2OJlRy+rcHvKfOMmN9TYIHXIoDvx1lWEOyzVu2B
   UPZBn7Wyu3K07RqOKyd79JjxtXno6RaafmGWHVZ4zDgHjLEdeDpvWraVg
   9lClEuKpaQP3msqB9SiDn2loK8vNDHWtZthge6qbCVXyGFl8H4xQzcVoL
   B/COTNJ7b36I+F/IbbcPzlQhYfpOygxPZZqmbo0dktw2hBBiwiRK9LmLL
   ptawqoyx/pa7ud28mXoi944nNyjixscAjK97qR/pUBmToGpENJaveomU9
   0anN1OU3AR0iQhkYlLZG+RnL8QR+c9YoY42gFXgBlywvU8NeEp3B63rGP
   g==;
X-CSE-ConnectionGUID: OQMJ9K/2SW2czhnXga4qrg==
X-CSE-MsgGUID: HDx+IxNwSzesleS2wL/hLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29385546"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29385546"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:10:16 -0700
X-CSE-ConnectionGUID: +5DF61YLQSqMz1RYJrcG7Q==
X-CSE-MsgGUID: bpdk+8vvT+eHZrwL3TiPtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80449506"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:10:14 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH v3 02/10] x86/mce/intel: Use MCG_BANKCNT_MASK instead of 0xff
Date: Fri, 25 Oct 2024 10:45:54 +0800
Message-Id: <20241025024602.24318-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Use the predefined MCG_BANKCNT_MASK macro instead of the hardcoded
0xff to mask the bank number bits.

No functional changes intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v3:
  - Collect "Reviewed-by:" from Nikolay & Sohil.

Changes in v2:
  - Collect "Reviewed-by:" from Tony.

 arch/x86/kernel/cpu/mce/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index f6103e6bf69a..b3cd2c61b11d 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -94,7 +94,7 @@ static int cmci_supported(int *banks)
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
 		return 0;
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
-	*banks = min_t(unsigned, MAX_NR_BANKS, cap & 0xff);
+	*banks = min_t(unsigned, MAX_NR_BANKS, cap & MCG_BANKCNT_MASK);
 	return !!(cap & MCG_CMCI_P);
 }
 
-- 
2.17.1


