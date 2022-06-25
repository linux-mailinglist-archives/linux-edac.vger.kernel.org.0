Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7891555AA55
	for <lists+linux-edac@lfdr.de>; Sat, 25 Jun 2022 15:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiFYNKN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 25 Jun 2022 09:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiFYNKM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 25 Jun 2022 09:10:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D771C5F55;
        Sat, 25 Jun 2022 06:10:10 -0700 (PDT)
Received: from zn.tnic (p200300ea97465768329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5768:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EEC151EC04DF;
        Sat, 25 Jun 2022 15:10:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656162605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=370Qrppx8dskofbXGy4yS6jqi4CEYDJ1COeJ2ndjgf0=;
        b=Yra84RmFjzXKqL6LqAmF4LFDULEf7dL2ikZ4PO/9h9Q2HoVLv8N5EMkC0zWpmBGgQmcb+T
        RAp4aovPH2cNLOyIHVKPDd/yEu45QzfDc+hAtoJGodnTHfGYECQfBV/MCNk2aBoIUOKMkE
        B6lzLdv4BrKUPbxcwh83YeTpUzNSr+A=
Date:   Sat, 25 Jun 2022 15:10:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v5] x86/mce: Check for writes ignored in MCA_STATUS
 register
Message-ID: <YrcJKOUSJsmodo70@zn.tnic>
References: <20220610192515.98540-1-Smita.KoralahalliChannabasappa@amd.com>
 <YrNRYJx0CNDNj3oX@zn.tnic>
 <d3f554b8-4fc5-efe8-1ca2-aa95c7e76eb8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3f554b8-4fc5-efe8-1ca2-aa95c7e76eb8@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 24, 2022 at 03:34:42PM -0700, Smita Koralahalli wrote:
> The wrmsrl_safe() doesn't throw an error here.
> I think we need to read back the written value and check for it whatsoever.
> What do you think?

Ah, that's the write-ignored thing. Not the #GP-generating thing when
McStatusWrEn=0.

Sorry, I got confused.

Can you pls change that part back to reading the previously written
value and send me a tested version?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
