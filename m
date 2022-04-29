Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91FD514542
	for <lists+linux-edac@lfdr.de>; Fri, 29 Apr 2022 11:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiD2JYS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 Apr 2022 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbiD2JYQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 29 Apr 2022 05:24:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5020AB53EB;
        Fri, 29 Apr 2022 02:20:55 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 737251EC054E;
        Fri, 29 Apr 2022 11:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651224049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pYYZ0Cioy1jpcXSOacJzPaCa0t3YepuHT13CF6yP8d8=;
        b=FQeEqncoOupnPKtGAZqypsEerMJVj5FF4EDivZfRtwrdRHCuIE9Emt4QettTKVBHp9rXLL
        WTIzOyTF9i14IBfOoJMJaxh6gHR4ciHZldXcA43Y8hPcE4gqF9FKQ+DK+8ur4yvXIWeiTU
        otL2GidG+/bXU7zxeaAhPnm6FPn7big=
Date:   Fri, 29 Apr 2022 11:20:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     cgel.zte@gmail.com
Cc:     jlu@pengutronix.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] edac: Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <Ymut7ExGPcj5Lmby@zn.tnic>
References: <20220421084621.2615517-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421084621.2615517-1-lv.ruyi@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Apr 21, 2022 at 08:46:21AM +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> Use the devm_platform_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.Make the
> code simpler without functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/edac/armada_xp_edac.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
