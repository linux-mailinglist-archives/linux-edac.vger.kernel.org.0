Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5141EF075A
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2019 21:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfKEU43 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 15:56:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51958 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfKEU43 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Nov 2019 15:56:29 -0500
Received: from zn.tnic (p200300EC2F0EF000C920E9AF573256AE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f000:c920:e9af:5732:56ae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D94FF1EC0CBF;
        Tue,  5 Nov 2019 21:56:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572987384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BPmz11qaWk5KKC62u0A+7dhcrZMhWmQQJP0c9+8ICb0=;
        b=Sgvrz0hbpeZbk2/vTKkvoh3uPuIg91T0NaiOW/qtlfxxIUV1DqLr6JnYafmlkVoQ7+7q7J
        o2S1ERb03jm3UH7ftmm5xRrJr0qwlLU6dyKNlxjD+DRemCcmIsPq46m9UaBm0c6AWPU7FR
        ZTh2coqatOSe+vnCsGXo3r4sgVUyp8w=
Date:   Tue, 5 Nov 2019 21:56:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Subject: Re: [RFC][PATCH] x86, mce, therm_throt: Optimize notifications of
 thermal throttle
Message-ID: <20191105205617.GF28418@zn.tnic>
References: <20191025001924.10199-1-srinivas.pandruvada@linux.intel.com>
 <20191105144411.GC28418@zn.tnic>
 <810bfb95a42090ff64f86e4154e2bd2cfda29f27.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <810bfb95a42090ff64f86e4154e2bd2cfda29f27.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 05, 2019 at 12:36:32PM -0800, Srinivas Pandruvada wrote:
> > That wants to be a bool judging by the context it is used in.
> I can change to bool, just didn't use it
> https://yarchive.net/comp/linux/bool.html

And are you using it in a union or where the size of bool - which is
implementation-specific - plays any role, esp. in your particular use
case?

> They are architectural MSRs and the fact that we are getting called
> means that they are enabled by looking at CPUID bits.

If the CPUID bits guarantees their presence, then the error handling is
not absolutely necessary.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
