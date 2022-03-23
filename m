Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6C14E553F
	for <lists+linux-edac@lfdr.de>; Wed, 23 Mar 2022 16:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242408AbiCWPdX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Mar 2022 11:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbiCWPdW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Mar 2022 11:33:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0D274DEE;
        Wed, 23 Mar 2022 08:31:52 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B1AF1EC049C;
        Wed, 23 Mar 2022 16:31:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648049507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qMH8Wp5PZS8Ts0fORbhTtvaK5kMqJDweKH76Fd8+w28=;
        b=jtDnO48YShX7WgVx8YTnyBZUA1ZUYQoC3hxk1w50QCHDVkhdTpkUDOLKRBrkg2yBpG2N98
        gUpBYCMZGsJifaFMw6qvIqEcRTRPcqe5KTPJdWenbeVO17QHLeZiXhoxDgeTUN4xHZGfvL
        mY0KFSq88c8o9Sw0xUErdCZiB1MQY+w=
Date:   Wed, 23 Mar 2022 16:31:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        airlied@linux.ie, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 1/1] x86/amd_nb: unexport amd_cache_northbridges()
Message-ID: <Yjs9X4O3qwamG6ul@zn.tnic>
References: <20220228161154.54539-1-nchatrad@amd.com>
 <YjDMvYOh8Vizq4xv@zn.tnic>
 <31759627-1754-8d5d-6d6a-df3010d3e8e0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31759627-1754-8d5d-6d6a-df3010d3e8e0@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Mar 23, 2022 at 08:54:20PM +0530, Chatradhi, Naveen Krishna wrote:
> Modules that are using this API comes after the fs_initcall() is called.

I don't need you to explain this to me - I need you to:

"What I am missing in this commit message is why is it ok to do that?"

I.e., pls explain in the commit message exactly why it is ok to do that
so that people who read it, will know.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
