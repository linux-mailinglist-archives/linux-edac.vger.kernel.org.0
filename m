Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC8A374BA7
	for <lists+linux-edac@lfdr.de>; Thu,  6 May 2021 01:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhEEXCx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 May 2021 19:02:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53618 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhEEXCw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 May 2021 19:02:52 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8C53C20B7178;
        Wed,  5 May 2021 16:01:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C53C20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1620255715;
        bh=2G61eTtWodmZSE5qpbSyTo8m3sCaUsW/XU9eK3gDywc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyFJD2G79yPYAoGto1/xWyojG4YLWqGRsiqJ1Cd9U3sJsJ8lVbpX50a76uJMtvWwt
         qy4wWHsqcABGR9vcg1Hfn1hQdldtHJRwBU7O5c63vjgLAmNLyh4D8+bYji1hdRXSOv
         Iyv8l5shmCjpdtyQh+o5iFf2MtV1nOPCFUfwwNQI=
Date:   Wed, 5 May 2021 18:01:52 -0500
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
Message-ID: <20210505230152.GH4967@sequoia>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJMiRF8D3EG28d2V@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2021-05-06 00:55:00, Borislav Petkov wrote:
> On Wed, May 05, 2021 at 05:43:57PM -0500, Tyler Hicks wrote:
> > This is x86-specific 
> 
> That's because it is used by x86 currently. It shouldn't be hard to use
> it on another arch though as the machinery is pretty generic.
> 
> > and not applicable in our situation.
> 
> What is your situation? ARM?

Yes, though I'm not sure if those additional features are
important/useful enough for us to generalize that driver. The main
motivation here was just to prevent storage/network from being flooded
by obviously-bad nodes that haven't been offlined yet. :) 

Lei and others on cc will need to evaluate porting cec.c and what it
will gain them. Thanks again.

Tyler

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
