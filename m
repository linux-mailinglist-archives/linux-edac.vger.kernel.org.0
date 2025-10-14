Return-Path: <linux-edac+bounces-5045-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2B0BDA5CE
	for <lists+linux-edac@lfdr.de>; Tue, 14 Oct 2025 17:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 921C04EB595
	for <lists+linux-edac@lfdr.de>; Tue, 14 Oct 2025 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B142FBDE9;
	Tue, 14 Oct 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluematt.me header.i=@bluematt.me header.b="bO76bOGD";
	dkim=pass (2048-bit key) header.d=clients.mail.as397444.net header.i=@clients.mail.as397444.net header.b="UOPxHsXW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3AB23C50A
	for <linux-edac@vger.kernel.org>; Tue, 14 Oct 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.59.18.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455482; cv=none; b=jDCX6kwDfiQkqSq71/uwCTAzhGDMIOZFPt4fFdwUcAixGO1KS+01eU9JFN/IIa5a/x8S7oHGv7CAa0v1h5IMznjm1JnkUWsAEaY6OQy0LbJDyX1JXh3ouFy0B5hMgaBqKHYeJH+suowsNI4CLFNmbpUkjFOfwIunX+fF1ehoNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455482; c=relaxed/simple;
	bh=pN9r2R2hx3achOjOKAVt05mZ7Kqu6Z95kgwVyE9HPHo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Z3Yo0vv7wjzfdByEYleC5poxRWoRyu8RyltOm6/a03bDlxN+49ub71S2JWX7CrqN4YT3pwPCBwqt3VJivObsNHIBce2p5vH8E4OsUdHWPHNB4BnECvTVHIadCe9PdK8v95LZpkIlHZhV+9eqhETkgzLk1th0enD9ZMPWna5f1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluematt.me; spf=pass smtp.mailfrom=bluematt.me; dkim=pass (2048-bit key) header.d=bluematt.me header.i=@bluematt.me header.b=bO76bOGD; dkim=pass (2048-bit key) header.d=clients.mail.as397444.net header.i=@clients.mail.as397444.net header.b=UOPxHsXW; arc=none smtp.client-ip=69.59.18.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluematt.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluematt.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
	; s=1760454061; h=Subject:From:To:From:Subject:To:Cc:Cc:Reply-To:In-Reply-To:
	References; bh=66GOyVF89Ab7SKll2RVWM7ast3QXlTRjGoKDoRo5MZ0=; b=bO76bOGDVMsjrP
	WQx/3UHiXWWYVQAzy/ucieUuzmVHDkP5TASoQS0rA0dMH+JN5YtaFR8TCP0y1TmSL6KxfcaQOK7eN
	YKk6Uh9wyRW2A7HYOXIxpCie1CZtZh5qL7Dmk8QgUx+iZEwHY8+ve0vPBcA1xKOdHBr5wYnwYeXzY
	KQNfZejJ5VQqmxjyQ6UYKdZoEfkGWG9keL12HjmExytIa9NV5R8vwfRkouNRs/6OmENwdi3XL4ZhQ
	groAIKEzJbSF8us7V3q963njs0LoCUMs+pPBrbjI6M6VfIZ3JX0PEW9o+UQZ12NLhepJ+wiX3yDxj
	dM+6VU/Vyirj1ca9nYBw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=clients.mail.as397444.net; s=1760454064; h=Subject:From:To:From:Subject:To:
	Cc:Cc:Reply-To:In-Reply-To:References;
	bh=66GOyVF89Ab7SKll2RVWM7ast3QXlTRjGoKDoRo5MZ0=; b=UOPxHsXWApu1zZklOewaOKciFW
	o1gpugCD+/5SSbux6YLvfzQdt+n/rZZ6t8zmvTjKu3n4os3Q9LA7MtVqWWsDx3YHUuzkvSuHHVMcb
	AKbXe2D3np8tQoDglepG9KThp9eWom4pJq35+DRCPzW3FW3Fvljt9D8hkzUubRqmTHhCFS51Gds+W
	HZLzknxH6ioY8LnA0VKvoNB95UCzaN5cXxjW/EARBEnsa3Xdpl9lqthUt/D8nIVz6GcoX5Wo+EEfx
	cU2O7RrBQChmXj75+4+boVNI9azMMOpKI5oGTnxP0UODz7ygxu71skzOR/RMEw7H2TTshl1sK4ydZ
	4uCnjwcg==;
X-DKIM-Note: Keys used to sign are likely public at
X-DKIM-Note: https://as397444.net/dkim/bluematt.me and
X-DKIM-Note: https://as397444.net/dkim/clients.mail.as397444.net
X-DKIM-Note: For more info, see https://as397444.net/dkim/
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
	(envelope-from <git@bluematt.me>)
	id 1v8gUg-00000004h8U-2IaJ for linux-edac@vger.kernel.org;
	Tue, 14 Oct 2025 14:59:21 +0000
Message-ID: <8ae4f35a-0cec-455f-8f2c-ce04fb99aa40@bluematt.me>
Date: Tue, 14 Oct 2025 10:59:20 -0400
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-edac@vger.kernel.org
From: Matt Corallo <git@bluematt.me>
Subject: [PATCH] EDAC/ie31200: Add support for additional Alder Lake-S CPUs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

180f091224a002f8bd1629307c34619a5626841e added support for some but
not all Alder Lake-S SoCs. This adds support for, at least,
the i5-12600K which works with the existing Alder Lake-S config.

Signed-off-by: Matt Corallo <git@bluematt.me>
---
  drivers/edac/ie31200_edac.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 5c1fa1c0d12e..010317e33738 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -99,6 +99,7 @@

  /* Alder Lake-S */
  #define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
+#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_2	0x4648 /* e.g. i5-12600K */

  /* Bartlett Lake-S */
  #define PCI_DEVICE_ID_INTEL_IE31200_BTL_S_1	0x4639
@@ -761,6 +762,7 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
  	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_6), (kernel_ulong_t)&rpl_s_cfg},
  	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_HX_1), (kernel_ulong_t)&rpl_s_cfg},
  	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_2), (kernel_ulong_t)&rpl_s_cfg},
  	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_1), (kernel_ulong_t)&rpl_s_cfg},
  	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_2), (kernel_ulong_t)&rpl_s_cfg},
  	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_3), (kernel_ulong_t)&rpl_s_cfg},
--
2.47.3

