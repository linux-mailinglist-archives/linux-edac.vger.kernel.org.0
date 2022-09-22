Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688735E645D
	for <lists+linux-edac@lfdr.de>; Thu, 22 Sep 2022 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiIVN4N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Sep 2022 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiIVN4J (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Sep 2022 09:56:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126DEF1D76
        for <linux-edac@vger.kernel.org>; Thu, 22 Sep 2022 06:56:06 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7fe329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7fe:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C2261EC03EA;
        Thu, 22 Sep 2022 15:56:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663854961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jp8a7zJsOmjIhz9nOoZTxwJuZrM7/gguZ5blZXLlBDk=;
        b=nu+8gumQUuR0jJYRixDWIZaJ+oRh7BQvDRa+HS1LGQUP7cRNCBf1Q0Zl4mH+fq6B4HGMdw
        gv6BkBXuwBsJYDEKU/sonSuyjjpdnNqk80fDfNhaBBtg6jQlePHtfYAZzrp15KVobf+46l
        +URjnpFdYmxLX3p8TnkUR/DdE57xRYo=
Date:   Thu, 22 Sep 2022 15:55:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Aristeu Rozanski <aris@redhat.com>
Cc:     linux-edac@vger.kernel.org, mchehab@kernel.org
Subject: Re: [RESEND PATCH] i5000_edac: fix slot number passed to
 determine_mtr()
Message-ID: <YyxpbRkuLPIcW1Om@zn.tnic>
References: <20220921181009.oxytvicy6sry6it7@redhat.com>
 <YytoHtVULW7w3/8Z@zn.tnic>
 <20220922134659.biiy6g743qplzgiq@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220922134659.biiy6g743qplzgiq@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 22, 2022 at 09:46:59AM -0400, Aristeu Rozanski wrote:
> I'm only fixing a out of bounds access, on purpose.
> Look at 64e1fdaf55d6 and the new version of determine_mtr().

I have been looking at that one. And I'm questioning it:

"The logic there is broken: it basically creates two csrows for each
DIMM and assumes that all DIMM's are dual rank."

That commit message doesn't explain why this assumption is wrong.

Furthermore, "If single rank memories are found, they'll be marked with
0 bytes."

So this looks to me like this commit is breaking dual-ranked DIMMs
configs in order to fix single-ranked ones.

> And this is the reason why I decided to not do it. We do have the hardware
> but last time I checked none of them had functional EINJ.

You don't need EINJ - there's arch/x86/kernel/cpu/mce/inject.c with
which you can do sw-only injection to test the decoding paths.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
