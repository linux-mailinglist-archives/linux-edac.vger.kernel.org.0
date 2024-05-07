Return-Path: <linux-edac+bounces-1013-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E0A8BF181
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2024 01:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBBA1F21CFC
	for <lists+linux-edac@lfdr.de>; Tue,  7 May 2024 23:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F713DDCF;
	Tue,  7 May 2024 23:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clvD1AIG"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F413DDCB;
	Tue,  7 May 2024 23:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123320; cv=none; b=OKkYaon3b/ACLKdeiiD4pgxJ4S3ifmee94pGZ/eelDvUYCL+xUdzKrxbWefTzOPMC7QAuKlM7/0dDooD9ljLa8Q2+BmVZpSnl1R+ROpQFe/Rz4/8oiXQY3CVXBNi8pPlH37ho61DX5I/njwg0uDoIrCah/QjnRQspsLjzlR49Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123320; c=relaxed/simple;
	bh=Y59gv7Rc89CSMZE74pEohYYOIjOs36C6I6vk3Zzo1ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lK7CbeasRl7gFs90Z8vxsnQ2401GXJOOeMys8VPdvlnocGgcvJ9t7Ddm88/QC8hLHQqGBDVIlMInfx81uGe52GZDcNr4kBnqq1uaVFuEEjnHHffdHeP7C+583uBLbltEP7umX3jZPhgqyT040mOJ3fX5e6MKf9Uz/gIDBQCtRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clvD1AIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6AFC3277B;
	Tue,  7 May 2024 23:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123320;
	bh=Y59gv7Rc89CSMZE74pEohYYOIjOs36C6I6vk3Zzo1ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=clvD1AIGi4P/iI0mCXcRBrAoafjve7/Zr21OkI2P/1CNMRQQQ/p++XYTq/cGxAMOG
	 niCHlgwlZOeo0O1EtlsBoVqAFgUgTfsOk0I3RN4Ff8+awP3WXbPNxjmbNz7/3Diurj
	 Sb+uymkfLCjS9aG7pK5NCG6v6T6VVsHuOU7vo3ynxkkhHN2u56/Nos+uY31TKfKsbk
	 DPa4QG+nqseqp45YApoH1zaoRBaJzC6Sy4rBmEO992SEZu94VzT0rGz3fRd+6GFLvs
	 PxSHG3vNBIKA/Kk2htet8MOMEjD5xBt41xO7Uof0NQMd6w2NPY7NZEdW0W/3slBh09
	 uWTy2e8rkfWVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	sai.krishna.potthuri@amd.com,
	linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 21/52] EDAC/versal: Do not register for NOC errors
Date: Tue,  7 May 2024 19:06:47 -0400
Message-ID: <20240507230800.392128-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

[ Upstream commit edbe59428eb0da09958769326a6566d4c9242ae7 ]

The NOC errors are not handled in the driver. Remove the request for
registration.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240425121942.26378-2-shubhrajyoti.datta@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/versal_edac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 62caf454b5670..6e8d641a91e7b 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -1006,8 +1006,7 @@ static int mc_probe(struct platform_device *pdev)
 	}
 
 	rc = xlnx_register_event(PM_NOTIFY_CB, VERSAL_EVENT_ERROR_PMC_ERR1,
-				 XPM_EVENT_ERROR_MASK_DDRMC_CR | XPM_EVENT_ERROR_MASK_DDRMC_NCR |
-				 XPM_EVENT_ERROR_MASK_NOC_CR | XPM_EVENT_ERROR_MASK_NOC_NCR,
+				 XPM_EVENT_ERROR_MASK_DDRMC_CR | XPM_EVENT_ERROR_MASK_DDRMC_NCR,
 				 false, err_callback, mci);
 	if (rc) {
 		if (rc == -EACCES)
@@ -1044,8 +1043,6 @@ static int mc_remove(struct platform_device *pdev)
 
 	xlnx_unregister_event(PM_NOTIFY_CB, VERSAL_EVENT_ERROR_PMC_ERR1,
 			      XPM_EVENT_ERROR_MASK_DDRMC_CR |
-			      XPM_EVENT_ERROR_MASK_NOC_CR |
-			      XPM_EVENT_ERROR_MASK_NOC_NCR |
 			      XPM_EVENT_ERROR_MASK_DDRMC_NCR, err_callback, mci);
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
-- 
2.43.0


