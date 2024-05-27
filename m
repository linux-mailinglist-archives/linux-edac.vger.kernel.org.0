Return-Path: <linux-edac+bounces-1141-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE198D014A
	for <lists+linux-edac@lfdr.de>; Mon, 27 May 2024 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25613287D93
	for <lists+linux-edac@lfdr.de>; Mon, 27 May 2024 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECACF15EFB9;
	Mon, 27 May 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixS9/vNG"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C5E15EFB1;
	Mon, 27 May 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816175; cv=none; b=OHsoIG5MYJ8Jmx1Ujlf1Vd1f8IPFPjdL3UvIVVIxo50+NiTaYc/XNxVb4B43aNpGfpig6de+LZQ+rm+VvMaFB0I+GpSU+DfUJcekvCrKiFDugtPyT6F8Ch2r9Xo1gpmuKhXeSr3UQrpOVo8rvPcCDmcxOnYmtnB6eut8JLOpsxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816175; c=relaxed/simple;
	bh=bxzf+dpIkZaK3p2nCkES8kt9h76dLZ7ka4ApxGqVLcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYDN2065sD7X4tZdBGSdT8Ga0e5Nzc2YQxPnyklV1VQndVfGzyLAe46SR1EeGpXTEu7pnDiq7gVfYK7+rHZYdGVuqEHI3WMo/AFupJfa/tjrk526xnuxcvoRluMIaWeraSRG3OfcbXDf3zlNxmRWTk64jpuDeEnDMj7Ml4YyEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixS9/vNG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816174; x=1748352174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bxzf+dpIkZaK3p2nCkES8kt9h76dLZ7ka4ApxGqVLcs=;
  b=ixS9/vNGb2vEzHQaZuytwH55y/ZitWl/0ARDlnbUxRyK4jbWFlRKTcZH
   o91cYOOKvuNjbbB3BrCGu2QEu8DJ6OnAeic8lm7ov9d6dlYmmn1B9Qu/w
   jD9hWPoFCiU4qMYauKrwFPWmVxsDh+Hn9uuBVqKFfEWhJPQ18VS7bE/hI
   g3zk+83fJJsYiD984Aaf51gVYhTRbsXWGM9VMlLd3Ya5CBbRQe9UDXJzh
   y4IAt4pJnIg3YMoY9bcEise/BNv+cYP98KQD93vTk+qIg/VV0L810w5HC
   ZKCtNmFagOIENJSUIgXaU3N9yJt2WSct94lE5Yoi3kvCI1jQwYNsqLcdc
   w==;
X-CSE-ConnectionGUID: VQ7T/7omR8OUHrluvXymSA==
X-CSE-MsgGUID: qb6obiI5TZyXKrT3B60cRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13006495"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13006495"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:22:53 -0700
X-CSE-ConnectionGUID: ie/nKjCFQbyEIYFjCcdN3A==
X-CSE-MsgGUID: ZH9QaCHhT46PVNzkIFdfHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34787315"
Received: from unknown (HELO localhost) ([10.245.247.140])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:22:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] EDAC/igen6: Convert PCIBIOS_* return codes to errnos
Date: Mon, 27 May 2024 16:22:35 +0300
Message-Id: <20240527132236.13875-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240527132236.13875-1-ilpo.jarvinen@linux.intel.com>
References: <20240527132236.13875-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

errcmd_enable_error_reporting() uses pci_{read,write}_config_word()
that return PCIBIOS_* codes. The return code is then returned all the
way into the probe function igen6_probe() that returns it as is. The
probe functions, however, should return normal errnos.

Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
errno before returning it from errcmd_enable_error_reporting().

Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/edac/igen6_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index cdd8480e7368..dbe9fe5f2ca6 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -800,7 +800,7 @@ static int errcmd_enable_error_reporting(bool enable)
 
 	rc = pci_read_config_word(imc->pdev, ERRCMD_OFFSET, &errcmd);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	if (enable)
 		errcmd |= ERRCMD_CE | ERRSTS_UE;
@@ -809,7 +809,7 @@ static int errcmd_enable_error_reporting(bool enable)
 
 	rc = pci_write_config_word(imc->pdev, ERRCMD_OFFSET, errcmd);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	return 0;
 }
-- 
2.39.2


