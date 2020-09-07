Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE9325F2D3
	for <lists+linux-edac@lfdr.de>; Mon,  7 Sep 2020 07:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgIGFyo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Sep 2020 01:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgIGFyn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Sep 2020 01:54:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5283FC061573;
        Sun,  6 Sep 2020 22:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=DLtDog/Sr3T09dS0hr8djLFY4+UOXPYwaMXYNsd+eOk=; b=VgLRVDp/TPdIEIEivGZWfrd6v6
        xkpj/etrmTs2ORqCyJ7aTIlUAEb+G3LIMxYm8FHYkmFXLTYRq96NybCz325oD/vK/SKgfjD3ucV3O
        0Zs5t9R7ykIOILdYyb7y1M4s28ICWAumOGM70S/a6etH4vxjzQLmlkjYeKzXpSdC1j2ZsoIA8PXfe
        +RksZJRmB63xOree9TDvIXvCHojkPDLv2GMkJe3dMwP9DTYWQEFmbXKna3fxXFRY3jyGcwEvtUJYw
        7wENDGpF+vqSCmF5+dlCQS//m8oukAIGtH13Xl0wOKQye2XFpPVzyLgsmvNIPQO2RdEy0ApqwzQga
        8xXDeCVw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFA6u-0003cz-Ar; Mon, 07 Sep 2020 05:54:36 +0000
Subject: Re: [PATCH v2 2/3] soc: sifive: Add SiFive specific Cadence DDR
 controller driver
To:     Yash Shah <yash.shah@sifive.com>, robh+dt@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com
Cc:     aou@eecs.berkeley.edu, james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com
References: <1599457679-8947-1-git-send-email-yash.shah@sifive.com>
 <1599457679-8947-3-git-send-email-yash.shah@sifive.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <697413e6-8f44-8db4-6434-0f22984bdc9c@infradead.org>
Date:   Sun, 6 Sep 2020 22:54:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1599457679-8947-3-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 9/6/20 10:47 PM, Yash Shah wrote:
> diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
> index 58cf8c4..f41d8fe 100644
> --- a/drivers/soc/sifive/Kconfig
> +++ b/drivers/soc/sifive/Kconfig
> @@ -7,4 +7,10 @@ config SIFIVE_L2
>  	help
>  	  Support for the L2 cache controller on SiFive platforms.
>  
> +config SIFIVE_DDR
> +	bool "Sifive DDR controller driver"
> +	help
> +	  Support for the management of cadence DDR controller on SiFive

	                                Cadence

> +	  platforms.
> +
>  endif


-- 
~Randy

