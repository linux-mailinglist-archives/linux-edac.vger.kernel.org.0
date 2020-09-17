Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D0F26E009
	for <lists+linux-edac@lfdr.de>; Thu, 17 Sep 2020 17:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgIQPuc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Sep 2020 11:50:32 -0400
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:58732 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728200AbgIQPsn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 17 Sep 2020 11:48:43 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id CAB7D1813B78B;
        Thu, 17 Sep 2020 15:30:01 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F3AFD182CED28;
        Thu, 17 Sep 2020 15:28:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3167:3352:3622:3867:3868:3873:3874:4321:5007:8603:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12740:12760:12895:13019:13069:13255:13311:13357:13439:14659:14721:21080:21627:30025:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shock03_2c15c0f27123
X-Filterd-Recvd-Size: 1891
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Sep 2020 15:28:13 +0000 (UTC)
Message-ID: <707865b7ccc9168177940cd4f63cf7cb9ead2d63.camel@perches.com>
Subject: Re: [PATCH v2] EDAC/mc_sysfs: Add missing newlines when printing
 {max,dimm}_location
From:   Joe Perches <joe@perches.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     mchehab@kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Sep 2020 08:28:12 -0700
In-Reply-To: <591e613e-0b53-028f-08fd-3d62a35b8c4f@huawei.com>
References: <1600051734-8993-1-git-send-email-wangxiongfeng2@huawei.com>
         <20200916170052.GO2643@zn.tnic>
         <591e613e-0b53-028f-08fd-3d62a35b8c4f@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 2020-09-17 at 19:38 +0800, Xiongfeng Wang wrote:
> On 2020/9/17 1:00, Borislav Petkov wrote:
> > On Mon, Sep 14, 2020 at 10:48:54AM +0800, Xiongfeng Wang wrote:
> > > @@ -813,15 +817,21 @@ static ssize_t mci_max_location_show(struct device *dev,
> > >  				     char *data)
> > >  {
> > >  	struct mem_ctl_info *mci = to_mci(dev);
> > > -	int i;
> > > +	int i, n;
> > >  	char *p = data;
> > > +	unsigned int len = PAGE_SIZE;
> > >  
> > >  	for (i = 0; i < mci->n_layers; i++) {
> > > -		p += sprintf(p, "%s %d ",
> > > +		n = snprintf(p, len, "%s %d ",
> > >  			     edac_layer_name[mci->layers[i].type],
> > >  			     mci->layers[i].size - 1);
> > > +		p += n;
> > > +		len -= n;
> > 
> > What happens if that subtraction causes len to wrap around and become a
> > huge positive unsigned integer?

If you're really concerned about wrapping, use scnprintf.



