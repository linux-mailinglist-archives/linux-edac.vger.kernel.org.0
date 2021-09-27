Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D82F419FEF
	for <lists+linux-edac@lfdr.de>; Mon, 27 Sep 2021 22:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhI0URI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Sep 2021 16:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbhI0URI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Sep 2021 16:17:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45395C061575;
        Mon, 27 Sep 2021 13:15:30 -0700 (PDT)
Received: from zn.tnic (p200300ec2f088a0023fd899c9252ef55.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8a00:23fd:899c:9252:ef55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 997FF1EC069C;
        Mon, 27 Sep 2021 22:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632773724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9fgz9ufaSd11gMVgWCc5Z6EQNVl50vlDQQ3NXzL1vqU=;
        b=JRbmcAKna1rdBafGBmbNM70lWbZ2NcFnIoaivEnDoEvjoZRkuMXLQuc7c3zrT2p28o8eux
        RJWIlpqw25iZJWt8Iwzrbj9azNQfON5k2zI/X+LbsAoaYWdsnu5ilTdvOH06W8PUqrrQ40
        xhq6k1P2opqwaPcJxDwHhMhGrENKyeg=
Date:   Mon, 27 Sep 2021 22:15:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli Channabasappa <skoralah@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH 1/5] x86/mce/inject: Check if a bank is unpopulated
 before error simulation
Message-ID: <YVImVgsxyfQO7TGI@zn.tnic>
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210915232739.6367-2-Smita.KoralahalliChannabasappa@amd.com>
 <YU2Lm+11Pqg/RBK3@zn.tnic>
 <60d4f6be-76f7-e4b6-6fb5-2af78b01d32d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60d4f6be-76f7-e4b6-6fb5-2af78b01d32d@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 27, 2021 at 02:51:56PM -0500, Smita Koralahalli Channabasappa wrote:
> Can you please elaborate on this? I'm not sure if I understood this
> right. Should I read the ipid file to verify that the user has input
> proper ipid? If ipid file reads zero then do rdmsrl_on_cpu?

No, on a write to the ipid file you should do that checking and write if
the bank is populated or fail the write otherwise. And you should put
all that code in inj_bank_set() - that's why I say "on a write to the
ipid file".

And instead of boot_cpu_has() you should use cpu_feature_enabled().

Makes sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
