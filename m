Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ADF518222
	for <lists+linux-edac@lfdr.de>; Tue,  3 May 2022 12:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiECKTG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 May 2022 06:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbiECKS6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 May 2022 06:18:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A491EEE7;
        Tue,  3 May 2022 03:15:25 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 611181EC0455;
        Tue,  3 May 2022 12:15:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651572920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mKTwIKrh4EWWiVkBp1uQfM1HxqpE6n66nTbg1oa/fMs=;
        b=k+v0j3G24u+dsm0v1Dy3Hau5Ciwci0/rP3shg7OaHU3Hu1dutN5zcDK259Bdq4Ucfc3n7B
        oJqGhAfr4UoD4KNHII84Nzi78k2eMxRXZtFmsJ3WAkFVLVIv/U1Y9vZjpws5SdeYvDyVbp
        Che5jtFGBwnxYTOuEmR+/q3EBr5YSYY=
Date:   Tue, 3 May 2022 12:15:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Medad CChien <medadyoung@gmail.com>
Cc:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v8 1/3] ARM: dts: nuvoton: Add memory controller node
Message-ID: <YnEAtQQ6Wnacfrub@zn.tnic>
References: <20220503094728.926-1-ctcchien@nuvoton.com>
 <20220503094728.926-2-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220503094728.926-2-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 03, 2022 at 05:47:26PM +0800, Medad CChien wrote:
> ECC must be configured in the BootBlock header.
> Then, you can read error counts via
> the EDAC kernel framework.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> Reviewed-by: Borislav Petkov <bp@alien8.de>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

I don't think you understand the concept of Reviewed-by: tags. You
may add them to a patch of yours when the reviewer gives them to you
explicitly - not because she/he has given comments to a patch of yours.

Please go over

Documentation/process/

and Documentation/process/submitting-patches.rst especially and then
send patches.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
