Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA65618AA
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jun 2022 13:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiF3LCK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Jun 2022 07:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiF3LCK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 30 Jun 2022 07:02:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0872143AE2;
        Thu, 30 Jun 2022 04:02:08 -0700 (PDT)
Received: from zn.tnic (p200300ea97156a35329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:6a35:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 709641EC0513;
        Thu, 30 Jun 2022 13:02:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656586923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HFGw8L5ogezqmJb/wh0+YGKDXniLHEuZSAUI4TsKDF8=;
        b=r2/VjKm3ttF7fHD3sk6yUEbFminFm6vJc1sxqZwrgV1ldYPXJn1Y4wv75xSFBFkvLsLE9B
        DOgBD4HvT5Yc4xztYhCuLlFhWKw6gF+biy9gV9o18G3hCMyy03fjSTftnUS6gR8ohHEbfB
        kPOOwpS7gYYov28jW8R0HY37zenZvkI=
Date:   Thu, 30 Jun 2022 13:01:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <Yr2CpuL+JHWblJMD@zn.tnic>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220418174440.334336-2-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 18, 2022 at 05:44:38PM +0000, Yazen Ghannam wrote:
> Future Scalable MCA systems will include two new registers: MCA_SYND1
> and MCA_SYND2.
> 
> These registers will include supplemental error information in addition
> to the existing MCA_SYND register. The data within the registers is
> considered valid if MCA_STATUS[SyndV] is set.
> 
> Add fields for these registers in struct mce. Save and print these
> registers wherever MCA_STATUS[SyndV]/MCA_SYND is currently used.

That's all fine and good but what kind of supplemental error information
are we talking about here? Example?

And how is that error info going to be used in luserspace?

I don't want to increase struct mce record size by 16 bytes and those
end up unused.

Can the information from MCA_SYND{,1,2} be synthesized into a smaller
quantity an then fed to userspace?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
