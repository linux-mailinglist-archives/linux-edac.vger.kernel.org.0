Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0301513B5EB
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 00:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgANXeC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Jan 2020 18:34:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39491 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgANXeC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Jan 2020 18:34:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so7385106pfs.6;
        Tue, 14 Jan 2020 15:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yYq+18HeUcEIJUvMzPqlCK3z7OvqDSWg2p8T6vbs7w0=;
        b=Z/ATddr3rviycwd3yUVGAxEfsWp9p9d0j4yq2F8R7+HmSNZg/V4ufcZhtmo42Mxycq
         cyRTXv/rVg7PSpwHq1G52xEDDLzNfvZOhghVR4hGtXlf9eStOd/PhOIWt7rQRFG65YZa
         zi5HQxX8eqw+DNq9qY4Q6LWpkRjLzs8i/Xe9qlJntc+4JlkLy4jgx2VrdSWWYAfC+bCc
         Mi1KsOUh951Wsee0nIXBd8DfV6FGB7iWSny+PDHJUrNVH709XEcTPIZXOshoIDnr1x6F
         1rZtEqpSK6FslwuMeDNkaBK5gbHbIhgxdXUkvheqzWoJvK2l7ds/Yl9O0jJFilwQFmkj
         ACew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yYq+18HeUcEIJUvMzPqlCK3z7OvqDSWg2p8T6vbs7w0=;
        b=ZQih5S+ZKbBEk/NEsmt9tBI8vfTCpauTvH5zhDZgOiXWWOXg9u1JkVjFEf57qK2YUq
         /p8dpRnheAyzY6d7GQjvAnpM1vG2dOY13rhVvN33g6e1gb98ZzKmXDbnOfqeZPQPCpLw
         ThI3IuJy+VZHasnVXuv1xbop8/sO21QJIDkfwdSzAswUAWRfVDk4xgcjXTTxZyisFWcK
         lvQIJGJv8P76Dqlo6y0eEgg2UTjLl3KtgXVBN7yxoDEeRyvHBXTufYHDvyZLjWV0ilYi
         CKZgOkjfz5sKz1qR1kY4LFlND+LSrYr23Hjwm8XqC4llyNqrL0jxuqTWv+RRitGULAJZ
         aVgA==
X-Gm-Message-State: APjAAAU+9Vi/80sA/Y4V3IMtEeyuu88AivM7Mj/d3J7ZVniv55wb/ft0
        yN4IydwWo91ePD0UwiQScZ4=
X-Google-Smtp-Source: APXvYqyRgyNwX25uWnf/RhrIHpTOwItecu9mtenCGAl4NZ02AP5cSmmjCy7IyMVbtYFj8gUWZK3cJg==
X-Received: by 2002:a62:ee11:: with SMTP id e17mr28449753pfi.48.1579044841465;
        Tue, 14 Jan 2020 15:34:01 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:acd4:5c73:b928:d080? ([2001:4898:80e8:1:2ceb:5c73:b928:d080])
        by smtp.gmail.com with ESMTPSA id t187sm19746078pfd.21.2020.01.14.15.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 15:34:01 -0800 (PST)
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        shji@microsoft.com, wangglei@gmail.com
From:   Shiping Ji <shiping.linux@gmail.com>
Subject: [PATCH v8 1/2] dt-bindings: edac: arm-dmc520.txt
Message-ID: <acb3a312-5ccd-362c-02ae-beee461a5f4b@gmail.com>
Date:   Tue, 14 Jan 2020 15:34:00 -0800
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
Reviewed-by: James Morse <james.morse@arm.com>

---
     Changes in v8:
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
