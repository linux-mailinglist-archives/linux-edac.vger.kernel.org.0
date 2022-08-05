Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5658AB07
	for <lists+linux-edac@lfdr.de>; Fri,  5 Aug 2022 14:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiHEMuQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 5 Aug 2022 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbiHEMuN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 5 Aug 2022 08:50:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F61BF4;
        Fri,  5 Aug 2022 05:50:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j15so3166668wrr.2;
        Fri, 05 Aug 2022 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=vQSLzFNVmG2zGCKCHHUXdjqOVll0yvZmfU9cSH12JEE=;
        b=JHLADgo03G5zDe3eGrxXlNbDJ0q+zA0aKZRBOS9xL8N9KwP2qF6cl+FCp2WWUwTYOG
         WWCttjb+DbgWXqscECJlFjBcJT4Lxg8CUIj6f7GrrJaEmSDIqpuDbn/87Gp6ANGeViLF
         dedyv3mcn7BBM58Iy+iglEMDsiaE4TGpQjBNPz0b0JGVzYQbSahiKtUXoIhMS1XhbUSb
         GwI3mPY17Pr5iCF92WjC9Xdhn3lhTq9TeaYxu+6rqKo0C9NfyQ54i/S9xG3LZZ0/MTmN
         UeZi7FZXLij4tJO4AV2NmJf8VLlA4z57LqePnf7RKK9mEzqO1uPJbS/R24NZfUdrHYsP
         uPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=vQSLzFNVmG2zGCKCHHUXdjqOVll0yvZmfU9cSH12JEE=;
        b=Gh6bGsyz4TOCrTNO7HwXcLDuS/HmqvX29q1a9caV8QPmk1D9TLzgKv6VnUFqLmx8bk
         BYVkFCWuTlzWmY7le+4n6F2TF8rh6TaSdlhw8TfDtRjZSEgYYaLs6910z/pMOeEyJ3sB
         Va773G61wJK+VTseZ/dB3V9FG6ycKHi8OLM/9/h5VG1/THK4hRhP9iOFgWdIyxi6TPQS
         w0hLmqvBCQwSSl+cN/6G0fIaGyxlaMkYQ0aH8pEowoSj1W7QVtRi040VPB+4s81YB+Wr
         +qfkDhM4vA/+AxPtY03jy4UOqNYU30twLLuNVf9yR2G79Dt9Kv3vShFdkMQ1F8QIt8vW
         XmGw==
X-Gm-Message-State: ACgBeo0EOZZjgvu4FyPVLclN7+3w1DxH9zUmosf8h+dtGOTmKBnXVYEu
        n41QtI70pVbQS0uFuKoUcTxHEf2oJkqC5fNx
X-Google-Smtp-Source: AA6agR5lqddUeVgdHWAh0W4nKXgBc6bqt+vS1uwl7km2E7KpzEAVzfCfbQpc4BauYeRD5UWzdd9NcQ==
X-Received: by 2002:a5d:54c1:0:b0:220:623f:4e2 with SMTP id x1-20020a5d54c1000000b00220623f04e2mr4383522wrv.52.1659703809751;
        Fri, 05 Aug 2022 05:50:09 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b17-20020adfee91000000b0021edfa75204sm3882187wro.48.2022.08.05.05.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 05:50:09 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i7300_edac: Set correct function name i7300_exit in comment
Date:   Fri,  5 Aug 2022 13:50:08 +0100
Message-Id: <20220805125008.2346559-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The incorrect function name is being used in the comment for function
i7300_exit. Correct this.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/edac/i7300_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
index 4f28b8c8d378..61adaa872ba7 100644
--- a/drivers/edac/i7300_edac.c
+++ b/drivers/edac/i7300_edac.c
@@ -1193,7 +1193,7 @@ static int __init i7300_init(void)
 }
 
 /**
- * i7300_init() - Unregisters the driver
+ * i7300_exit() - Unregisters the driver
  */
 static void __exit i7300_exit(void)
 {
-- 
2.35.3

