Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAFF51BC9
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 21:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfFXT5B (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 15:57:01 -0400
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:58495 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727282AbfFXT5B (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 15:57:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1FD7F100E86C5;
        Mon, 24 Jun 2019 19:57:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:4250:4321:5007:6119:6691:8557:8957:9036:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12297:12438:12740:12760:12895:13069:13161:13229:13311:13357:13439:14040:14659:14721:21080:21220:21451:21627:30054:30079:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: fold16_1fd688a2af52b
X-Filterd-Recvd-Size: 2354
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 19:56:58 +0000 (UTC)
Message-ID: <c40261d18ff593767a026d0392d44f322b4a3b33.camel@perches.com>
Subject: Re: [PATCH v6 1/1] EDAC, mellanox: Add ECC support for BlueField
 DDR4
From:   Joe Perches <joe@perches.com>
To:     Shravan Kumar Ramani <sramani@mellanox.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Liming Sun <lsun@mellanox.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 12:56:57 -0700
In-Reply-To: <176e13c80688f9a37161091e31ade487db6d4c2e.1561400421.git.sramani@mellanox.com>
References: <cover.1561400421.git.sramani@mellanox.com>
         <176e13c80688f9a37161091e31ade487db6d4c2e.1561400421.git.sramani@mellanox.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 2019-06-24 at 14:42 -0400, Shravan Kumar Ramani wrote:
> Add ECC support for Mellanox BlueField SoC DDR controller.
> This requires SMC to the running Arm Trusted Firmware to report
> what is the current memory configuration.
[]
> diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
[]
> @@ -0,0 +1,381 @@
[]
> +#define MLXBF_ECC_CNT__SERR_CNT_SHIFT 0
> +#define MLXBF_ECC_CNT__SERR_CNT_MASK 0xffff
> +#define MLXBF_ECC_CNT__DERR_CNT_SHIFT 16
> +#define MLXBF_ECC_CNT__DERR_CNT_MASK 0xffff

[multiple variants of #defines like the above]

[]

> +	serr = (dram_syndrom >> MLXBF_SYNDROM__SERR_SHIFT) &
> +		MLXBF_SYNDROM__SERR_MASK;
> +	derr = (dram_syndrom >> MLXBF_SYNDROM__DERR_SHIFT) &
> +		MLXBF_SYNDROM__DERR_MASK;
> +	syndrom = (dram_syndrom >> MLXBF_SYNDROM__SYN_SHIFT) &
> +		MLXBF_SYNDROM__SYN_MASK;

To improve readability and reduce possible copy/paste errors,
these would all benefit from a macro like

#define MLXBF_SM(val, type) 	\
	(((val) >> (MLXBF_ ## type ## _SHIFT)) & (MLXBF_ ## type ## _MASK)))

So these uses could become:

	serr = MLXBF_SM(dram_syndrom, SYNDROM__SERR);
	derr = MLXBF_SM(dram_syndrom, SYNDROM__DERR);
	syndrom =
MLXBF_SM(dram_syndrom, SYN);

etc...


