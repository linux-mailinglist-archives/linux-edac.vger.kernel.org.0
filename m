Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1735B4D6C
	for <lists+linux-edac@lfdr.de>; Sun, 11 Sep 2022 12:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiIKKbj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 11 Sep 2022 06:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIKKbg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 11 Sep 2022 06:31:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF03BC77
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 03:31:36 -0700 (PDT)
Received: from nazgul.tnic (dynamic-046-114-095-207.46.114.pool.telefonica.de [46.114.95.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92A401EC051E;
        Sun, 11 Sep 2022 12:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662892290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pbXCTKL2YgNfw0SXiek8abu9DfEmXDRs7wfQoqTIMJY=;
        b=hBOSUHJp/zitZeB7g6sXxnYg4x1n7kxtJno1MPetBsbZCyVrZDzKwrqtfm8WosoM6QbJFF
        z3ZJqXUDDiHt1h/5ct8tFGBUrBYVplBUjAOZvZiezUXNxwJakARiT3WYJ2Oc6xADuyBNA8
        zqEA/hC32xEidqkaTqs/1VXfAuuYZKE=
Date:   Sun, 11 Sep 2022 12:31:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, djiang@mvista.com, dougthompson@xmissin.com,
        akpm@linux-foundation.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC: remove unused declarations in edac_module.h
Message-ID: <Yx24/rnpKz4HZaU0@nazgul.tnic>
References: <20220911094038.3224365-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220911094038.3224365-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Sep 11, 2022 at 05:40:38PM +0800, Gaosheng Cui wrote:
> edac_get_log_ce(), edac_get_log_ue(), edac_get_poll_msec() and
> edac_get_panic_on_ue() have been removed since
> commit 4de78c6877ec ("drivers/edac: mod PCI poll names"),
> so remove them.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/edac/edac_module.h | 4 ----
>  1 file changed, 4 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
