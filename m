Return-Path: <linux-edac+bounces-3487-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA502A80C14
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 15:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E877A801F
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDDB2D600;
	Tue,  8 Apr 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDB58FXO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D01EA65;
	Tue,  8 Apr 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118723; cv=none; b=ZlLWRwEwGG7y22e5Elkl3/HHyPekiZyK1Tm/tj/WCkM3EHlgfYGa48VXE1Xfs5Wkv7PBabC8G3Hanw4nGAwRhKmwXzqfDtffjZOi+ezWEFv2AriOYGnkKzc5Xvtkd0EnZ0gzZd8jCHiArSHoS1jxxxAv5zvbX4bImOf94nZc3Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118723; c=relaxed/simple;
	bh=Sp3LVofHfZ5TNo81c5Y42e2eMP+sRv6Css2zbHW72OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJBC4TKzcszimPDrTxiJvvKo53wQs+KMuaXkN9AU/brbYEGbZAlXQAJ3TsQ/aBF66NQBRAv5SKjNo1HIgI4BO6/Y5qkgIWPdlxuz1vhl3HOryUZyhqBTF6VWFL2vSsZ8b9LOA6tfOs/iQianWDbZBdAPuNsDmZBTIO5YscStpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDB58FXO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744118721; x=1775654721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sp3LVofHfZ5TNo81c5Y42e2eMP+sRv6Css2zbHW72OA=;
  b=DDB58FXOuR7cnit+hUbQS9JXmrvVXfehEJevjptZ9j8ZMZ8Cvi+DCQV9
   2yYHYuDSX0+FXExdV0FtodbkFrwdipHrn0GCLxG60k5FKLLOzpdPnsyy8
   0sMowv0P8s1X6KcfGxwZZIJXxn6Ou77qboqQCQmbOo0Tmi3gjUxHwK0l2
   OmNGTgDfNkdqcjyhG9p/vGISGMgsbfrFcS3eGj2pOOtQxwiVcmZoj6Jh5
   7za03CQrlHWiRSwBGdG3rHVzu9Ry07q7G1u73TxAJNWErG9RxwY2lixfW
   Rs1BOOymDgPmYNXDR15bagNsz604+Fbk8H8qOjgnw0GfSBc9D/BhgSZdl
   g==;
X-CSE-ConnectionGUID: xcuM277QQV6nnmoFwpMzAA==
X-CSE-MsgGUID: jPEt5CgeRGKfWNMdvuplnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44799602"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="44799602"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:25:21 -0700
X-CSE-ConnectionGUID: Rm7B5lVETTySaDBxEENuSg==
X-CSE-MsgGUID: 6iqx99pmRkqPAixo9eQuvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="159258205"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:25:18 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] EDAC/igen6: Add EDAC support for two Intel SoCs
Date: Tue,  8 Apr 2025 21:24:52 +0800
Message-ID: <20250408132455.489046-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain BIOS versions of Intel SoCs with In-Band ECC capability
(e.g. Arizona Beach SoCs) may fuse off some memory controllers,
causing the current igen6_edac driver to mistakenly register these
absent controllers with the EDAC core.

Patch 1: Get the igen6_edac driver to skip absent memory controllers,
         preventing erroneous registration with the EDAC core.

Patch 2: Add EDAC support for Intel Arizona Beach SoCs (for network computing).
         This patch depends on Patch 1.

Patch 3: Add EDAC support for Intel Amston Lake SoCs (for edge computing).

Qiuxu Zhuo (3):
  EDAC/igen6: Skip the absent memory controllers
  EDAC/igen6: Add Intel Arizona Beach SoCs support
  EDAC/igen6: Add Intel Amston Lake SoCs support

 drivers/edac/igen6_edac.c | 86 +++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 16 deletions(-)


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.43.0


