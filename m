Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040F9374B7B
	for <lists+linux-edac@lfdr.de>; Thu,  6 May 2021 00:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhEEWo6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 May 2021 18:44:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51320 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhEEWo5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 May 2021 18:44:57 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id DA25E20B7178;
        Wed,  5 May 2021 15:43:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA25E20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1620254640;
        bh=pL8Xp6g16d0Xa5UBDzhBQpk9BCJcc9jOdM34CZNLO+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6On/DN5sGrCBSDWVbMsnEJ47aqxlEuwLel66YsJGqh7MYR/2wolO2bumitY/9DsD
         RvqoKh1CVD/WvN+iiEn7TC1L7vIr0QMG2rfpxfpWSsOgIp60DjxVATDiEw6fVFDb5N
         uQycGa3Cf1vVxo5oUOXJvjDeEs0wWvRNZi3FRHtk=
Date:   Wed, 5 May 2021 17:43:57 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     wangglei <wangglei@gmail.com>,
        "Lei Wang (DPLAT)" <Wang.Lei@microsoft.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hang Li <hangl@microsoft.com>,
        Brandon Waller <bwaller@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH] EDAC: update edac printk wrappers to use
 printk_ratelimited.
Message-ID: <20210505224357.GG4967@sequoia>
References: <20210505173027.78428-1-wangglei@gmail.com>
 <YJLdZCcsgWG6TrKz@zn.tnic>
 <SJ0PR21MB199984A8B47FBEECEC5D11CE90599@SJ0PR21MB1999.namprd21.prod.outlook.com>
 <YJL1vU6HNBWPKy8g@zn.tnic>
 <20210505202357.GC4967@sequoia>
 <YJMIbB31oEDaXm0C@zn.tnic>
 <20210505214846.GE4967@sequoia>
 <YJMWBBBlQ6TwFad9@zn.tnic>
 <20210505221605.GF4967@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505221605.GF4967@sequoia>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2021-05-05 17:16:11, Tyler Hicks wrote:
> On 2021-05-06 00:02:44, Borislav Petkov wrote:
> > On Wed, May 05, 2021 at 04:48:46PM -0500, Tyler Hicks wrote:
> > > The thought was that the full stream of log messages isn't necessary to
> > > notice that there's a problem when they are being emitted at such a high
> > > rate (500 per second). They're just filling up disk space and/or wasting
> > > networking bandwidth at that point.
> > 
> > I already asked about this but lemme point it out again: have you guys
> > looked at drivers/ras/cec.c ?
> 
> We'll have a closer look. Thanks for the pointer!

This is x86-specific and not applicable in our situation.

Tyler

> 
> Tyler
> 
> > 
> > With that there won't be *any* error reports in dmesg and it will even
> > poison and offline pages which generate excessive errors so that ...
> > 
> > > Of course, the best course of action here is to service the machine
> > > but there's still a period of time between the CE errors popping up
> > > and the machine being serviced.
> > 
> > ... you'll have ample time to service the machine.
> > 
> > -- 
> > Regards/Gruss,
> >     Boris.
> > 
> > https://people.kernel.org/tglx/notes-about-netiquette
> > 
