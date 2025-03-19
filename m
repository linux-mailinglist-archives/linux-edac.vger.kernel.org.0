Return-Path: <linux-edac+bounces-3368-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC7A68826
	for <lists+linux-edac@lfdr.de>; Wed, 19 Mar 2025 10:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EB5423C6D
	for <lists+linux-edac@lfdr.de>; Wed, 19 Mar 2025 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87443253F3B;
	Wed, 19 Mar 2025 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJOyajWP"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB0257420;
	Wed, 19 Mar 2025 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376689; cv=none; b=NABVEulD9KVXF4rYRkYT7mN3fmgZjbk7dRs4WfG/PaW23OgQFGOjKFPtmqFLq/oToudB+L1sMACnoPt6L5Jdgzth2h9Qd9a6HHCTQ6TN15M7osKh1sNX+8NnQ9raoU4yot9CvpfValCn2TTa3CuaHawdKYCOa6eFLrL2PicWTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376689; c=relaxed/simple;
	bh=HAa9/NY8fA0dmjIjlUIydLrGLK4XXNza+lgAPO8H1IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etF45JeKS7IZVxzhuGTvFWnHWrKvhdLb0gJt22nSU7SDaugFafF4GZJ3pC63Fe4fbEJ8iniq3Vm5ESCjl783fbvDbKiGnUcV2I0/jOc/Y3jkC5QjNozs1jyWWubwaKZ7DXMx3RQiO96j1fQZkKsmkmFugojp4Ozb9VwW3nGuUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJOyajWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BDFC4CEEE;
	Wed, 19 Mar 2025 09:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376689;
	bh=HAa9/NY8fA0dmjIjlUIydLrGLK4XXNza+lgAPO8H1IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJOyajWP1OTA6AOcPiBNjXscMnyLJnI7pDXVPrjVKYKe0pUeSMqurGSvn18rojfyF
	 CRiV/dY5JmIXWil5IEoJdypthSHEurzylDE8dsgPwnkg8t2Ti8Ue555MgeRhPs5uJf
	 v5omlYcdtQfrDi8mPZe6H2ejYyX8v21/DRZC4o8rGEaUGOuHlp9B/OwCGd4k6GAGaa
	 LRrpOFkLIGyNAbDU8OuKLXCIet4xRSay7GK7XUy8j62g5RdyGgzyN6jQMPuxTocoNV
	 pNdB6fx0dTA1qWuzGyTLb/rzxTGOm9+z38tzFDytz/dDcceDs2l6kq/yPqSeSNdBU5
	 U0sBSa2CXBTMQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH v2 16/57] irqdomain: edac: Switch to irq_domain_create_linear()
Date: Wed, 19 Mar 2025 10:29:09 +0100
Message-ID: <20250319092951.37667-17-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/altera_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3e971f902363..47cea645fc91 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2130,8 +2130,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	edac->irq_chip.name = pdev->dev.of_node->name;
 	edac->irq_chip.irq_mask = a10_eccmgr_irq_mask;
 	edac->irq_chip.irq_unmask = a10_eccmgr_irq_unmask;
-	edac->domain = irq_domain_add_linear(pdev->dev.of_node, 64,
-					     &a10_eccmgr_ic_ops, edac);
+	edac->domain = irq_domain_create_linear(of_fwnode_handle(pdev->dev.of_node),
+						64, &a10_eccmgr_ic_ops, edac);
 	if (!edac->domain) {
 		dev_err(&pdev->dev, "Error adding IRQ domain\n");
 		return -ENOMEM;
-- 
2.49.0


