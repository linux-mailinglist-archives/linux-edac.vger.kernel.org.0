Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562F45BBF5B
	for <lists+linux-edac@lfdr.de>; Sun, 18 Sep 2022 20:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIRSq0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 18 Sep 2022 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRSqZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 18 Sep 2022 14:46:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C63E09B
        for <linux-edac@vger.kernel.org>; Sun, 18 Sep 2022 11:46:24 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7d5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7d5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C26F1EC02F2;
        Sun, 18 Sep 2022 20:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663526778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1taCH4ARmoNeBJ3RMBeO0mvTPKvGceGRq86TtSzmXnM=;
        b=bnBc8O8m6ucikpOxouiv/1yU50xwGlsucSu3f6oC/B7A0BQh4lLcqbtz37m9IGT7BakVlj
        7FsSiEq1TX4UaNef8MQDINM9+IvPQun7keoAk5jFXdRypsAP/ogYqp9m2WVBNDNy9KjDjs
        KYQ9XBT6kBi9M4uV3j9AJfzCuj1yfac=
Date:   Sun, 18 Sep 2022 20:46:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, kernel@pengutronix.de
Subject: Re: [PATCH] EDAC/ppc_4xx: Reorder symbols to get rid of a few
 forward declarations
Message-ID: <Yydndf9cygPewuzD@zn.tnic>
References: <20220917232013.489931-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220917232013.489931-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Sep 18, 2022 at 01:20:13AM +0200, Uwe Kleine-König wrote:
> When moving the definition of ppc4xx_edac_driver further down, the
> forward declarations can just be dropped.
> 
> Do this to reduce line needless repetition.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/edac/ppc4xx_edac.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
