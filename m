Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D073374AC7
	for <lists+linux-edac@lfdr.de>; Wed,  5 May 2021 23:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhEEVtq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 May 2021 17:49:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44284 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhEEVtp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 May 2021 17:49:45 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id D660220B7178;
        Wed,  5 May 2021 14:48:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D660220B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1620251328;
        bh=Lq9GMPC1OAbG9MC4A6dXXKYcRIfgiNTw6E8T5BWsHts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjIfl8kAu4zuy6l3rZpzPRQP94JtUMbP2G/6WsZtKmnNjH0NV8iZUTtUwgBGZODwj
         nLtPVFuwNnjglJSrxoVnkgPoAqbxxLBgj+z8+hlFjbbBXoXp3oRSVPkIGeyu3lSpAQ
         3JBydhlQ34ArzzP1BtY5LmmNVM2kpmJZg8SNuu2I=
Date:   Wed, 5 May 2021 16:48:46 -0500
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
Message-ID: <20210505214846.GE4967@sequoia>
References: <20210505173027.78428-1-wangglei@gmail.com>
 <YJLdZCcsgWG6TrKz@zn.tnic>
 <SJ0PR21MB199984A8B47FBEECEC5D11CE90599@SJ0PR21MB1999.namprd21.prod.outlook.com>
 <YJL1vU6HNBWPKy8g@zn.tnic>
 <20210505202357.GC4967@sequoia>
 <YJMIbB31oEDaXm0C@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJMIbB31oEDaXm0C@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2021-05-05 23:04:44, Borislav Petkov wrote:
> On Wed, May 05, 2021 at 03:23:57PM -0500, Tyler Hicks wrote:
> >  Would it be any more acceptable to add an
> > edac_mc_printk_ratelimited() macro, which uses printk_ratelimited(),
> > and then call that new macro from edac_ce_error()?
> 
> You guys are way off here: the intent of EDAC drivers is to accurately
> report errors for purposes of counting them and doing analysis on
> that collected data as to whether components are going wrong - not to
> ratelimit them as some nuisance output.
> 
> With breaking the EDAC reporting, you're barking up the wrong tree - if
> you don't want to see those errors, do not load the drivers. It is that
> simple.

As I understand it, the idea here wasn't to treat the log messages as a
nuisance that should be completely squelched. The counters are monitored
and provide the definitive way to detect large scale problems but the CE
log messages can be an easier-to-discover way for humans to identify
potential problems when, for example, centralized log aggregation and
indexing is in place.

The thought was that the full stream of log messages isn't necessary to
notice that there's a problem when they are being emitted at such a high
rate (500 per second). They're just filling up disk space and/or wasting
networking bandwidth at that point. Of course, the best course of action
here is to service the machine but there's still a period of time
between the CE errors popping up and the machine being serviced.

Tyler
