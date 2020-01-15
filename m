Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357E313C60D
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 15:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgAOOc3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jan 2020 09:32:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46810 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgAOOc3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 15 Jan 2020 09:32:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id n9so8595607pff.13;
        Wed, 15 Jan 2020 06:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AW5FEWoDJwDFc/WQwLsHxIf6AFLLut1rZzzGZ9vWOpY=;
        b=H6iKcKmTgboAXSO3Px7Tko+E1/lxGnivawh6bq1dbGVlTRFloV0UFqmnvqqaxIbLwF
         +lp1/xvTk8qPwgyDZkRxZJm+5iUdCcOA8o27z2sn8QXrDtaqP2gK+J0U9nHmUIBDEGIc
         ZBaY6OeKAcZHHT9QqZ/6eQOYb2y1DIFGPgzK43GeEQG5dPRgNz1X0eaxQhQPmz6fzqr9
         Dh8mhnTTOJq9Fxb4hz3E50ZkvA42bMliqXCyO9xSVhjuG4Dr544c3+mV5cfCGgRgUvwP
         pA+q7Mtd5FXd+SNiu0jZT0VDr9deTg/9vg5k6wHooz7f3SDZxLIWgiEtufYzZovdh3vm
         iEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AW5FEWoDJwDFc/WQwLsHxIf6AFLLut1rZzzGZ9vWOpY=;
        b=XDj4O2E02LnXYw2PUCodhcp425m/VwXH92mjkPhy39xlqrCTwnfD0wWIXF8ExYBfE8
         z70q/qR+JjTwLUFrEZ7RBeLgvVQda7UGfzEin0d940vzs2RtrzOhXLqzWnLRuIw/nBGP
         NnPtaM4VyHDPmsWrGj0AMcGXNBoEYW7sbGUsvr8ZvclTeepWP0OZUZ8sVmh9R7QSysTZ
         8TpOeMa3mM8t7IrZNfy0j+GqKWJBx6kYCv8zpQDWzllJ2Xij2tmS+UOyENYv4gy5I7Jr
         H3tbxCpMI/vha6fZ8THbQjaoya4fDg4Eu/VuCl3AVueKNvzYAgB74uxQFkR25G02rD6G
         xbaw==
X-Gm-Message-State: APjAAAVgfpV7HBcpV68NJwJ/71t+2N6fhrjLfZVKL+2jpml+DvRom13x
        8rP99pqfdAZ6cPtJpf04l7k=
X-Google-Smtp-Source: APXvYqwcJjGoZ4pMhGfBXSdq11PcQoKPSLEcaN0RUFkJDuX2//TLd9pCarwi0wqtUHwekcWjkpW1aQ==
X-Received: by 2002:a62:1c88:: with SMTP id c130mr31762846pfc.195.1579098748572;
        Wed, 15 Jan 2020 06:32:28 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:acd4:5c73:b928:d080? ([2001:4898:80e8:9:2ce3:5c73:b928:d080])
        by smtp.gmail.com with ESMTPSA id l10sm29297pjy.5.2020.01.15.06.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 06:32:27 -0800 (PST)
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com
From:   Shiping Ji <shiping.linux@gmail.com>
Subject: [PATCH v9 1/2] dt-bindings: edac: arm-dmc520.txt
Message-ID: <4fbf026a-4878-cd65-55f7-7d992782b331@gmail.com>
Date:   Wed, 15 Jan 2020 06:32:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This is the device tree bindings for new EDAC driver dmc520_edac.c.

Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
Signed-off-by: Lei Wang <leiwang_git@outlook.com>
Reviewed-by: James Morse <james.morse@arm.com>

---
     Changes in v9:
         - Replaced the vendor specific interrupt-config property with interrupt-names

---
 .../devicetree/bindings/edac/arm-dmc520.txt   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/arm-dmc520.txt

diff --git a/Documentation/devicetree/bindings/edac/arm-dmc520.txt b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
new file mode 100644
index 000000000000..4a673f091918
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
@@ -0,0 +1,22 @@
+* ARM DMC-520 EDAC node
+
+Required properties:
+- compatible  : "brcm,dmc-520", "arm,dmc-520".
+- reg   : Address range of the DMC-520 registers.
+- interrupts  : DMC-520 interrupt numbers. The example below specifies
+     two interrupt lines for dram_ecc_errc_int and
+     dram_ecc_errd_int.
+- interrupt-names : This is an array of names corresponding to the interrupt
+     line numbers. The valid interrupt names are the followings:
+     ram_ecc_errc, ram_ecc_errd, dram_ecc_errc, dram_ecc_errd,
+     failed_access, failed_prog, link_err, temperature_event,
+     arch_fsm, phy_request
+
+Example:
+
+dmc0: dmc@200000 {
+ compatible = "brcm,dmc-520", "arm,dmc-520";
+ reg = <0x200000 0x80000>;
+ interrupts = <0x0 0x349 0x4>, <0x0 0x34B 0x4>;
+ interrupt-names = "dram_ecc_errc", "dram_ecc_errd";
+};
-- 
2.17.1
