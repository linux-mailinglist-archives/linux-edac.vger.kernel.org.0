Return-Path: <linux-edac+bounces-1140-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B28D0148
	for <lists+linux-edac@lfdr.de>; Mon, 27 May 2024 15:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A4BB276FE
	for <lists+linux-edac@lfdr.de>; Mon, 27 May 2024 13:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4612D15ECEE;
	Mon, 27 May 2024 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pt8k4UTl"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386D13BAC2;
	Mon, 27 May 2024 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816168; cv=none; b=LGQyQTLMIWZCsN18/5w2JESDyNDR0z52mVLGArr0sPVrLnPaCB+Hr33KkFCkQ8JBprBOIl/qoC5voWEkXa7RI2FPzcRa6p36JVsPraULBR4AJuETtKKltw8Gw/SzkfTFwUn4R4KZxZ1rika0I2zKyVPWvlVGPxU78wtpa5PijuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816168; c=relaxed/simple;
	bh=1fUsgjmy0HwSjUNwgAEgVrkX83AtUHExHKTskQldwu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D82wnb3RVIdip6zHpddHnKzZlWti2EB+TQJD1AlVBByJAtW4ozGYMaVQW1m/TVHwZyzoWLQTsmm5sDTg1fBaF6/67xJ0SSh0M0YBJhPvBfeMT1pjHVHdY9fgZAWAAf3A1cC2SspvuGttaRMMcbVWQ6vIsILLGbZEIMz6oOGF0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pt8k4UTl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816166; x=1748352166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1fUsgjmy0HwSjUNwgAEgVrkX83AtUHExHKTskQldwu8=;
  b=Pt8k4UTlbnlaFgonvn609LfYBebOhaT2boSzng0U7qXIv8DF7Kp2ped/
   E4NxIza4/BePtCUU4WLZOOczLn4zu0Ig2KTTwo9s20hgmOSYG/X8QEOvN
   mfhXQ/268DkX7t++pHlOVHWAeRMLyN5TkJB91BfsAYl96xqkOcmg1xYW/
   C7Ek/WR6ibawdE8VI0F80OClGzE8gSxTuzAE/8uH1sB1l6971LADz+Yoz
   XA0wt0ejj6gVeIgmFOEUXINZXaXeB3ngwSHao+ClCE6hP3TnkYJYxgRb3
   ZzaRQ2OIHczOgbxTP3tNzy+31Xg0bhxxq6VXPAJGFOKPb06As6w5NC+Ef
   w==;
X-CSE-ConnectionGUID: eAoe8qImTCiyjspxLRHPBw==
X-CSE-MsgGUID: Lg3NhQjYTi+AVJkPd2xD0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13006467"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13006467"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:22:45 -0700
X-CSE-ConnectionGUID: V+Sj+DB6RGiufqFct8CSyw==
X-CSE-MsgGUID: uvfdAZLMSSOZkgYtaStOvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34787283"
Received: from unknown (HELO localhost) ([10.245.247.140])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:22:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] EDAC/amd64: Convert PCIBIOS_* return codes to errnos
Date: Mon, 27 May 2024 16:22:34 +0300
Message-Id: <20240527132236.13875-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

gpu_get_node_map() uses pci_read_config_dword() that returns PCIBIOS_*
codes. The return code is then returned all the way into the module
init function amd64_edac_init() that returns it as is. The module init
functions, however, should return normal errnos.

Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
errno before returning it from gpu_get_node_map().

For consistency, convert also the other similar cases which return
PCIBIOS_* codes even if they do not have any bugs at the moment.

Fixes: 4251566ebc1c ("EDAC/amd64: Cache and use GPU node map")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/edac/amd64_edac.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1f3520d76861..a17f3c0cdfa6 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -81,7 +81,7 @@ int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
 		amd64_warn("%s: error reading F%dx%03x.\n",
 			   func, PCI_FUNC(pdev->devfn), offset);
 
-	return err;
+	return pcibios_err_to_errno(err);
 }
 
 int __amd64_write_pci_cfg_dword(struct pci_dev *pdev, int offset,
@@ -94,7 +94,7 @@ int __amd64_write_pci_cfg_dword(struct pci_dev *pdev, int offset,
 		amd64_warn("%s: error writing to F%dx%03x.\n",
 			   func, PCI_FUNC(pdev->devfn), offset);
 
-	return err;
+	return pcibios_err_to_errno(err);
 }
 
 /*
@@ -1025,8 +1025,10 @@ static int gpu_get_node_map(struct amd64_pvt *pvt)
 	}
 
 	ret = pci_read_config_dword(pdev, REG_LOCAL_NODE_TYPE_MAP, &tmp);
-	if (ret)
+	if (ret) {
+		ret = pcibios_err_to_errno(ret);
 		goto out;
+	}
 
 	gpu_node_map.node_count = FIELD_GET(LNTM_NODE_COUNT, tmp);
 	gpu_node_map.base_node_id = FIELD_GET(LNTM_BASE_NODE_ID, tmp);
-- 
2.39.2


