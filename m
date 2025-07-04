Return-Path: <linux-edac+bounces-4311-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5DDAF8B53
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 10:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C842456269C
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A972BCF7F;
	Fri,  4 Jul 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nx68XBF6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5428B3ED;
	Fri,  4 Jul 2025 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615658; cv=none; b=akhix1i4p+RKOfOGKz9TGTM0Qa3Rk6FaujA1Ck2zXVge4u37WO247J4qZr/KlwkN1fmQPxtBe9E+PUDxsAQA/YTPOF9A7MsJ7GFyT7g8YoKywulZvhUAKgciKD5KZtu13OSQIG1kTW5d8pPgcURVBEUDzvIdzosix87LMWJL+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615658; c=relaxed/simple;
	bh=ppfSYqAbvKz06hUuUu+InAtyPJ44rr6/wnF/AFQd36w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJ5Oae8QCuDImnOPrJ7MHhteK6GTgZOsEJTRyZxIuqCjKUqA/NgT7h2vM+PDf9Dv5bWOKvakLctuTctFQG0wALVgMc7v5acrt/8uIQOYYNtvlgOKe081dzM4tG3AosGV+7pTaD1j6lYNfq0JrJIaRDv86/RkJWINVfdE3zFqZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nx68XBF6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615656; x=1783151656;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ppfSYqAbvKz06hUuUu+InAtyPJ44rr6/wnF/AFQd36w=;
  b=Nx68XBF6P4+pTN8p7DUKXeCq88k7TVmI1u534dnbpDKYjw6A11iLjcWk
   Vzt/kqO1FHWRiGQTQHODoLqLYbuyxDzw399CcN59oD5RR75drUpi6VQk9
   frKSFIBY42dJfA35eaqUIpJYAacJCcStUDU8XtJTz8c1nE41BrihWCLN3
   UDAUNlSNic1PgMJBJP6Xx5oC6ZDAxhpBlXNyZ9F/tjV2aWutJKSK8lw5W
   Hs9drmU9VC0wdhObwI67RJ8SG7BmRXiDQukP+VSSI9ft90/m5I0P6lN3+
   7zmbKZlmU577BgALNMmy/YLhCrmpwGFch91wpf21shQDOXrOc6gKX/3Wf
   A==;
X-CSE-ConnectionGUID: 1ZG7v0hOSTKlAQw7PPDYLw==
X-CSE-MsgGUID: YW0gd2+TTTqHKuk4sOWRIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57621101"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="57621101"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:16 -0700
X-CSE-ConnectionGUID: yOk/N1OrQ0qJ05Z7dUKvsg==
X-CSE-MsgGUID: 3sc9ARBbS5GpD3N+4N5bBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="154663843"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:13 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lili Li <lili.li@intel.com>,
	Laurens SEGHERS <laurens@rale.com>,
	VikasX Chougule <vikasx.chougule@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] EDAC: Add three Intel CPUs for EDAC support
Date: Fri,  4 Jul 2025 23:16:06 +0800
Message-ID: <20250704151609.7833-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add EDAC support for three Intel CPUs: 

  - Patch 1: Wildcat Lake SoCs with In-Band ECC.
  - Patch 2: Granite Rapids-D for micro-server and edge computing applications.
  - Patch 3: Raptor Lake HX series SoCs with Out-of-Band ECC.

This patch series is on top of RAS edac-drivers branch.

Lili Li (1):
  EDAC/igen6: Add Intel Wildcat Lake SoCs support

Qiuxu Zhuo (2):
  EDAC/i10nm: Add Intel Granite Rapids-D support
  EDAC/ie31200: Add Intel Raptor Lake-HX SoCs support

 drivers/edac/i10nm_base.c   | 12 +++++++++++-
 drivers/edac/ie31200_edac.c |  4 ++++
 drivers/edac/igen6_edac.c   | 15 +++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)


base-commit: 815703e2ecdf091a724c16671aadd8c55de24878
-- 
2.43.0


