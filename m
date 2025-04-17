Return-Path: <linux-edac+bounces-3576-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2A2A920E4
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6085A7B34
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A32253328;
	Thu, 17 Apr 2025 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdtTZ0YJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D1253333;
	Thu, 17 Apr 2025 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902545; cv=none; b=nATObuVgfMrtSWVKpduuaORVSquQRgl1Y0SvHSytvzK/63ATfm/E4PF/6azcxSVE9Yk47WAzDu0hucmrdKj3IR8gacCq6OviFCUkAP0tUH6V7lyRSrcAPxmpfhsWT3YBXsmYGaZB/i4EVroDQisoczvC8eQr6rgqDzh+khzU2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902545; c=relaxed/simple;
	bh=omD66plwxlONjb9MPWcXYIVDgznCrMr3UorH616Y564=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLUxAs06lH+mrkqkDi994DomB862ZLyZQy20EecTOn8Ai2mjD87qX2w+Ie6XUmaLLTTfDEXJbWjGneFNbXDfRVrrF1Wn1DeZrs1KN9/PN/FHKLlJFm7tTd7gbOyVY6nFm2083RqT3eY+I7Yj6vvBnMtOCzbFRR3bbpCrYOTKWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdtTZ0YJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744902543; x=1776438543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=omD66plwxlONjb9MPWcXYIVDgznCrMr3UorH616Y564=;
  b=bdtTZ0YJjQ9RG1svu6PBNqVwCb2fCaYKlBZX7nGMj2JQ9Vz7XiqS/k64
   xULhUxLbYswrD8ReFweRbHCedO44743c4nlrzippLPMEXtKbqrenVoHv8
   svzELbFHaGj0oJmHCbbCqo5+SBwBvIACvfinUpm54mzLieJ2eEsxVLpUS
   IljO6TFeOKpP6Kd6/oqPzlNRlYnG0O9MZo7fAWqODVMXswAkTTANrI2Vz
   BhtvEFp5tAc4iYUsBdqOFJbIqEcXWkzs0R58TRaj4vl8JRkK/bsEMRUsn
   L9/xQ+4k66pYpZfKQKqIsm6KXoxtSwyASDbVUuT156aDeUZQ2+iVGc2vA
   A==;
X-CSE-ConnectionGUID: CDuuLpY1RJOdd0V8ogReFQ==
X-CSE-MsgGUID: o6gJq6TGQ6+xFmUuAuwRMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57488684"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57488684"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:09:03 -0700
X-CSE-ConnectionGUID: NwmoF8pSQUGVXEkqk3yRIQ==
X-CSE-MsgGUID: hUoBE9kARNqkLwmMbQS0uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="161876837"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 08:09:01 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Feng Xu <feng.f.xu@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	Shawn Fan <shawn.fan@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] EDAC/i10nm: Explicitly set the modes of the RRL register sets
Date: Thu, 17 Apr 2025 23:07:20 +0800
Message-ID: <20250417150724.1170168-4-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
References: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i10nm_edac driver uses the default modes (either patrol scrub read
or on-demand read) of the RRL register sets configured by the BIOS.

Explicitly set the modes during the loading of the i10nm_edac driver with
the module parameter retry_rd_err_log=2.

Tested-by: Feng Xu <feng.f.xu@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 355b527d839e..50a16ce0aa22 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -73,6 +73,7 @@
 #define I10NM_SAD_NM_CACHEABLE(reg)	GET_BITFIELD(reg, 5, 5)
 
 #define RETRY_RD_ERR_LOG_UC		BIT(1)
+#define RETRY_RD_ERR_LOG_EN_PATSPR	BIT(13)
 #define RETRY_RD_ERR_LOG_NOOVER		BIT(14)
 #define RETRY_RD_ERR_LOG_EN		BIT(15)
 #define RETRY_RD_ERR_LOG_NOOVER_UC	(BIT(14) | BIT(1))
@@ -114,12 +115,15 @@ static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable
 			rrl_ctl[2] = d2;
 
 		s &= ~RETRY_RD_ERR_LOG_NOOVER_UC;
+		s |=  RETRY_RD_ERR_LOG_EN_PATSPR;
 		s |=  RETRY_RD_ERR_LOG_EN;
 		d &= ~RETRY_RD_ERR_LOG_NOOVER_UC;
+		d &= ~RETRY_RD_ERR_LOG_EN_PATSPR;
 		d |=  RETRY_RD_ERR_LOG_EN;
 
 		if (offsets_demand2) {
 			d2 &= ~RETRY_RD_ERR_LOG_UC;
+			d2 &= ~RETRY_RD_ERR_LOG_EN_PATSPR;
 			d2 |=  RETRY_RD_ERR_LOG_NOOVER;
 			d2 |=  RETRY_RD_ERR_LOG_EN;
 		}
@@ -129,18 +133,24 @@ static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable
 			s |=  RETRY_RD_ERR_LOG_UC;
 		if (rrl_ctl[0] & RETRY_RD_ERR_LOG_NOOVER)
 			s |=  RETRY_RD_ERR_LOG_NOOVER;
+		if (!(rrl_ctl[0] & RETRY_RD_ERR_LOG_EN_PATSPR))
+			s &=  ~RETRY_RD_ERR_LOG_EN_PATSPR;
 		if (!(rrl_ctl[0] & RETRY_RD_ERR_LOG_EN))
 			s &= ~RETRY_RD_ERR_LOG_EN;
 		if (rrl_ctl[1] & RETRY_RD_ERR_LOG_UC)
 			d |=  RETRY_RD_ERR_LOG_UC;
 		if (rrl_ctl[1] & RETRY_RD_ERR_LOG_NOOVER)
 			d |=  RETRY_RD_ERR_LOG_NOOVER;
+		if (rrl_ctl[1] & RETRY_RD_ERR_LOG_EN_PATSPR)
+			d |=  RETRY_RD_ERR_LOG_EN_PATSPR;
 		if (!(rrl_ctl[1] & RETRY_RD_ERR_LOG_EN))
 			d &= ~RETRY_RD_ERR_LOG_EN;
 
 		if (offsets_demand2) {
 			if (rrl_ctl[2] & RETRY_RD_ERR_LOG_UC)
 				d2 |=  RETRY_RD_ERR_LOG_UC;
+			if (rrl_ctl[2] & RETRY_RD_ERR_LOG_EN_PATSPR)
+				d2 |=  RETRY_RD_ERR_LOG_EN_PATSPR;
 			if (!(rrl_ctl[2] & RETRY_RD_ERR_LOG_NOOVER))
 				d2 &=  ~RETRY_RD_ERR_LOG_NOOVER;
 			if (!(rrl_ctl[2] & RETRY_RD_ERR_LOG_EN))
-- 
2.43.0


