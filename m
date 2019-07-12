Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CC16654B
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2019 05:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfGLDtR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Jul 2019 23:49:17 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38316 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbfGLDtR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Jul 2019 23:49:17 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E542C891B1;
        Fri, 12 Jul 2019 15:49:14 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1562903354;
        bh=sjIrtkXOecwRkfajzSvvCDpSjufAKPvEm/9Csb/bOE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=1H06nfnrXbZm6LizewR5JzBRAKcylRnYFwJvf6S5rxs+TiIeCZGPM/jnzzs7GKu8e
         aM/Lw6e70axfgmd53zHQwcY+SSk1tF5TizfXb9rlWTWTsdXBD7DPZkwgsqHAXcuDqK
         YVE9dd2v/wO6X/Qvzf0i9gzwJWXOjzN2qUJIMkZqvzcWRPL8V/55O1R4Rmbu/ZTfBm
         YW+XDrSAeoY0nrVokBnXh7DObDzmh/YNor9B2Hx1go3mkTKWO4SG6hpsiTizLLlxlc
         AqqyhU57tDXkax0ctjmsDcqdT6lqsggSjcEJp8nq6R98t1ebIi3mshFMRbY+U8Tp97
         4TLw99lCGwU7Q==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d28033a0004>; Fri, 12 Jul 2019 15:49:14 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 15BEA13EF9B;
        Fri, 12 Jul 2019 15:49:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4D6901E1D7A; Fri, 12 Jul 2019 15:49:14 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     bp@alien8.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, patches@armlinux.org.uk, mchehab@kernel.org,
        james.morse@arm.com, jlu@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 4/8] dt-bindings: ARM: document marvell,ecc-enable binding
Date:   Fri, 12 Jul 2019 15:49:00 +1200
Message-Id: <20190712034904.5747-5-chris.packham@alliedtelesis.co.nz>
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

Add documentation for the marvell,ecc-enable properties which can be
used to enable ECC on the Marvell aurora cache.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v7:
    - remove marvell,ecc-disable
    Changes in v6:
    - new (split binding doc from implementation).

 Documentation/devicetree/bindings/arm/l2c2x0.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.yaml b/Document=
ation/devicetree/bindings/arm/l2c2x0.yaml
index bfc5c185561c..913a8cd8b2c0 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.yaml
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.yaml
@@ -176,6 +176,10 @@ properties:
     description: disable parity checking on the L2 cache (L220 or PL310)=
.
     type: boolean
=20
+  marvell,ecc-enable:
+    description: enable ECC protection on the L2 cache
+    type: boolean
+
   arm,outer-sync-disable:
     description: disable the outer sync operation on the L2 cache.
       Some core tiles, especially ARM PB11MPCore have a faulty L220 cach=
e that
--=20
2.22.0

