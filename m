Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010DC30D0F
	for <lists+linux-edac@lfdr.de>; Fri, 31 May 2019 13:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfEaLH0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 May 2019 07:07:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41432 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaLHZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 31 May 2019 07:07:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so6003554pfq.8;
        Fri, 31 May 2019 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3XLypKZbOE7b5olH8wFcYwlI02ktNrldwBXglURa3w=;
        b=lHiHrqK+uViC8OiKvrCBGMdg+3KUxbeaoMdBR9G3r7DDdhdHCWZlBwEruPUhlMir17
         Qz5pCkS2HG5iRE0uQSWVR7VXZD3/bIKe9xkb/oyS6CtnXNTDlGF9wtjFGJ+rg6kx5cGo
         e8IXax9hChGsOHhamwbfPHy53atRzmBqILApH9u0JjvZoDCkGdRXdc71L9iLn6DU16EB
         A4ChSnATzc/jt9S2BVk0Mc23nXWVt/KXYfwR3bvufUJU1jvUMTpgBEztR+29wnsBn7oq
         SO4LcXqg1qR78jQlp/sxHf0qmrZlZUtyTjM8rDYW5dkwWAaXedWo683BB4XZWywE3F/x
         dSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3XLypKZbOE7b5olH8wFcYwlI02ktNrldwBXglURa3w=;
        b=LZShddEmWFxOck3zEEzApY0koHrXK3/qm8O5oCUJyfOSllEPcMUcx1/K2XSnmY78YC
         ZxM7zVTA0Jg7lK1VP673s7OcWHFiv8q5ykpcK2WAy8s/64sESIzRi7xwW69/lAs1NmVH
         JfbC7yVyaLXC6iamYMdiB/BD+0m7F9KrrD4cKr2TL1m72WwZpk21Vqxs8dP6GF+7o6CG
         TNvWnKIXjabz10zKDt/Lyo6UUEnkEC8CTtbIyXdZ6Nzw7QzcQow2b0Wnf4TXB+V0Y/zP
         zhKSFVql+jAX66eS9644+NMwX2lg4ByoqLACkVfYl6G0c1LnOtGnNbOfuFMjfUdjGK4H
         8PZQ==
X-Gm-Message-State: APjAAAX3n/Ys7hE8jWJP3qARKoZVoKx9RfQqugNhx1rPDOM3gew8RztX
        UIrkPcffLCGgG5iA57y536UbQ29c
X-Google-Smtp-Source: APXvYqwn5yPSgzvGRCcYV/dlqhtIVtN/RtQ26toKdzTtPidYxbb2Fep4gETMKhIlv49QpMXv1S05vg==
X-Received: by 2002:a17:90a:d681:: with SMTP id x1mr8217068pju.13.1559300844098;
        Fri, 31 May 2019 04:07:24 -0700 (PDT)
Received: from george-Quanta.com.com (220-135-135-179.HINET-IP.hinet.net. [220.135.135.179])
        by smtp.gmail.com with ESMTPSA id r7sm8003157pjb.8.2019.05.31.04.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 May 2019 04:07:23 -0700 (PDT)
From:   George Hung <ghung.quanta@gmail.com>
To:     linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     benjaminfair@google.com, wak@google.com, Avi.Fishman@nuvoton.com,
        tomer.maimon@nuvoton.com, Richard.Tung@quantatw.com,
        Buddy.Huang@quantatw.com, Fran.Hsu@quantatw.com
Subject: [PATCH v1 2/2] dt-binding: edac: add NPCM ECC documentation
Date:   Fri, 31 May 2019 19:03:52 +0800
Message-Id: <20190531110352.30393-2-ghung.quanta@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531110352.30393-1-ghung.quanta@gmail.com>
References: <20190531110352.30393-1-ghung.quanta@gmail.com>
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

