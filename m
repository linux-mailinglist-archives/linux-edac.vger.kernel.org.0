Return-Path: <linux-edac+bounces-2643-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2C19E532B
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 11:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293AD167480
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7891D4607;
	Thu,  5 Dec 2024 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="O0Z4eszH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965351D8DE8
	for <linux-edac@vger.kernel.org>; Thu,  5 Dec 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396285; cv=none; b=Pkd9c9NfSRbXVCyzxW5pu5arTMcfvWOoPhYfNs/Tn6Iw0164oN+uwDZp8i5owCduPFG8KvP3CRJahwxEA2xXssj91wqeuak0XHOt5Ezkax43fdP9L9SMftTUy9UKoerBPJBCw4reSxKDhlqqG7e1IQ+x/YOTchAaUdehIEAP358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396285; c=relaxed/simple;
	bh=BUl96l5hoJvj09h20wDnj/veQYHqaKmniZqjrv28g9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VUrHyN1+Uwf8+xcSI3+km6B3vmFpuzSOycc+tsi5jf3yzQ5dGa57UGz96AGmcJlniBl+RM4bqvunVQdf6LXzbhtNodt1bFqqZLenzRguwLXBeKufpWdwgiEgssEVVnHTSR9qyPP1El9v1mU0jiHAVrCMO1g6+J5tJhngip6ZCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=O0Z4eszH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7258cf297d4so740604b3a.2
        for <linux-edac@vger.kernel.org>; Thu, 05 Dec 2024 02:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733396283; x=1734001083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XSRnnX5MigbfA7DvywfPuE7f6sgzsM2APKn3A+6tU5M=;
        b=O0Z4eszHTsh2UB23TaOtK8Uu4e/EjVxuxY8Mv5/Yygi+rYRzozlie1PPz/0OOc6xiY
         ZYW2/QxRYOQOMBJJtWpnMZQ9dLlcSBHTgzJ0nwpsLHxdQUbsv5WOl8PjnPpT68xEVbqB
         CSSY8gPsfbsWYK6+0LZytzYpLPunreNg4v+hgH1pQTs+FovCJXfln4zyQEEy4T3MrpZ+
         u5xX91+3i6wxo6G+h9dWqLk/R9TENcoZPIpALGfsEGJF007mF43yccSTEgMlI7sY8V1e
         1efiwT15xdiJOB8glvYP3hYhbBiRlWuFBbGSPK4yBgjAcwBpkBgTg3wnc1PKsHkAcdki
         +Q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733396283; x=1734001083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSRnnX5MigbfA7DvywfPuE7f6sgzsM2APKn3A+6tU5M=;
        b=OAPrH7nC9v6r8xrTPXnUki/dwGB/G7ZRHeYaKh27nFTPR0pdotgPHy7ZNKX3GqB3up
         WA3+nBuJSQUjjEjJiJvfti7+a4xGiPI14GirDo+psl3X8deL1DmD5+qop320gnAkgEhA
         EuPEpTIc6fEmJFoA7O4bSoMPEVoGbJWeEkzoJQRM+y/8lHVXuXRzGISZDYqMst8EzVtU
         pwe+mo20t1LIwhyLbk3RALAgdRP0dC0N//1T+QWSelZpc7DCVkAPi0dEPCbvaIv8IrP1
         kZ/5QUZ1gGj3kjiimyws4wkcJ4I2vAk8oIZOEDuZ57AqoB9wiZEtsfY4ntz+PeGS+6pF
         o+Cw==
X-Gm-Message-State: AOJu0YyOQ75ORUsHCjhIi0FzZt5Bg5EsYC4i7dFOQuzc6NZXSmYA3qlT
	6aUefOlQJpouSORLF+nIp4CjqFH40E5Pz/tdWCqYQwW+9w6oGNwyltj7ZsP1UrYzb5MjNoo9Zsj
	omGA=
X-Gm-Gg: ASbGncuXoqtv7XcO5u2R/atlpcxoHpmenMUYNbIJd4Rowwu91TMb4CD9BcI37hYzg9P
	luXlTZGg2fS8DK7ieeWj8LY4sV/uiarUO/zTkIyFE8vn48GD6OcXdtUXyH1QQrBf0thVr4pb9ae
	F6ziSrLBxIEQGfLCJMgvx8r3DvWoUq/JwLlW71rv9OHMbdNQURF5JRdMipV43o3T+ea/+4aJ7cw
	cElHftD3jyeyi+pCsGSdB2b1XUlHD8ObbxZleKWsexU/9hC3ZYAR1a6fwVnwZfxk0M/3xVCy3o3
	9fuWK3C1cRxztAICX8V6ZAEu6LHoXEXz3Qed
X-Google-Smtp-Source: AGHT+IHvGXlpo10YsJQqhosmAbsXgZAH1gf7krJgBqdWkWeFx5oEnkdHFYoE3/XH+wGQTDak2gePjw==
X-Received: by 2002:a05:6a00:3cd5:b0:725:9ec3:7ed9 with SMTP id d2e1a72fcca58-7259ec3812bmr2477287b3a.21.1733396282848;
        Thu, 05 Dec 2024 02:58:02 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a904dfsm979914b3a.95.2024.12.05.02.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:58:02 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: talel@amazon.com,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org
Cc: linux-edac@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] edac: al_mc: free mem_ctl_info on error path in .probe()
Date: Thu,  5 Dec 2024 19:57:54 +0900
Message-Id: <20241205105754.3408880-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In al_mc_edac_probe(), the mem_ctl_info allocated by edac_mc_alloc() is
not freed in the error path, resulting in a memory leak. Add a
edac_mc_free() call to fix this.

Fixes: e23a7cdeb3da ("EDAC/al-mc-edac: Add Amazon's Annapurna Labs Memory Controller driver")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/edac/al_mc_edac.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/al_mc_edac.c b/drivers/edac/al_mc_edac.c
index 178b9e581a72..3908e999f4ff 100644
--- a/drivers/edac/al_mc_edac.c
+++ b/drivers/edac/al_mc_edac.c
@@ -240,7 +240,7 @@ static int al_mc_edac_probe(struct platform_device *pdev)
 
 	ret = devm_add_action_or_reset(&pdev->dev, devm_al_mc_edac_free, mci);
 	if (ret)
-		return ret;
+		goto free;
 
 	platform_set_drvdata(pdev, mci);
 	al_mc = mci->pvt_info;
@@ -288,12 +288,12 @@ static int al_mc_edac_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"fail to add memory controller device (%d)\n",
 			ret);
-		return ret;
+		goto free;
 	}
 
 	ret = devm_add_action_or_reset(&pdev->dev, devm_al_mc_edac_del, &pdev->dev);
 	if (ret)
-		return ret;
+		goto free;
 
 	if (al_mc->irq_ue > 0) {
 		ret = devm_request_irq(&pdev->dev,
@@ -306,7 +306,7 @@ static int al_mc_edac_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to request UE IRQ %d (%d)\n",
 				al_mc->irq_ue, ret);
-			return ret;
+			goto free;
 		}
 	}
 
@@ -321,11 +321,15 @@ static int al_mc_edac_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to request CE IRQ %d (%d)\n",
 				al_mc->irq_ce, ret);
-			return ret;
+			goto free;
 		}
 	}
 
 	return 0;
+
+free:
+	edac_mc_free(mci);
+	return ret;
 }
 
 static const struct of_device_id al_mc_edac_of_match[] = {
-- 
2.34.1


