Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0638419B47
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2019 12:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfEJKPq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 May 2019 06:15:46 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47711 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfEJKPp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 May 2019 06:15:45 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 38EB7891B3;
        Fri, 10 May 2019 22:15:42 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1557483342;
        bh=cBmgtWPtR8bm2vfMAsIZOxpjTEg5yj09yLAca0bGPtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=09oJrTYjER+pQU8gRPvy7tUl7QtuvRCzYfjZI+XRQpmGnwsExS9DIBEi0gv9DN7rR
         C8TkNpK0HF4fD/ulmEiECSPHHPVZw2FP1tm/dk5B2ijW/mr4ULmNnuJjVgUcIJAkwb
         sf0jVWpXe808cMTuN9lXBpdVX9vJBF/HIdHGpglK8KWYulyYwF1yb5BYyW0Ta1ki65
         C42MNvkt6UNJ7u0k5RcGk+okqm+nNJStLoU8cwgFMSlU/e47s9tVXZKl2Swc2qeVEP
         mgamgeshHUi1byda7+PwznsbhMjNIIB47DD9+KnzTSUqUJdYyE+trUuKU1rWEzegjH
         4TRBaMJJo7+ew==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cd54f4c0004>; Fri, 10 May 2019 22:15:41 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 155B313EF9C;
        Fri, 10 May 2019 22:15:40 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 9E7871E1D5B; Fri, 10 May 2019 22:15:39 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, mark.rutland@arm.com,
        robh+dt@kernel.org, mchehab@kernel.org, james.morse@arm.com,
        jlu@pengutronix.de, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v8 4/9] ARM: l2x0: support parity-enable/disable on aurora
Date:   Fri, 10 May 2019 22:15:31 +1200
Message-Id: <20190510101536.6724-5-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190510101536.6724-1-chris.packham@alliedtelesis.co.nz>
References: <20190510101536.6724-1-chris.packham@alliedtelesis.co.nz>
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
index 7d2d2a3c67d0..b70bee74750d 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1505,6 +1505,13 @@ static void __init aurora_of_parse(const struct de=
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
2.21.0

