Return-Path: <linux-edac+bounces-4484-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F59B17393
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 16:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BE45612AD
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290231D7E35;
	Thu, 31 Jul 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUizJktc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C51F3FE9;
	Thu, 31 Jul 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973903; cv=none; b=UToaVhrRquiCMKreSj9i31PaGl+zMDUqMangrhrUkLZw6upeoE7uZ3pxFrBowvCgF3glnxWoUOr8i5WGqGPMT82r6Jeufpe0k8VMkF7aa+exeqIwaBlSK0zhPc2l002DjEfpFFmyL2wZLthSV0oKs1IrBzdSd+DhqZLkWP2fny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973903; c=relaxed/simple;
	bh=4OC8m3behZEHOWX6Ecm+COMTeeg4Qtkl8CIHlPkMdvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEFEIDqzv5Wmexqc+5s0EWUCTsrV9gj9doHG2r7/ZkpsqF0oNqwaJiQzrX4FnphuVLgikK0zjmBwQnJgrKxeA0XS5oz9oZR41s/499A0VXrbaCmvY+ZVvXGASarPpvq9JC01M1esLYI5uj5xhrwXRjAPV7XJm5yH/biMlFiKy+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUizJktc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753973901; x=1785509901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4OC8m3behZEHOWX6Ecm+COMTeeg4Qtkl8CIHlPkMdvY=;
  b=EUizJktcd78nwaiD29DEdgmXVfZtRDoOVwAl8MoGAhZ1FG/eH5YmI8fZ
   h1HoXG0rTpV2nRi3e/olPMyHMmkmBt8EBXq9QV7c5b2zdLGC1JmOmleWt
   QVCI3TWiV++7IEaRmKBZ7RJkd+TEilQ9XhK+67XsysB05rI2S1CBDCn4d
   aO1a83iFvjwJNqMjCHENVKhLaxdnvoVTtTDv/2iuzi5d36K2gnxTvD2Up
   IutI9qY2oNUAB9/hC90ujv4qVdl58C4rhqAHCEIMW61T5l5L6Hvzo+wdl
   lHRJvWsmfE0jYmXETy7Ts56hlyAOfWEkRdXxQU5qyhZvHdEWsiolC1BBg
   A==;
X-CSE-ConnectionGUID: M+3t79i9QmaYzvZhOszaUw==
X-CSE-MsgGUID: LyG9SMtlTsWZGWAmgkXXZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56231840"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="56231840"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:58:21 -0700
X-CSE-ConnectionGUID: Gs0pXgnZQBGutLeawivLeA==
X-CSE-MsgGUID: ywXNU/UfS3WGFz0jVL0Q9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="163633540"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:58:19 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lai Yi <yi1.lai@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] EDAC/skx_common: Remove redundant upper bound check for res->imc
Date: Thu, 31 Jul 2025 22:55:32 +0800
Message-ID: <20250731145534.2759334-6-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
References: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following upper bound check for the memory controller physical index
decoded by ADXL is the only place where use the macro 'NUM_IMC' is used:

  res->imc > NUM_IMC - 1

Since this check is already covered by skx_get_mc_mapping(), meaning no
memory controller logical index exists for an invalid memory controller
physical index decoded by ADXL, remove the redundant upper bound check
so that the definition for 'NUM_IMC' can be cleaned up (in another patch).

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index dffd75144060..44f5b5402e31 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -207,7 +207,7 @@ static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
 		res->cs      = (int)adxl_values[component_indices[INDEX_CS]];
 	}
 
-	if (res->imc > NUM_IMC - 1 || res->imc < 0) {
+	if (res->imc < 0) {
 		skx_printk(KERN_ERR, "Bad imc %d\n", res->imc);
 		return false;
 	}
-- 
2.43.0


