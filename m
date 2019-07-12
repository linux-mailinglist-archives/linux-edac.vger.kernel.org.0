Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A256F6653F
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2019 05:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfGLDtR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Jul 2019 23:49:17 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38306 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbfGLDtR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Jul 2019 23:49:17 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C04FB891AF;
        Fri, 12 Jul 2019 15:49:14 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1562903354;
        bh=ShjLEsSOa7bT84GECNNvZx6dj9lSEuESZh2K8B+Vl40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Sp9AHedy/8UVM1IZGhKUET1JRx4IzYAqZ1I3YjKpta9+YU8gZuGhk9XFzCSIK6pTz
         h+IC2trCGrA2uFKXetwowRsIVQcrdjRi9NEAVUww2I7KpRqtZ8b2BNdk9v/2dLfM1t
         TJ85NgjlBlxWDR7WigCCbfbMQVFk9xMt6c1E9P3H2x/4uG7nLN3WSJhVrF9DDftnIR
         p34ID1W3ZpPOaDW8VbbE0v+BnjCrOJjNPw0ZcPjJwX2/D72OSxWCJpeZGXsFmB8jT9
         JLmmZbmzOQCDqRgE2JLaDtZvlzaZ6icISV51bS9CqBui4zDXkYH6YtFwmsHlA1HgEV
         d2RcfISyXacng==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d28033a0003>; Fri, 12 Jul 2019 15:49:14 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 110DA13EECF;
        Fri, 12 Jul 2019 15:49:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 488211E1D7A; Fri, 12 Jul 2019 15:49:14 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     bp@alien8.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, patches@armlinux.org.uk, mchehab@kernel.org,
        james.morse@arm.com, jlu@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v9 3/8] ARM: l2x0: support parity-enable/disable on aurora
Date:   Fri, 12 Jul 2019 15:48:59 +1200
Message-Id: <20190712034904.5747-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The aurora cache on the Marvell Armada-XP SoC supports the same tag
parity features as the other l2x0 cache implementations.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
[jlu@pengutronix.de: use aurora specific define AURORA_ACR_PARITY_EN]
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 arch/arm/mm/cache-l2x0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 83b733a1f1e6..46a616ec6b0c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1493,6 +1493,13 @@ static void __init aurora_of_parse(const struct de=
vice_node *np,
 		mask |=3D AURORA_ACR_FORCE_WRITE_POLICY_MASK;
 	}
=20
+	if (of_property_read_bool(np, "arm,parity-enable")) {
+		mask |=3D AURORA_ACR_PARITY_EN;
+		val |=3D AURORA_ACR_PARITY_EN;
+	} else if (of_property_read_bool(np, "arm,parity-disable")) {
+		mask |=3D AURORA_ACR_PARITY_EN;
+	}
+
 	*aux_val &=3D ~mask;
 	*aux_val |=3D val;
 	*aux_mask &=3D ~mask;
--=20
2.22.0

