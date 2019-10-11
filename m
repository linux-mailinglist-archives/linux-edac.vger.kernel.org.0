Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E895D3DB5
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfJKKu1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:50:27 -0400
Received: from smtprelay0131.hostedemail.com ([216.40.44.131]:38747 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726935AbfJKKu1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Oct 2019 06:50:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D27D5181D33FC;
        Fri, 11 Oct 2019 10:50:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2898:2911:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:3873:3874:4321:4425:5007:7903:10004:10400:10848:10967:11026:11232:11658:11914:12114:12295:12297:12438:12740:12760:12895:13019:13069:13311:13357:13439:14181:14659:14721:21080:21627:30012:30054:30070:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: fruit81_39593aec605d
X-Filterd-Recvd-Size: 2176
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Oct 2019 10:50:24 +0000 (UTC)
Message-ID: <414f6658c088b9ac96ec4dad1ef751610dd83ce3.camel@perches.com>
Subject: Re: [PATCH 05/19] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Oct 2019 03:50:23 -0700
In-Reply-To: <20191011071920.3fb8c45c@coco.lan>
References: <20191010202418.25098-1-rrichter@marvell.com>
         <20191010202418.25098-6-rrichter@marvell.com>
         <19dc4500bbfbb9d09f9730764a2b59353534358d.camel@perches.com>
         <20191011071920.3fb8c45c@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 2019-10-11 at 07:20 -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 10 Oct 2019 15:10:53 -0700
> Joe Perches <joe@perches.com> escreveu:
> 
> > On Thu, 2019-10-10 at 20:25 +0000, Robert Richter wrote:
> > > Reduce the indentation level in edac_mc_handle_error() a bit by using
> > > continue. No functional changes.  
> > 
> > Seems fine, but trivially below:
> > 
> > > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c  
> > []
> > > @@ -1171,37 +1171,38 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,  
> > []
> > > +		strcpy(p, dimm->label);
> > > +		p += strlen(p);
> > > +		*p = '\0';  
> > 
> > This *p = '\0' is unnecessary as the strcpy already did that.
> 
> True, but better to put it on a separate patch, as it makes
> easier to review if you don't mix code de-indent with changes.
> 
> Also, maybe there are other occurrences of this pattern.

Maybe 80 or so uses of paired

	strcpy(foo, bar);
	strlen(foo)

where another function like stpcpy, which doesn't exist
in the kernel, could have been used.



