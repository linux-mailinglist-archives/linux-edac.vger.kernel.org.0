Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0CF35EE2
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2019 16:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfFEOQa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Jun 2019 10:16:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43952 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbfFEOQa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Jun 2019 10:16:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so4633813plb.10;
        Wed, 05 Jun 2019 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3XLypKZbOE7b5olH8wFcYwlI02ktNrldwBXglURa3w=;
        b=SRyDZBKfR6VLuQOeonUrKfw8C7A4yF0d3XMQJwjtp0LfMXI4HiCjx0WQ8U62jWYFsZ
         DVqV5Sc2DTx+3Zj9dFFodnSBWUmQP3kobhSvtrvVU105g/az29yBBuIEUz3T9B/8WRA+
         qLJyDidJIDRzrFEqrVi1UDMg+KRFLUbUnzGhXSnKQAOdIyuk7h7qVSmBBLitwr2vJI6x
         KioMQaxD5g6qwJkzEALSAZrmbyf/bpxBIRfKJDpa9Ax1xNbjtNNYhM08XxoIi+syxAjP
         NxHFkvcKZUSEF3ojvBkbCy/aOd3CiusdDnKW3y+IKuTQeEnmPpomVHvCvRTcSFJF1PML
         b97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3XLypKZbOE7b5olH8wFcYwlI02ktNrldwBXglURa3w=;
        b=iLN6D/D1z3dzEgQeda7/UXGazxbNxlRF+bzI7hLcOWVbm/+37bDlIQn36P29FHaNb5
         ppQI0FCbT5EENzPhHg41HT9XtmzOTHk9hB8OkJNaSz4T/tFSbFMsK5ENLptp9qJSGq6e
         HuSnzOIIIyVIIaULXaynq2dlxy9vPmBjzDOy/kFMKMu5+R+8TOE0N8pLKbzvl2HUbRdl
         LZ2vziheFKWLzY9Yp7ipG66VJjbOCzfUlzFRTXiacfxaL/aJOY7PQjXxZIqBB9NJhTwq
         uHLk1SskzfLCZsSdDEsMIR1JN2HM67q965I7QaFk/2QO7XVb7mBEcHpha1C58Qr/UgKk
         F+3A==
X-Gm-Message-State: APjAAAXI0tWE0eAjlM6H5eclRLrcmGpZ91QSmfagJqDgTDtjWXK/c6AD
        rqXFDYxb9rXXlR+hFtztE+fZTAnl
X-Google-Smtp-Source: APXvYqz3yeokdSf0SMdH/IVvBAh8QltwCxeaCvedVcmCsDQdM6ywLVcbm5pG9vifCmcBDxYN2Ihpcg==
X-Received: by 2002:a17:902:b18c:: with SMTP id s12mr42363782plr.181.1559744189242;
        Wed, 05 Jun 2019 07:16:29 -0700 (PDT)
Received: from george-Quanta.com.com (220-135-135-179.HINET-IP.hinet.net. [220.135.135.179])
        by smtp.gmail.com with ESMTPSA id 24sm22376443pgn.32.2019.06.05.07.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 07:16:28 -0700 (PDT)
From:   George Hung <ghung.quanta@gmail.com>
To:     linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     benjaminfair@google.com, wak@google.com, Avi.Fishman@nuvoton.com,
        tomer.maimon@nuvoton.com, openbmc@lists.ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.2 v2 2/2] dt-binding: edac: add NPCM ECC documentation
Date:   Wed,  5 Jun 2019 22:12:53 +0800
Message-Id: <20190605141253.38554-2-ghung.quanta@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605141253.38554-1-ghung.quanta@gmail.com>
References: <20190605141253.38554-1-ghung.quanta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add device tree documentation for Nuvoton BMC ECC

Signed-off-by: George Hung <ghung.quanta@gmail.com>
---
 .../bindings/edac/npcm7xx-sdram-edac.txt        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/npcm7xx-sdram-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/npcm7xx-sdram-edac.txt b/Documentation/devicetree/bindings/edac/npcm7xx-sdram-edac.txt
new file mode 100644
index 000000000000..dd4dac59a5bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/npcm7xx-sdram-edac.txt
@@ -0,0 +1,17 @@
+Nuvoton NPCM7xx SoC EDAC device driver
+
+The Nuvoton NPCM7xx SoC supports DDR4 memory with/without ECC and the driver
+uses the EDAC framework to implement the ECC detection and corrtection.
+
+Required properties:
+- compatible:	should be "nuvoton,npcm7xx-sdram-edac"
+- reg:		Memory controller register set should be <0xf0824000 0x1000>
+- interrupts:	should be MC interrupt #25
+
+Example:
+
+	mc: memory-controller@f0824000 {
+		compatible = "nuvoton,npcm7xx-sdram-edac";
+		reg = <0xf0824000 0x1000>;
+		interrupts = <0 25 4>;
+	};
-- 
2.21.0

