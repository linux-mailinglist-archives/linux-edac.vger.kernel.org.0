Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14516FF8A7
	for <lists+linux-edac@lfdr.de>; Thu, 11 May 2023 19:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbjEKRqa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 May 2023 13:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKRq3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 May 2023 13:46:29 -0400
Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438543AB3
        for <linux-edac@vger.kernel.org>; Thu, 11 May 2023 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
        s=default; h=Content-Transfer-Encoding:Message-Id:Date:Subject:To:From:
        Content-Type:Reply-To:Sender; bh=uiFFi94ZKjXDUueKImK+kPcWWMG2n2xiJPbTLFExWGY=
        ; b=JUyQbIrLXgo2/M1DXPWHevtzyTJFaV4qYop6Mta5aiTqOX3yf7oMX1k5Ecz0oXfv/FnvLjyt7
        8/UkMEkQnzhQy30czU5Kfk7ZE1a7imvBtcMRtIiQXTesg6l82Hrt2divzRkmpTMzv5dbLJh85BGAm
        8OETqmn1fF9OajMNZBybTdlyOAHin3FSF6CQFc9OkPtVruUHPkpTL0aWoovMWLE3DdMAQA6xMKZgj
        8747eJ3hShkbaRMH4YZuUn+/d8h6kPsfUOWX2/rUFAzUYaFGRau7J+Xj2bO9cniibV//F39+lCjy0
        oP8RUcb3DHT1F6UHMjZv6mK07b7dhPsz42Bjyfhb7Dl/CQJqaGtGbg4zzDOe+x11G5dDwFha7bbir
        8MT+erycfJDXpwYV6cpuxPUVFM6bkb5isIaLf4sC8z5qYD9sZS7ZmEFshoQHrHA2fg41KMY+06N2S
        mn9BEuWThPg5UL5sRHKwTohX4UBZKEUQOAL8qM6cEa+De1aUHZLsf4npoz3pKDNEoCaLUuS2NSQjS
        Xv/hpjIAltGc/sE/vZiuMj16DB2EFCJ+nih+01DnusGI9/uQsMfUK/uYeQ+X9Ib1xVuHc8wrz+yki
        jQpbHh2WzaXuTwKordpR2ngqlk60BfCC20f7l/WZsqhQ8z1udy67lrpChGQSWiMsfZ+QVD4=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
        by a1-bg02.venev.name with esmtps
        id 1pxAMz-003fhq-1F
        (TLS1.3:TLS_AES_256_GCM_SHA384:256)
        (envelope-from <hristo@venev.name>);
        Thu, 11 May 2023 17:46:24 +0000
Received: from venev.name ([213.240.239.49])
        by pmx1.venev.name with ESMTPSA
        id Hlp3CuspXWQmWw0AdB6GMg:T2
        (envelope-from <hristo@venev.name>); Thu, 11 May 2023 17:46:24 +0000
From:   Hristo Venev <hristo@venev.name>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        Hristo Venev <hristo@venev.name>
Subject: [PATCH v2] EDAC/amd64: Add support for ECC on family 19h model 60h-7Fh
Date:   Thu, 11 May 2023 20:45:07 +0300
Message-Id: <20230511174506.875153-2-hristo@venev.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d619252e-35c7-814b-acdb-74714619d62a@amd.com>
References: <d619252e-35c7-814b-acdb-74714619d62a@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Ryzen 9 7950X uses model 61h. Treat it as Epyc 9004, but with 2 channels
instead of 12.

I tested this with two 32GB dual-rank DIMMs. The sizes appear to be
reported correctly:

    [    2.122750] EDAC MC0: Giving out device to module amd64_edac controller F19h_M60h: DEV 0000:00:18.3 (INTERRUPT)
    [    2.122751] EDAC amd64: F19h_M60h detected (node 0).
    [    2.122754] EDAC MC: UMC0 chip selects:
    [    2.122754] EDAC amd64: MC: 0:     0MB 1:     0MB
    [    2.122755] EDAC amd64: MC: 2: 16384MB 3: 16384MB
    [    2.122757] EDAC MC: UMC1 chip selects:
    [    2.122757] EDAC amd64: MC: 0:     0MB 1:     0MB
    [    2.122758] EDAC amd64: MC: 2: 16384MB 3: 16384MB
    [    2.122759] AMD64 EDAC driver v3.5.0

ECC errors can also be detected:

    [  313.747594] mce: [Hardware Error]: Machine check events logged
    [  313.747597] [Hardware Error]: Corrected error, no action required.
    [  313.747613] [Hardware Error]: CPU:0 (19:61:2) MC21_STATUS[Over|CE|MiscV|AddrV|-|-|SyndV|CECC|-|-|-]: 0xdc2040000400011b
    [  313.747632] [Hardware Error]: Error Addr: 0x00000007ff7e93c0
    [  313.747639] [Hardware Error]: IPID: 0x0000009600050f00, Syndrome: 0x000100010a801203
    [  313.747652] [Hardware Error]: Unified Memory Controller Ext. Error Code: 0, DRAM ECC error.
    [  313.747669] EDAC MC0: 1 CE Cannot decode normalized address on mc#0csrow#3channel#0 (csrow:3 channel:0 page:0x0 offset:0x0 grain:64 syndrome:0x1)
    [  313.747672] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx: RD

According to Mario Limonciello, the same code should also work for
models 70h-7Fh [1].

Link: https://lore.kernel.org/linux-edac/d619252e-35c7-814b-acdb-74714619d62a@amd.com/T/#m9fc20d5dc36074048ec5f1c0a5b01b7f972a1cc7 [1]
Signed-off-by: Hristo Venev <hristo@venev.name>
---
 drivers/edac/amd64_edac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b55129425c81..c00f7e4ef366 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3816,6 +3816,14 @@ static int per_family_init(struct amd64_pvt *pvt)
 		case 0x50 ... 0x5f:
 			pvt->ctl_name			= "F19h_M50h";
 			break;
+		case 0x60 ... 0x6f:
+			pvt->ctl_name			= "F19h_M60h";
+			pvt->flags.zn_regs_v2		= 1;
+			break;
+		case 0x70 ... 0x7f:
+			pvt->ctl_name			= "F19h_M70h";
+			pvt->flags.zn_regs_v2		= 1;
+			break;
 		case 0xa0 ... 0xaf:
 			pvt->ctl_name			= "F19h_MA0h";
 			pvt->max_mcs			= 12;
-- 
2.40.1

