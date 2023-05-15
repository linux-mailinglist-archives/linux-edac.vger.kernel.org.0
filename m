Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47081703097
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 16:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbjEOOwl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 10:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjEOOwk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 10:52:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBBF10C9
        for <linux-edac@vger.kernel.org>; Mon, 15 May 2023 07:52:36 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42B7E1EC0159;
        Mon, 15 May 2023 16:52:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684162355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QB/MuMSbOCeaIoadCnsrttuYrRMuMDdDALwVDqcVOxM=;
        b=biYaLQzkuHbo3Mx0N1eJTArONSHCSGj1zCEXovAEeKFMsXGi9bXa9teP+5JeIqJY41wt2S
        8YbbVr0K5f0BPs/e5RK6BL9I3p9PBGRPinKlhK7iLQxF8zh+7UDyvBbr8hqx4FiE+mQwih
        8+sGtNtSmSWfZ1bg4nASNYpLwns4FI8=
Date:   Mon, 15 May 2023 16:52:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     linux-edac@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
References: <20230515143225.GC4090740@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515143225.GC4090740@cathedrallabs.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 15, 2023 at 10:32:25AM -0400, Aristeu Rozanski wrote:
> Error injection in modern HP machines with CMCI disabled will cause the
> injected MCE to be found only by polling. Because these newer machines have a
> big number of CPUs per package, it makes a lot more likely for multiple
> CPUs polling IMC registers (that are shared in the same package) at same time,

So the MCE code already has some notion of shared banks and tries to pay
attention to it.

I think it'll be cleaner if machine_check_poll() paid attention to that
and polled only on the smallest CPU number which shares the bank instead
of doing an unconditional wholesale spinlock grabbing which is not
really needed...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
