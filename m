Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401ED7503CD
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jul 2023 11:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjGLJtK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jul 2023 05:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjGLJtJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Jul 2023 05:49:09 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EA4B0
        for <linux-edac@vger.kernel.org>; Wed, 12 Jul 2023 02:49:08 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1Ccf14nzzBR7b3
        for <linux-edac@vger.kernel.org>; Wed, 12 Jul 2023 17:49:06 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689155346; x=1691747347; bh=f0lIyFBFjPx0IprcathWHFRn+Oz
        vzscZlcDubsXRrY4=; b=m8ZRZK2k2cDJ2b78uLbLKkZ8ed6dEjffdRdltZir1F/
        EQ/jnO0JDlE0Xyksiq87OARq7cvL6HDnFyll+GOZZUii4FIWSEsrPXiJC4YXTCSt
        GU7hDXRAgJjX+yBPH8Mv8y7PpCaEAjIJRP9iZxUmDAbS/ZZR4nfIz3JDrVMrRDP7
        NlJCKC9j4w5H1Bf8DnWDmluM6X39TRxDo2i2xxjg6MUqwNozIo9cC+Pt6PGKk3Et
        tj8zp6bo0Xb809DlX2ZfImak9G4zAtV1fo6nLqO5KCytMATVlteKZ0O7XJdTeQ9D
        bLsZMHnVFyQMNyroJWxJGgEMKpbOj4I0n/ZKm2aaYtw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vWQrYivzN0vy for <linux-edac@vger.kernel.org>;
        Wed, 12 Jul 2023 17:49:06 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1Ccd64HfzBR7b0;
        Wed, 12 Jul 2023 17:49:05 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 17:49:05 +0800
From:   pangzizhen001@208suo.com
To:     dinguyen@kernel.org, bp@alien8.de, tony.luck@intel.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] drivers/edac: Fix comment typo
In-Reply-To: <20230712094640.24445-1-wangjianli@cdjrlc.com>
References: <20230712094640.24445-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <c3f79bcc93dc4090e88a36fc9fadf26b@208suo.com>
X-Sender: pangzizhen001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Delete duplicate word "the"

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
  drivers/edac/altera_edac.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8b31cd54bdb6..a3b17813eb9b 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -168,7 +168,7 @@ static ssize_t altr_sdr_mc_err_inject_write(struct 
file *file,
      /*
       * To trigger the error, we need to read the data back
       * (the data was written with errors above).
-     * The READ_ONCE macros and printk are used to prevent the
+     * The READ_ONCE macros and printk are used to prevent
       * the compiler optimizing these reads out.
       */
      reg = READ_ONCE(ptemp[0]);
