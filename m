Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21691374FE2
	for <lists+linux-edac@lfdr.de>; Thu,  6 May 2021 09:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhEFHRe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 May 2021 03:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhEFHRe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 May 2021 03:17:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD5BB61106;
        Thu,  6 May 2021 07:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620285396;
        bh=E3+ulk7TNn7yLBg14VbzBiJFH+IBeMEzZPW/Kp5aFQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nBBNCoQxtcLiR+5VCDtC2d6ruYl1Ksg/hdNLQT8AtjRgC2C7QtM7U0UW2ULaWNfAg
         IAIpiGIt/Rn9H42QzRANiQtckXAczjXsOagegFy1P4Mta3a+9Hz0ovhfGqmasdkEhS
         7qByO0A4PE8knwfyqltVn1afLRrsD5NXRu2SHuDAJCImkKRUbBIZ7oSRhj/mXRk1Zh
         HTDugDBg0TI4ASz/6GcstZeXzkQ3Vuli6r2M9sKT/Sa6fXzzAh5mYao24pr3I/j15J
         ee+XuGuJyFnWITgAsCcZ7F3U+XXS8+4sglQ0SXb4/LsfuAoPspGP4LjPwxqR8LGLkY
         AC2x0ypVMMgSw==
Date:   Thu, 6 May 2021 09:16:30 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Borislav Petkov <bp@alien8.de>, wangglei <wangglei@gmail.com>,
        "Lei Wang (DPLAT)" <Wang.Lei@microsoft.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hang Li <hangl@microsoft.com>,
        Brandon Waller <bwaller@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH] EDAC: update edac printk wrappers to use
 printk_ratelimited.
Message-ID: <20210506091630.168c7887@coco.lan>
In-Reply-To: <20210505230152.GH4967@sequoia>
References: <YJLdZCcsgWG6TrKz@zn.tnic>
        <SJ0PR21MB199984A8B47FBEECEC5D11CE90599@SJ0PR21MB1999.namprd21.prod.outlook.com>
        <YJL1vU6HNBWPKy8g@zn.tnic>
        <20210505202357.GC4967@sequoia>
        <YJMIbB31oEDaXm0C@zn.tnic>
        <20210505214846.GE4967@sequoia>
        <YJMWBBBlQ6TwFad9@zn.tnic>
        <20210505221605.GF4967@sequoia>
        <20210505224357.GG4967@sequoia>
        <YJMiRF8D3EG28d2V@zn.tnic>
        <20210505230152.GH4967@sequoia>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 5 May 2021 18:01:52 -0500
Tyler Hicks <tyhicks@linux.microsoft.com> escreveu:

> On 2021-05-06 00:55:00, Borislav Petkov wrote:
> > On Wed, May 05, 2021 at 05:43:57PM -0500, Tyler Hicks wrote: =20
> > > This is x86-specific  =20
> >=20
> > That's because it is used by x86 currently. It shouldn't be hard to use
> > it on another arch though as the machinery is pretty generic.
> >  =20
> > > and not applicable in our situation. =20
> >=20
> > What is your situation? ARM? =20
>=20
> Yes, though I'm not sure if those additional features are
> important/useful enough for us to generalize that driver. The main
> motivation here was just to prevent storage/network from being flooded
> by obviously-bad nodes that haven't been offlined yet. :)=20

Well, if a machine starts to produce 500+ errors per second,
then it should be offlined as soon as possible, as otherwise bad results
will be produced ;-)

See, the CE error reporting mechanism is meant to be used together
with some error correction code algorithm like the ones used on ECC
memories. Such algorithms are designed to detect a single errored bit=20
with a change usually at the ~10=E2=81=BB4 to 10^-7 order (the precision
depends on how many bits are used and what algorithm is used), but=20
if there are two wrong bits at the same word, the chance to detect=20
is a lot lower.

So, keeping the server enabled up to the point that it would consume
enough resources at the storage/network to bother someone sounds a=20
terrible idea, as sooner or later it will miss an error or produce
an uncorrected event ;-)

Besides that, if you're running rasdaemon to capture the hardware errors,=20
the storage will also be flooded by something like that, even if you
disable them from going to syslog via=20
sys/module/edac_core/parameters/edac_mc_log_ce.

Now, the question is: are those 500+ errors per second a real hardware
problem, or is it due to some broken error report mechanism?

In the latter case, the driver or the hardware that it is producing=20
invalid errors should be fixed.

>=20
> Lei and others on cc will need to evaluate porting cec.c and what it
> will gain them. Thanks again.

Regards,
Mauro
