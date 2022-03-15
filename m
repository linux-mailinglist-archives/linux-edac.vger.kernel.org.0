Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0432D4DA12B
	for <lists+linux-edac@lfdr.de>; Tue, 15 Mar 2022 18:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349730AbiCORcC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Mar 2022 13:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349106AbiCORcC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Mar 2022 13:32:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3106956774;
        Tue, 15 Mar 2022 10:30:49 -0700 (PDT)
Received: from zn.tnic (p5de8e440.dip0.t-ipconnect.de [93.232.228.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D198F1EC0501;
        Tue, 15 Mar 2022 18:30:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647365443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9YqUb6EkoE47lz1fFg2iC4xCBZkBID1oDN6LQgAf/3U=;
        b=kWOQRb69xh3Fj1RO8HggjEHuHTUYXIGG6yK6k7mUfVYswNX06JkAhEOZDyMfqh4aLibpzJ
        VHJOKfcKxzYI4TAHOAb0qq7nu4c2j5RkxvhnHCYcSz5Ff6fhSI1LWst9f/FBu9PclFSJlK
        o5/p6a/efP6sAmdBDhKUk83fv5HyqEw=
Date:   Tue, 15 Mar 2022 18:28:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        airlied@linux.ie, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 1/1] x86/amd_nb: unexport amd_cache_northbridges()
Message-ID: <YjDMvYOh8Vizq4xv@zn.tnic>
References: <20220228161154.54539-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220228161154.54539-1-nchatrad@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:41:54PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> amd_cache_northbridges() is called from init_amd_nbs(), during
> fs_initcall() and need not be called explicitly. Kernel components
> can directly call amd_nb_num() to get the initialized number of
> north bridges.
> 
> unexport amd_cache_northbridges(), update dependent modules to
> call amd_nb_num() instead. While at it, simplify the while checks
> in amd_cache_northbridges().

What I am missing in this commit message is why is it ok to do that?

AFAIR, previously, amd_cache_northbridges() wasn't an initcall so the
module or builtin - which came first - was forcing the NB caching
through the explicit call to amd_cache_northbridges().

fs_inicall() does that now unconditionally so the question is, why can
the module init functions assume that the northbridges have been cached
already and can simply get the NB number?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette:wq

