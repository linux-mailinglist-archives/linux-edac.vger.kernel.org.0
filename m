Return-Path: <linux-edac+bounces-4108-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911FCAD5265
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jun 2025 12:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6693A8E09
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jun 2025 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD62777F2;
	Wed, 11 Jun 2025 10:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzo7ocgf"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD02777FD;
	Wed, 11 Jun 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638640; cv=none; b=Huj4WTAydPd+0qh36azE7SgR3zgKPmHvVUNhNiuH/Iy6VG0VSagYF99EFxFc02nE3SkuqpZR/zo+qity/IQwddtkNhWBpf8F6Zf4QdlCGtHXlhhCxm4LvCa9DqkerDniSsMwIwa13S4HFJUZ3rDhBHw4hQTzXv1vD3i3on2Q7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638640; c=relaxed/simple;
	bh=3eZ2gqR32m+KtInlYfTGSiD+DJ8C8ADbkP60LHZgtRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uydaFxZCiu4ll4hrNkfay1btC7Y1oEnQqaZ00VdnPIZZbr/qNJblrqUbefCatSKMxRLtlJxhZ/bmRwUgWTNrUgadC+Ts9b0HBWknkdb+a/kSMI4nhSbwW7k52D4uqYhlvcV+Cc9Y1guSq5B/LV0OZKqKlwaPPIMRUaqLHWDROyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzo7ocgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83030C4CEEE;
	Wed, 11 Jun 2025 10:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638640;
	bh=3eZ2gqR32m+KtInlYfTGSiD+DJ8C8ADbkP60LHZgtRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nzo7ocgf5sl3wopNxoF5k8Qj60baVPBNIRwmU6GEY8nl8ANIutdVY6jp8tGRbrjX8
	 apd/kjsuNdnA5GZ92sxC8XS5Ae8dYp+rd7j+AjIxh/G2/A1P+am7dFEAP8RluRqj8q
	 JTssHFSzFELdRXnZ6t/yMAnkeJ3U+I2mTRc3SDXUaz8Uj6Ps8v90DjNzmGJ5Cb90nQ
	 3P2cII6DRokPsaLwhDvxAVUtMEJov4lgANhbzyZShKTT8pYlr4O2zYqUaaXgf4UJB8
	 aZ52yapKn9h30hJVeJkkMi6sVvR+juQQTOUHNz12zmVG5rBX9r7xLkTllqjF8/HzqP
	 28VdlbhCqLxUA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH] edac: Use dev_fwnode()
Date: Wed, 11 Jun 2025 12:43:33 +0200
Message-ID: <20250611104348.192092-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611104348.192092-1-jirislaby@kernel.org>
References: <20250611104348.192092-1-jirislaby@kernel.org>
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
2.49.0


