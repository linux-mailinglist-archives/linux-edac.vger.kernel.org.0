Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9D836BD3C
	for <lists+linux-edac@lfdr.de>; Tue, 27 Apr 2021 04:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhD0CXv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Apr 2021 22:23:51 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:43599 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232680AbhD0CXs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 26 Apr 2021 22:23:48 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 39081580493;
        Mon, 26 Apr 2021 22:23:05 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Mon, 26 Apr 2021 22:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=wrMlmdamjsm6ICSrAXC+epu0/cW9QhG
        KJrdRhGJ+ItA=; b=urK9NpgqzzUKvit8H8SNBKWG5tIlGLCM67BMahNNhErXZOR
        5P06UHKMU+fbwfzowrghd5D0K6bF5pwzNYPWf7LFCcDDZpLA5uLJAcWULIIb1xoG
        +JzM0JnGMG08vOvPAwvHEifMYMIu+OpwfdcAyEegPphRwc921SUbTyL1efOhur++
        vinJNFJF2AjRk6A2e/QxgyVc3KDRrZjiYM6jcvj3WkO+hGCo7U9k268wI5wj0+Ge
        DAoI2RN4FDjTssSp2uAb3GBBQhJ0ORY1yZWsByvs947L1+PD1sIKL+2Sa9zn47PY
        J/ohd+ylsDVdWNBZqTdOZWpcWZyF8ivuvfmlnvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wrMlmd
        amjsm6ICSrAXC+epu0/cW9QhGKJrdRhGJ+ItA=; b=FCQvKHNuLK7uxaOV1ITjLI
        bahAtvx+rK/IORmdZRjfRpChnu1ysmixmtU0sAwIVx2gpkf9Vzd1qztA+MN6PJtX
        ha9hSOSTG16Z+TSUlX03D62AItNswSpZgbzLfHZzOWWdXiO8WU6XqjacQfJV2bbB
        GguGJHIrZWpNQa7a/24W4IOBSIjl+m6Z0gE5nOEiVN3caIMw642OQmpOnuoJ8ebb
        SSClrdxfjgTbAdkCJIz1+/UaC4r0IrjW7nC1TU/KyDGGSAuxOs3Vh9gs+TaN9txy
        uVsXqEML/ZPG/3x6PqmReK9edOUTx9Ir+yjePphInAJH3leLR7JlU5PimO2dyHfQ
        ==
X-ME-Sender: <xms:hnWHYBBB9WYlIQ61BEFE3GcRafvZj-JRiMZ9PSBOJTvv3pSuzDjUpg>
    <xme:hnWHYPgvl1Faql7KMbS3MayWRoikNE1aQtFJdcAximt6owpAjdKQbWpV392z-CHoE
    S_GiAy6-pVA0hShhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdduledgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:hnWHYMmUeNKeh56DmE7DUuK3G9BJ00YGxHLuq4lEpIpn4XrEf4NQBg>
    <xmx:hnWHYLxbM68hFL9O2TZplGIQc0t5vCF1uua5RNSiez-y-_2XJnTvmw>
    <xmx:hnWHYGS73JJdFEChCFIYj069L9ZZZEiWH-rRQmMI0zhfcIz8JjkJpQ>
    <xmx:iXWHYADyirFufMoXNX0TYqWYKNW_rCHOY0UctE8GtBn19aDpixm3EQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8ACE6A00079; Mon, 26 Apr 2021 22:23:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-403-gbc3c488b23-fm-20210419.005-gbc3c488b
Mime-Version: 1.0
Message-Id: <dd4286c6-c856-40c4-b1f8-060f76258d57@www.fastmail.com>
In-Reply-To: <20210421135500.3518661-1-arnd@kernel.org>
References: <20210421135500.3518661-1-arnd@kernel.org>
Date:   Tue, 27 Apr 2021 11:52:41 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Arnd Bergmann" <arnd@kernel.org>,
        "Stefan M Schaeckeler" <sschaeck@cisco.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Tony Luck" <tony.luck@intel.com>, "Joel Stanley" <joel@jms.id.au>,
        "Troy Lee" <troy_lee@aspeedtech.com>
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
        "James Morse" <james.morse@arm.com>,
        "Robert Richter" <rric@kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH]_EDAC/aspeed:_use_proper_format_string_for_printing?=
 =?UTF-8?Q?_resource?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On Wed, 21 Apr 2021, at 23:24, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On ARMv7, resource_size_t can be 64-bit, which breaks printing
> it as %x:
> 
> drivers/edac/aspeed_edac.c: In function 'init_csrows':
> drivers/edac/aspeed_edac.c:257:28: error: format '%x' expects argument 
> of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 
> 'long long unsigned int'} [-Werror=format=]
>   257 |         dev_dbg(mci->pdev, "dt: /memory node resources: first 
> page r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> 
> Use the special %pR format string to pretty-print the entire
> resource instead.
> 
> Fixes: edfc2d73ca45 ("EDAC/aspeed: Add support for AST2400 and AST2600")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/edac/aspeed_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index a46da56d6d54..6bd5f8815919 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
> @@ -254,8 +254,8 @@ static int init_csrows(struct mem_ctl_info *mci)
>  		return rc;
>  	}
>  
> -	dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> -		r.start, resource_size(&r), PAGE_SHIFT);
> +	dev_dbg(mci->pdev, "dt: /memory node resources: first page %pR, PAGE_SHIFT macro=0x%x\n",

Could probably drop the "first page " as well, but it's a dev_dbg() and not a big deal.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
