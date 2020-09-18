Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A4826FE83
	for <lists+linux-edac@lfdr.de>; Fri, 18 Sep 2020 15:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRNbJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Sep 2020 09:31:09 -0400
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:40246 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726126AbgIRNbI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Sep 2020 09:31:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 822A5181D303C;
        Fri, 18 Sep 2020 13:31:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3167:3352:3622:3865:3867:3868:3870:3871:3872:4321:5007:10004:10400:10848:11026:11232:11658:11914:12296:12297:12438:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21627:30025:30041:30054:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rail18_290ab6c2712b
X-Filterd-Recvd-Size: 1742
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 18 Sep 2020 13:31:06 +0000 (UTC)
Message-ID: <6f6be4f64a016c5be82b1fd21ce2402653a8961b.camel@perches.com>
Subject: Re: [PATCH v2] EDAC/mc_sysfs: Add missing newlines when printing
 {max,dimm}_location
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 18 Sep 2020 06:31:04 -0700
In-Reply-To: <20200918071227.GA6585@zn.tnic>
References: <1600051734-8993-1-git-send-email-wangxiongfeng2@huawei.com>
         <20200916170052.GO2643@zn.tnic>
         <591e613e-0b53-028f-08fd-3d62a35b8c4f@huawei.com>
         <20200917162537.GL31960@zn.tnic>
         <8ac6d481-e1c4-108e-dbec-b1e86b2d0e86@huawei.com>
         <20200918071227.GA6585@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 2020-09-18 at 09:12 +0200, Borislav Petkov wrote:
> On Fri, Sep 18, 2020 at 10:37:28AM +0800, Xiongfeng Wang wrote:
> > Thansk a lot. I will send another version. Also I will change the
> > 'snprintf' in 'dimmdev_location_show()' to 'scnprintf'
> 
> No need to send another one - I have everything locally and just amended
> it.

A generic question about sysfs is whether or not the
PAGE_SIZE buf output should be newline terminated or
not if an the buffer is completely filled and the
desired output cannot be newline terminated.

Likely not.

NUL termination without newline should be enough to
indicate overrun.


