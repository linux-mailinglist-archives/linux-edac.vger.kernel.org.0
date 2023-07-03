Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387627460B0
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jul 2023 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjGCQZU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Jul 2023 12:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjGCQZT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Jul 2023 12:25:19 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8114AD
        for <linux-edac@vger.kernel.org>; Mon,  3 Jul 2023 09:25:18 -0700 (PDT)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 44B3A3F16E
        for <linux-edac@vger.kernel.org>; Mon,  3 Jul 2023 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688401516;
        bh=ykDzESFnICwZIJMQN3uAcRHhxxnmPoYMfo+p0YP998E=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Kt4lGkCT9B6iT0C/RjmeURqtwzFovp9U28zXE+fRYmzc/PPE416XA/tn/gJHWUFSA
         QNmK/l7H6KDHwfqW4UUPxqaqATb2G8Lf1nnspJXJ7DhAnIzCFu2Sgvw3xUXxX1UWMK
         0hnMci1ucZl7GZlSQJ7i5rkffG+g9NO7WgVWwiqJ6K6ySQQV8SuZWbVx3VlhPpMBzZ
         AaGo9xEYOoLa6IMnH6S6CEY0BDyFU+kvJA+CMc5Tca/0F3LNTsyOooF+i3ds36Yipd
         mQKTCJWubEiFnGDxBMXR1wkyNxTJ6X0DxovuU9uJs8hA4FrWV3kJpV1XzuW+jvjqwz
         dTPHlHEt8V6hg==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b7dd5bca25so51515505ad.1
        for <linux-edac@vger.kernel.org>; Mon, 03 Jul 2023 09:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688401513; x=1690993513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykDzESFnICwZIJMQN3uAcRHhxxnmPoYMfo+p0YP998E=;
        b=djX25qJ9lUf2C3BSox2792kyZKcNVjZQ3lbXxp8Js3UFGGadOC2gRCh2YFDw2y8yHa
         aIz1NgJkvdKjCEs6ZM6w5MhTg1CiEsKUnd72Mry8ZBMJ8Ryb9DEhWT9ezeedRaKegoig
         ZI1YXi3VOqzRa6Xe2W+tRkLlmJnjer0ZeTsAV2uAKJaeidQ+rO/Ycg4auJa4ACM0hBGW
         L3Fqg7eqt05MmRXZzlYRH95kqC7lmwqrXX3sSNnjVxKV3yoJxyHWCz/u+cXS8vo4phOt
         3AAYneS5cJr4l7I1nLyVycNIBEDcDgEvXoX1K6g2p5BTKYrQQLzeTKlGGMs76fhbcRR5
         2c2g==
X-Gm-Message-State: ABy/qLbJpVxZHvm1GA4rRNaiicC9iiqpJ//+loMH5nSUvb3ronFyOETt
        XAKP/VupmDE9UrhPbYU1ONHKvp0uTgR5GMqhkAQQhSiXolRys0CbQzRMqKdmdLAVSZ4wW0WishE
        2gxzW2LBcEIhOTN7zC+aXJkXk5BKhih0ij7tbKHE=
X-Received: by 2002:a17:902:e54c:b0:1b8:8979:8088 with SMTP id n12-20020a170902e54c00b001b889798088mr7052710plf.18.1688401513089;
        Mon, 03 Jul 2023 09:25:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGZdOUJQa/Ej88XepCZgZmtuutg08rcOpg5AbKBkOrsnjhDxkAm5qqtXRN9B37RmrqCdRseWg==
X-Received: by 2002:a17:902:e54c:b0:1b8:8979:8088 with SMTP id n12-20020a170902e54c00b001b889798088mr7052695plf.18.1688401512700;
        Mon, 03 Jul 2023 09:25:12 -0700 (PDT)
Received: from canonical.com (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902c1ca00b001a072aedec7sm4863715plc.75.2023.07.03.09.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 09:25:12 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][V2] EDAC/i10nm: shift exponent is negative
Date:   Tue,  4 Jul 2023 00:25:09 +0800
Message-Id: <20230703162509.77828-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

UBSAN complains this error
~~~
 UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:369:16
 shift exponent -66 is negative
 Call Trace:
  <TASK>
  dump_stack_lvl+0x48/0x70
  dump_stack+0x10/0x20
  __ubsan_handle_shift_out_of_bounds+0x1ac/0x360
  skx_get_dimm_info.cold+0x91/0x175 [i10nm_edac]
  ? kvasprintf_const+0x2a/0xb0
  i10nm_get_dimm_config+0x23c/0x340 [i10nm_edac]
  skx_register_mci+0x139/0x1e0 [i10nm_edac]
  ? __pfx_i10nm_get_dimm_config+0x10/0x10 [i10nm_edac]
  i10nm_init+0x403/0xd10 [i10nm_edac]
  ? __pfx_i10nm_init+0x10/0x10 [i10nm_edac]
  do_one_initcall+0x5b/0x250
  do_init_module+0x68/0x260
  load_module+0xb45/0xcd0
  ? kernel_read_file+0x2a4/0x320
  __do_sys_finit_module+0xc4/0x140
  ? __do_sys_finit_module+0xc4/0x140
  __x64_sys_finit_module+0x18/0x30
  do_syscall_64+0x58/0x90
  ? syscall_exit_to_user_mode+0x29/0x50
  ? do_syscall_64+0x67/0x90
  ? syscall_exit_to_user_mode+0x29/0x50
  ? do_syscall_64+0x67/0x90
  ? do_syscall_64+0x67/0x90
  ? __flush_smp_call_function_queue+0x122/0x1f0
  ? exit_to_user_mode_prepare+0x30/0xb0
  ? irqentry_exit_to_user_mode+0x9/0x20
  ? irqentry_exit+0x43/0x50
  ? sysvec_call_function+0x4b/0xd0
  entry_SYSCALL_64_after_hwframe+0x72/0xdc
~~~

when get rows, cols and ranks, the returned error value doesn't be
handled.

check the return value is EINVAL, if yes, directly return 0.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
V2: make error-print explicitly
---
 drivers/edac/skx_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 2a00e0503f0d5..ac61db72d2e6b 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -330,7 +330,7 @@ static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
 	u32 val = GET_BITFIELD(reg, lobit, hibit);
 
 	if (val < minval || val > maxval) {
-		edac_dbg(2, "bad %s = %d (raw=0x%x)\n", name, val, reg);
+		skx_printk(KERN_ERR, "bad %s = %d (raw=0x%x)\n", name, val, reg);
 		return -EINVAL;
 	}
 	return val + add;
@@ -351,6 +351,8 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 	ranks = numrank(mtr);
 	rows = numrow(mtr);
 	cols = imc->hbm_mc ? 6 : numcol(mtr);
+	if (ranks == -EINVAL || rows == -EINVAL || cols == -EINVAL)
+		return 0;
 
 	if (imc->hbm_mc) {
 		banks = 32;
-- 
2.34.1

