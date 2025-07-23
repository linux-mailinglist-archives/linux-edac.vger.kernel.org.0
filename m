Return-Path: <linux-edac+bounces-4415-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64308B0EA99
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jul 2025 08:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DAF1C8165E
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jul 2025 06:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F31826C391;
	Wed, 23 Jul 2025 06:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDIKKI5e"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814917BA6;
	Wed, 23 Jul 2025 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251998; cv=none; b=cSYFRic3DUIYYpcJmXMy0Bg7YiEXXwML3sxL3x57duY6Aw1TxsD3MmtojoAkqLd1plCB/9KsukDMVvNVHDB9xbD3km5EfUnNCZ+sEcFzWmuwrNl+Sj71cmeblstJfW2QV584bS00GnFLiQLb5mezqFv4rT+RMN/owlLUcuTqqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251998; c=relaxed/simple;
	bh=ux9IkYfq1lY2FiVA9kzE3G4S1pelAI1ZDTYrto6gpJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0yTHpVmey5uV8qihEXFCciKsUwgKQZUIkgfyQVG5MqY73eZynVTUxKYw2hpNKITPjOJiUz9mblWYdz8NZLXqQn72eGWwYdAIlkg1WcER0h8YwNpH9C4LVLK2T0ZoVCwUJhENuh7y9/LiMHCEvJY+CAqC/Rxck39aHxLfK1RKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDIKKI5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E9DC4CEE7;
	Wed, 23 Jul 2025 06:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753251995;
	bh=ux9IkYfq1lY2FiVA9kzE3G4S1pelAI1ZDTYrto6gpJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KDIKKI5eT8iSUpJNzcxlHA1VMrIJrgaWeZvSOfA/GgbIY/8sYi8vGgpcXWp90HnBO
	 jEfQ6uYSc+OF2X22AdpsiPsbkd5s9LnzPs7/64aqq48+hc76zWhjPKK9E8TO9fRc9J
	 45G05yK4CnyNDtPTCdoJKgJfxKxjQ6bPetZkzvrtSXdD3gbq2FjWD3nsV5lRvS4S9G
	 +ysgD4ko4YkV5f4KXd++YbQpMoH7yYW02wU3/hMLU3xbJPS2VdRSCs0kzh73EnaWsH
	 YPjU7WdKYtu+EuLHBzzTK71q83mQKFUV/uE+KqWuXA/T0k37kyr3Z13aB/FPmtxBZg
	 3vy28dDOL/Hug==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH -resend] edac: Use dev_fwnode()
Date: Wed, 23 Jul 2025 08:26:31 +0200
Message-ID: <20250723062631.1830757-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_create_simple() takes fwnode as the first argument. It can be
extracted from the struct device using dev_fwnode() helper instead of
using of_node with of_fwnode_handle().

So use the dev_fwnode() helper.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Link: https://lore.kernel.org/all/4bc0e1ca-a523-424a-8759-59e353317fba@kernel.org/

---
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/altera_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index cae52c654a15..cfd17a8e5865 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2131,8 +2131,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	edac->irq_chip.name = pdev->dev.of_node->name;
 	edac->irq_chip.irq_mask = a10_eccmgr_irq_mask;
 	edac->irq_chip.irq_unmask = a10_eccmgr_irq_unmask;
-	edac->domain = irq_domain_create_linear(of_fwnode_handle(pdev->dev.of_node),
-						64, &a10_eccmgr_ic_ops, edac);
+	edac->domain = irq_domain_create_linear(dev_fwnode(&pdev->dev), 64, &a10_eccmgr_ic_ops,
+						edac);
 	if (!edac->domain) {
 		dev_err(&pdev->dev, "Error adding IRQ domain\n");
 		return -ENOMEM;
-- 
2.50.1


