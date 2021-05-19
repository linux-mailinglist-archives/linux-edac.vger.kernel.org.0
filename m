Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14C83890F9
	for <lists+linux-edac@lfdr.de>; Wed, 19 May 2021 16:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242612AbhESOd4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 May 2021 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbhESOd4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 19 May 2021 10:33:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B7AC06175F;
        Wed, 19 May 2021 07:32:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c02005c05f05746ddc21b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:200:5c05:f057:46dd:c21b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB3631EC01FC;
        Wed, 19 May 2021 16:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621434755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=62y0wNyrSc/25znfXEpsvHi1tEFtNUnwiQQfcY25kw0=;
        b=Znkqca52vq1NdY81Yn1Yflwurb7kxEBdT4Ew0HI2DtGleCyxZliwpZGLmVer1Q1zJb8nMU
        5WjnbQU5a9RYwDcHCmnJ9FO44eeNFv81LPalwdVn7T0AlAwBwVbHuI8fqo3ngvHYUDXLjD
        Zn3KvgHYFhatJN7jOlSqEFHW2NchBPE=
Date:   Wed, 19 May 2021 16:32:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 00/25] AMD MCA Address Translation Updates
Message-ID: <YKUhfe42ExwVJVp4@zn.tnic>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
 <YKJoICQzD/o7ZPBp@zn.tnic>
 <20210519035207.GA8913@aus-x-yghannam.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210519035207.GA8913@aus-x-yghannam.amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 18, 2021 at 11:52:07PM -0400, Yazen Ghannam wrote:
> I think this is a good idea. The only hang up is that we should be using
> the output of this function, i.e. the systeme physical address, when
> handling memory errors in the MCE notifier blocks. But I have an idea
> where we can handle this. I can send that as a follow up series, if
> that's okay.

Yeah, so frankly I'm not happy with all this clumsy plugging we do
with notifiers and then amd_register_ecc_decoder() which is called in
mce_amd.c to be used in amd64_edac.c which finally logs it.

What I'd like to see is mce_amd.c still decoding all kinds of errors and
additionally amd64_edac continues processing only the DRAM errors.

> One other issue is what if a user doesn't want to use amd64_edac_mod?

Then she/he doesn't get DRAM errors mapped to a DIMM - simple.

> This is more of a user preference and/or configuration issue. Maybe the
> module loads, but an uninterested user can tell EDAC to not log errors,
> etc.? Or should the translation code live in its own module?

No need. Translation is part of EDAC so if you don't load it, you don't
get the functionality.

> So for version 2, I have 1) Add a glossary of terms, and 2) Move
> everything to EDAC. Any other comments?

None at the moment - I'll do a deeper review with v2.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
