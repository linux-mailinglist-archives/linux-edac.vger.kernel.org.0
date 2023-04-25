Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06D56EE927
	for <lists+linux-edac@lfdr.de>; Tue, 25 Apr 2023 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjDYUiq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Apr 2023 16:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbjDYUi3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Apr 2023 16:38:29 -0400
X-Greylist: delayed 1533 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 13:38:27 PDT
Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74E1447C
        for <linux-edac@vger.kernel.org>; Tue, 25 Apr 2023 13:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
        s=default; h=Content-Transfer-Encoding:Message-Id:Date:Subject:To:From:
        Content-Type:Reply-To:Sender; bh=LKX7u/ciibcBQSMy3W8isKuhRcRHd0tKSxfPOyufmRM=
        ; b=bUL1yN16i5Yn2yoy601zUNODdy7n325zD3CxNnUJ0cYyLqDapsWBPZRLF+bW0BaeaSVqk+457
        YlnL3+XWuZ/z+dI27RlqZJ/Nnrm7aYk33F/J45mV01ebaZvMi1v4K5lY6dnSgtwwX71SyC0U1NyGR
        D546iskCX0/7Iuut1tYQGZxHLA4zRyac/+V6AdTRQULtRH6vcO8YbeiPYqrLvZMA1AnJe2rTRlan/
        ZxeaySrA+fvjtT//VmU0TXXavzGJ3hTcKmAG7TrCXDrx5pvqq6ysln6FdfcQhC+b2FiT2hGoBw77j
        2MQ4rtxoFYtTuNbkjy2yAkLF4tulIcvCnzOygF7CpAktvKCMaBeYwTN8n3/L/MC07VF1oxEIUqu7H
        6QQBe/7Sb6wpU3Exi+oCosq/Qsb4SUQ1yq6yITHxPg7U7zQf9kJnZ437qHFNo5X1I67eelZNKgn07
        gk1sE1ipB7M2E0sQ9GJ+M7a8Q/1WFxLhLTdm8cUpgNW+j6TLf1n3GA0qT0T51PRC7QSqi3mut/Nzk
        TzsoC/paiMHPr0hIXLv3PcFRfWo46ldycfZnRYYu0e1NkW+rOlHJ1iASShgZaF15c5iPijSD/GPcD
        zuFtnlHsXCxc2TYfhqv4K/YclBeD5YIF2lN5MgiJ4xqtOzOMb5q1LQMyEtlr7iLL/4SoVr4=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
        by a1-bg02.venev.name with esmtps
        id 1prP1r-001MQx-0a
        (TLS1.3:TLS_AES_256_GCM_SHA384:256)
        (envelope-from <hristo@venev.name>);
        Tue, 25 Apr 2023 20:12:47 +0000
Received: from venev.name ([213.240.239.49])
        by pmx1.venev.name with ESMTPSA
        id Zt99Cj80SGTT8wQAdB6GMg
        (envelope-from <hristo@venev.name>); Tue, 25 Apr 2023 20:12:47 +0000
From:   Hristo Venev <hristo@venev.name>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        Hristo Venev <hristo@venev.name>
Subject: [PATCH] EDAC/amd64: Add support for ECC on family 19h model 60h-6Fh
Date:   Tue, 25 Apr 2023 23:12:39 +0300
Message-Id: <20230425201239.324476-1-hristo@venev.name>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Hristo Venev <hristo@venev.name>
---
 drivers/edac/amd64_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b55129425c81..1080784e2784 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3816,6 +3816,10 @@ static int per_family_init(struct amd64_pvt *pvt)
 		case 0x50 ... 0x5f:
 			pvt->ctl_name			= "F19h_M50h";
 			break;
+		case 0x60 ... 0x6f:
+			pvt->ctl_name			= "F19h_M60h";
+			pvt->flags.zn_regs_v2		= 1;
+			break;
 		case 0xa0 ... 0xaf:
 			pvt->ctl_name			= "F19h_MA0h";
 			pvt->max_mcs			= 12;
-- 
2.40.0

