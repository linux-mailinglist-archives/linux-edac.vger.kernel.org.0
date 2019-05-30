Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D997C2FC05
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2019 15:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfE3NMM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 May 2019 09:12:12 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:46795 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726418AbfE3NMM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 May 2019 09:12:12 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 May 2019 09:12:11 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 4C1C718036BEB
        for <linux-edac@vger.kernel.org>; Thu, 30 May 2019 13:04:07 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 8215F3AB9;
        Thu, 30 May 2019 13:04:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2911:3138:3139:3140:3141:3142:3352:3622:3865:3866:3870:3871:3872:3873:4250:4321:4425:5007:6119:6742:10004:10400:10848:11026:11232:11658:11914:12043:12050:12438:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30054:30064:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: need41_405f0fead5e31
X-Filterd-Recvd-Size: 2102
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 May 2019 13:04:02 +0000 (UTC)
Message-ID: <8bc749161a8b8640ebdf78d693111d5350514638.camel@perches.com>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
From:   Joe Perches <joe@perches.com>
To:     hhhawa@amazon.com, Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 30 May 2019 06:04:00 -0700
In-Reply-To: <0ebfe8d7-3e0c-e0be-abd5-5e10b7d4b6aa@amazon.com>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
         <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
         <20190530115732.GB14088@kroah.com>
         <0ebfe8d7-3e0c-e0be-abd5-5e10b7d4b6aa@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 2019-05-30 at 15:52 +0300, hhhawa@amazon.com wrote:
> On 5/30/19 2:57 PM, Greg KH wrote:
> > On Thu, May 30, 2019 at 01:15:29PM +0300, Hanna Hawa wrote:
> > > +static void al_a57_edac_cpumerrsr(void *arg)
> > > +{
> > > +	struct edac_device_ctl_info *edac_dev =
> > > +		(struct edac_device_ctl_info *)arg;
> > No need for casting anything here, just assign it.  Doesn't checkpatch
> > catch this type of thing these days?  You did run it, right?
> 
> I did, but checkpatch didn't catch this. I'll fix in next patch-set.
> 
> Thanks for your review.

checkpatch is brainless about the types of variables/arguments.

coccinelle is another very useful tool so you could also run
scripts/coccicheck on your sources.

see: Documentation/dev-tools/coccinelle.rst


