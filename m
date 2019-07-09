Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33F5663A57
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2019 19:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGIR7i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 13:59:38 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:39464 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726133AbfGIR7i (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Jul 2019 13:59:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A73A7100E86C5;
        Tue,  9 Jul 2019 17:59:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1515:1516:1518:1534:1537:1560:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3876:3877:4321:5007:6114:6312:6642:6742:10004:10400:10848:10967:11232:11473:11658:11914:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:21810:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: earth64_192839cbcd232
X-Filterd-Recvd-Size: 1636
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jul 2019 17:59:32 +0000 (UTC)
Message-ID: <ff4ce6a96a922cff2dd929560b9167207b4899e9.camel@perches.com>
Subject: Re: [PATCH v2 2/4] edac: Add support for Amazon's Annapurna Labs L1
 EDAC
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hanna Hawa <hhhawa@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Date:   Tue, 09 Jul 2019 10:59:31 -0700
In-Reply-To: <20190709173229.0000135f@huawei.com>
References: <1562500658-14717-1-git-send-email-hhhawa@amazon.com>
         <1562500658-14717-3-git-send-email-hhhawa@amazon.com>
         <20190709173229.0000135f@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2019-07-09 at 17:32 +0800, Jonathan Cameron wrote:
> On Sun, 7 Jul 2019 14:57:36 +0300
[]
> > +#define ARM_CA57_CPUMERRSR_REPEAT		GENMASK(39, 32)
> > +#define ARM_CA57_CPUMERRSR_OTHER		GENMASK(47, 40)
> > +#define ARM_CA57_CPUMERRSR_FATAL		GENMASK(63, 63)

GENMASK_ULL


