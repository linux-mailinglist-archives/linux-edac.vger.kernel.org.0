Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA60D33C7
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 00:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJJWK5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 18:10:57 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:56900 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725978AbfJJWK5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 18:10:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 31CB2182CED2A;
        Thu, 10 Oct 2019 22:10:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2898:3138:3139:3140:3141:3142:3622:3865:3870:3871:3874:4321:5007:7903:10004:10400:11026:11232:11658:11914:12048:12114:12295:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30070:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: news25_4231f6f182805
X-Filterd-Recvd-Size: 1564
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Oct 2019 22:10:54 +0000 (UTC)
Message-ID: <19dc4500bbfbb9d09f9730764a2b59353534358d.camel@perches.com>
Subject: Re: [PATCH 05/19] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
From:   Joe Perches <joe@perches.com>
To:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Cc:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 10 Oct 2019 15:10:53 -0700
In-Reply-To: <20191010202418.25098-6-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
         <20191010202418.25098-6-rrichter@marvell.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 2019-10-10 at 20:25 +0000, Robert Richter wrote:
> Reduce the indentation level in edac_mc_handle_error() a bit by using
> continue. No functional changes.

Seems fine, but trivially below:

> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
[]
> @@ -1171,37 +1171,38 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
[]
> +		strcpy(p, dimm->label);
> +		p += strlen(p);
> +		*p = '\0';

This *p = '\0' is unnecessary as the strcpy already did that.


