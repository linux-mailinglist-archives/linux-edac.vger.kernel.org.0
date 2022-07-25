Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E9457FD38
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jul 2022 12:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiGYKOf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jul 2022 06:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiGYKOe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jul 2022 06:14:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49B164ED;
        Mon, 25 Jul 2022 03:14:33 -0700 (PDT)
Received: from zn.tnic (p200300ea972976f8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:76f8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA3AC1EC02AD;
        Mon, 25 Jul 2022 12:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658744067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UG3HyB+a1rEuod/npdxD9V9DqUguu9NB6mUos5iP184=;
        b=Lq3tyrIyax/V1WQYaRZGfpC21SBrLPnzksuggi9y9EcQCe2hA531lfI3iR6Bt3zL+gvQXB
        O6eRlG9m/yKACmGBma6zMLOGHb4J6Z87JoXhkWLUKft/IuJ2iYQHZmSxOynoRUYMk2bmCR
        eF4lXkhsCgLg9j+hESxedamBcCdpqbo=
Date:   Mon, 25 Jul 2022 12:14:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rric@kernel.org>
Cc:     Toshi Kani <toshi.kani@hpe.com>, mchehab@kernel.org,
        elliott@hpe.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Message-ID: <Yt5s/f/jyRcFY1Md@zn.tnic>
References: <20220721180503.896050-1-toshi.kani@hpe.com>
 <YtqkMicKdZdPdUWB@zn.tnic>
 <Yt5oAjbZ5Koy9v5i@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yt5oAjbZ5Koy9v5i@rric.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 25, 2022 at 11:53:06AM +0200, Robert Richter wrote:
> The dimm->label buffer must be pre-initialized zero. This broke with:
> 
>  b9cae27728d1 EDAC/ghes: Scan the system once on driver init
> 
> since krealloc/krealloc_array() does not zero out the new allocated
> buffer for struct dimm_info in enumerate_dimms(). This uninitialized
> broken struct is then copied in ghes_edac_register() to the final
> dimm_info destination. Originally, before b9cae27728d1, the struct was
> zero initialized with kzalloc'ed by edac_mc_alloc() and directly used.
> Now, that a copy is created first, this copy must be also zero
> initialized.
> 
> IMO this is the proper fix:

Maybe, but this needs fixing too:

	/* both strings must be non-zero */
	if (bank && *bank && device && *device)

Obviously one of those strings are zero coming from that BIOS...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
